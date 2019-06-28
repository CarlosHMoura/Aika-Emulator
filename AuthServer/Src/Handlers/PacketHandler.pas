unit PacketHandler;

interface

uses
  Windows, SysUtils, ServerSocket, Data.DB;

type
  TPacketHandler = class(TObject)
    class procedure CheckToken(Connection: TConnection; Buffer: Array of Byte);
  end;

implementation

uses
  GlobalDefs, ServerUtils, Packets, DateUtils, MMSystem;

{ TPacketHandler }

class procedure TPacketHandler.CheckToken(Connection: TConnection;
  Buffer: array of Byte);
var
  Packet: TCheckTokenPacket absolute Buffer;
  Pacote: TResponseLoginPacket;
  Player: TPlayerAuth;

  Username, Token: String;
begin
  Username := String(Packet.Username);
  Token := String(Packet.Token);

  DBQuery.SetQuery('SELECT * FROM accounts WHERE username = :pusername');
  DBQuery.AddParameter('pusername', AnsiString(Username));
  DBQuery.Run();

  if (DBQuery.Query.IsEmpty) then // se a conta não for encontrada, retorna 0
  begin
    Logger.Write('Usuário [' + Username + '] não foi encontrado no db.',
      TlogType.Warnings);
    Connection.Destroy;
    Exit;
  end;

  Player.ID := DBQuery.Query.FieldByName('id').AsInteger;
  Player.Username := DBQuery.Query.FieldByName('username').AsString;
  Player.Password := DBQuery.Query.FieldByName('password').AsString;
  Player.PasswordHash := DBQuery.Query.FieldByName('password_hash').AsString;
  Player.LastTokenTime :=
    StrToDateTime(DBQuery.Query.FieldByName('last_token_creation_time')
    .AsString);
  Player.Token := DBQuery.Query.FieldByName('last_token').AsString;
  Player.Status := Byte(DBQuery.Query.FieldByName('account_status').AsInteger);
  Player.Nation := Byte(DBQuery.Query.FieldByName('nation').AsInteger);

  if (Player.Token <> Token) then
  begin
    Logger.Write('Usuário [' + Player.Username +
      '] tentou logar com um token diferente.', TlogType.Warnings);
    Connection.Destroy;
    Exit;
  end;

  if (SecondsBetween(Now, Player.LastTokenTime) > 300) then
  begin
    Logger.Write('Usuário [' + Player.Username +
      '] tentou logar com um token fora do tempo de uso.', TlogType.Warnings);
    Connection.Destroy;
    Exit;
  end;

  ZeroMemory(@Pacote, SizeOf(TResponseLoginPacket));
  Pacote.Header.Size := SizeOf(TResponseLoginPacket);
  Pacote.Header.Code := $82;

  Pacote.Index := Player.ID;
  Pacote.Time := TimeGetTime;

  Pacote.Nation := TCitizenship(Player.Nation);

  Connection.SendPacket(Pacote, Pacote.Header.Size);
  Connection.Destroy;

  Logger.Write('Novo login de ' + Packet.Username + ' em ' + '[' +
    DateTimeToStr(Now) + '].', TlogType.ClientConnect);
end;

end.
