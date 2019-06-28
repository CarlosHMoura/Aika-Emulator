unit ServerSocket;

interface

uses
  Windows, SysUtils, Winsock2, Classes;

type
  TServerRecvThread = class(TThread)
  public
    procedure Execute; override;
  end;

type
  TServerLoopThread = class(TThread)
  public
    RecvThread: TServerRecvThread;

    procedure Execute; override;
  end;

type
  TConnection = packed record
    Socket: TSocket;
    Ip: string;
    IsActive: Boolean;
    ActiveTime: TTime;

  public
    procedure Destroy;
    function ReceiveData: Boolean;

    function SendPacket(const Packet; Size: WORD): Boolean;
  end;

type
  TServerSocket = class(TObject)
    Sock: TSocket;
    ServerAddr: TSockAddrIn;
    ServerName: string;
    IsActive: Boolean;
    ChannelId: BYTE;

    Connections: ARRAY [1 .. 100] OF TConnection;

    ServerLoopThread: TServerLoopThread;

    { Client }
    function FreeClientId: BYTE;
    procedure AddConnection(const Socket: TSocket; const Info: PSockAddr);

    { Start }
    function StartSocket: Boolean;
    function StartMySQL: Boolean;
    function StartServer: Boolean;

    { Disconnect }
    procedure Disconnect(Index: BYTE); overload;
    procedure Disconnect(var Connection: TConnection); overload;

    { Packet Control }
    procedure PacketControl(var Connection: TConnection;
      var Buffer: ARRAY OF BYTE; Size: WORD; initialOffset: WORD);
  end;

implementation

uses
  ServerUtils, GlobalDefs, Packets, EncDec, PacketHandler, DateUtils, Load,
  DataBase;

{ ServerSocket }

function TServerSocket.FreeClientId: BYTE;
var
  i: BYTE;
begin
  Result := 0;

  for i := Low(Connections) to High(Connections) do
  begin
    if (Connections[i].Ip = '') then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TServerSocket.AddConnection(const Socket: TSocket;
  const Info: PSockAddr);
var
  Index: BYTE;
  address: TSockAddrIn;
  addressLength: integer;
begin
  Index := Self.FreeClientId;

  if (Index = 0) then
    Exit;

  Self.Connections[Index].Socket := Socket;

  getpeername(Socket, TSockAddr(address), addressLength);

  Self.Connections[Index].Ip := string(inet_ntoa(address.sin_addr));

  Self.Connections[Index].IsActive := True;

  Self.Connections[Index].ActiveTime := Now;
end;

function TServerSocket.StartSocket: Boolean;
var
  wsa: TWsaData;
begin
  Result := false;

  if (WSAStartup(MAKEWORD(2, 2), wsa) <> 0) then
  begin
    Logger.Write('Ocorreu um erro ao inicializar o Winsock 2.',
      TLogType.Warnings);
    Exit;
  end;

  Self.Sock := Socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
  Self.ServerAddr.sin_family := AF_INET;
  Self.ServerAddr.sin_port := htons(ServerConf.Port);
  Self.ServerAddr.sin_addr.S_addr :=
    inet_addr(PAnsiChar(AnsiString(ServerConf.Ip)));

  if (bind(Self.Sock, TSockAddr(Self.ServerAddr), sizeof(Self.ServerAddr)) = -1)
  then
  begin
    Logger.Write('Ocorreu um erro ao configurar o socket.', TLogType.Warnings);
    closesocket(Self.Sock);
    Sock := INVALID_SOCKET;
    Exit;
  end;

  if (listen(Sock, 100) = -1) then
  begin
    Logger.Write('Ocorreu um erro ao colocar o socket em modo de escuta.',
      TLogType.Warnings);
    closesocket(Sock);
    Sock := INVALID_SOCKET;
    Exit;
  end;

  Result := True;
end;

function TServerSocket.StartMySQL: Boolean;
begin
  Result := False;

  DBQuery := TQuery.Create(AnsiString(ServerConf.MySQLServer), ServerConf.MySQLPort,
  AnsiString(ServerConf.MySQLLogin), AnsiString(ServerConf.MySQLPass),
  AnsiString(ServerConf.MySQLDataBase));

  if(DBQuery.MySQL.Connected) then
  begin
    Logger.Write('MySQL iniciado com sucesso na porta ' +
      ServerConf.MySQLPort.ToString + ' com o usuário [' + ServerConf.MySQLLogin
      + '].', TLogType.Load);
    Result := True;
  end;
