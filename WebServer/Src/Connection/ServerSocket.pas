unit ServerSocket;

interface

uses
  IdHTTPServer, IdCustomHTTPServer, IdContext, Classes,
  StrUtils, IdServerIOHandler, IdSSL, IdSSLOpenSSL, Windows, SysUtils;

type
  TServerSocket = class(TObject)
    Requests: TIdHTTPServer;
    SSLServer: TIdServerIOHandlerSSLOpenSSL;

  private
    procedure OnGetCommand(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);

    function GetActive: Boolean;
    procedure SetActive(Active: Boolean);
  public
    property IsActive: Boolean read GetActive write SetActive;

    constructor Create;
    function StartServer: Boolean;
    procedure CloseServer;

    function RequestControl(URL: string; Param: TStrings): string;
  end;

implementation

uses
  GlobalDefs, ServerUtils, TokenHandlers, DataBase;

{ TServerSocket }

procedure TServerSocket.CloseServer;
begin

end;

constructor TServerSocket.Create;
begin
  Self.Requests := TIdHTTPServer.Create(Nil);
  Self.Requests.DefaultPort := ServerConfig.Port;
  Self.Requests.OnCommandGet := Self.OnGetCommand;

  SSLServer := TIdServerIOHandlerSSLOpenSSL.Create(Nil);
  SSLServer.SSLOptions.CertFile := 'themu.pem';
  SSLServer.SSLOptions.KeyFile := 'themu.pem';
  SSLServer.SSLOptions.Mode := sslmServer;
  SSLServer.SSLOptions.VerifyDepth := 1;

  Self.Requests.IOHandler := SSLServer;

  Query := TQuery.Create(AnsiString(ServerConfig.MySQLServer), ServerConfig.MySQLPort,
  AnsiString(ServerConfig.MySQLLogin), AnsiString(ServerConfig.MySQLPass),
  AnsiString(ServerConfig.MySQLDataBase));

  Logger.Write('WebServer conectado ao MYSQL [' +
  ServerConfig.MySQLLogin + '] na porta ' +
  ServerConfig.MySQLPort.ToString, TlogType.Load);

  inherited Create;
end;

function TServerSocket.GetActive: Boolean;
begin
  Result := Self.Requests.Active;
end;

procedure TServerSocket.OnGetCommand(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.ContentText := Self.RequestControl(ARequestInfo.Document, ARequestInfo.Params);
end;

function TServerSocket.RequestControl(URL: string; Param: TStrings): string;
begin
  case AnsiIndexStr(URL, ['/member/aika_get_token.asp',
    '/servers/aika_get_chrcnt.asp',
    '/servers/serv00.asp',
    '/servers/aika_reset_flag.asp']) of

    0:
      TTokenHandler.AikaGetToken(Param, Result);

    1:
      TTokenHandler.AikaGetChrCnt(Param, Result);

    2:
      TTokenHandler.GetServerPlayers(Result);

    3:
      TTokenHandler.AikaResetFlag(Param, Result);

    //4:
      //TAuthHandlers.AikaCreateAccount(Param, Result);

  end;
end;

procedure TServerSocket.SetActive(Active: Boolean);
begin
  Self.Requests.Active := Active;
end;

function TServerSocket.StartServer: Boolean;
begin
  Self.SetActive(True);

  Result := False;

  if (Self.GetActive) then
  begin
    Result := True;

    Logger.Write('Token Server iniciado com sucesso [Porta: '
    + IntToStr(ServerConfig.Port) + '].', TLogType.Load);
  end
  else
  begin
    Logger.Write('Erro ao iniciar o TokenServer.', TLogType.Errors);
  end;
end;

end.