end;

function TServerSocket.StartServer: Boolean;
begin
  Result := false;

  if not(TLoad.InitServerConfig) then
    Exit;

  if not(Self.StartSocket) then
    Exit;

  if not(Self.StartMySQL) then
    Exit;

  IsActive := True;

  ZeroMemory(@Self.Connections, sizeof(Connections));

  Logger.Write('LoginServer iniciado com sucesso [Porta: ' +
    ServerConf.Port.ToString + '].', TLogType.Load);

  ServerLoopThread := TServerLoopThread.Create;

  Result := True;
end;

procedure TServerSocket.Disconnect(Index: BYTE);
begin
  if (Self.Connections[Index].IsActive) then
    Self.Connections[Index].Destroy;
end;

procedure TServerSocket.Disconnect(var Connection: TConnection);
begin
  if (Connection.IsActive) then
    Connection.Destroy;
end;

procedure TServerSocket.PacketControl(var Connection: TConnection;
  var Buffer: ARRAY OF BYTE; Size: WORD; initialOffset: WORD);
var
  Header: TPacketHeader;
begin
  ZeroMemory(@Header, sizeof(Header));

  try
    if (initialOffset > 0) then
    begin
      Move(Buffer[initialOffset], Buffer[0], Size);
    end;

    TEncDec.Decrypt(Buffer, Size);
    Move(Buffer, Header, sizeof(Header));
  finally
    case Header.Code of

      $81:
        TPacketHandler.CheckToken(Connection, Buffer);

    end;
  end;
end;

procedure TConnection.Destroy;
begin
  closesocket(Self.Socket);
  Self.IsActive := false;
  ZeroMemory(@Self, sizeof(Self));
end;

function TConnection.ReceiveData: Boolean;
var
  RecvBuffer: ARRAY [0 .. 2000] OF BYTE;
  initialOffset: WORD;
  RecvBytes: WORD;
begin
  Result := false;

  ZeroMemory(@RecvBuffer, sizeof(RecvBuffer));

  RecvBytes := Recv(Self.Socket, RecvBuffer, sizeof(RecvBuffer), 0);

  if RecvBytes <= 0 then
  begin
    Server.Disconnect(Self);
    Exit;
  end;

  if (RecvBytes < sizeof(TPacketHeader)) then
  begin
    Result := True;
    Exit;
  end;

  initialOffset := 0;

  if (RecvBytes > 1116) then
  begin
    initialOffset := 4;
    dec(RecvBytes, 4);
  end;

  Server.PacketControl(Self, RecvBuffer, RecvBytes, initialOffset);
end;

function TConnection.SendPacket(const Packet; Size: WORD): Boolean;
var
  RetVal: integer;
  Buffer: ARRAY [0 .. 2000] OF BYTE;
begin
  Result := false;

  ZeroMemory(@Buffer, Size);
  Move(Packet, Buffer, Size);

  TEncDec.Encrypt(@Buffer, Size);

  if not Self.IsActive then
    Exit;

  RetVal := Send(Socket, Buffer, Size, 0);
  if (RetVal = SOCKET_ERROR) then
  begin
    Logger.Write('Send failed with error: ' + IntToStr(WSAGetLastError),
      TLogType.Errors);

    Self.Destroy;
    Exit;
  end;

  Result := True;
end;

procedure TServerLoopThread.Execute;
var
  newSocket: TSocket;
  ClientInfo: PSockAddr;
begin

  RecvThread := TServerRecvThread.Create;

  while (Server.IsActive) do
  begin
    ClientInfo := Nil;

    try
      newSocket := accept(Server.Sock, ClientInfo, nil);

      if (newSocket <> INVALID_SOCKET) then
      begin
        Server.AddConnection(newSocket, ClientInfo);
      end
      else
        Logger.Write('Error accepting socket. Error #' +
          IntToStr(WSAGetLastError), TLogType.Errors);

    except
      continue;
    end;

    Sleep(100);
  end;
end;

procedure TServerRecvThread.Execute;
var
  i: BYTE;
begin

  while (Server.IsActive) do
  begin
    for i := Low(Server.Connections) to High(Server.Connections) do
    begin
      if not(Server.Connections[i].IsActive) then
        continue;

      if not(Server.Connections[i].ReceiveData) or
        (MillisecondsBetween(Now, Server.Connections[i].ActiveTime) >= 1000)
      then
        Server.Disconnect(i);

      Sleep(100);
    end;
    Sleep(100);
  end;
end;

end.
