unit TokenHandlers;

interface

uses
  Windows, SysUtils, Classes, Data.DB;

type
  TTokenHandler = class(TObject)
    class procedure AikaGetToken(Param: TStrings; var Response: String);
    class procedure AikaGetChrCnt(Param: TStrings; var Response: String);
    class procedure GetServerPlayers(var Response: String);
    class procedure AikaResetFlag(Param: TStrings; var Response: String);
  end;

implementation

uses
  ServerUtils, GlobalDefs, GlobalFuncs;

{ TTokenHandler }

class procedure TTokenHandler.AikaGetToken(Param: TStrings;
  var Response: String);
var
  Username, Password: String;
  Player: TPlayerAuth;
begin
  // pega o username em https://*:8090/member/aika_get_token.asp?id=
  Username := Param.ValueFromIndex[0];
  // pega o username em https://*:8090/member/aika_get_token.asp?pw=
  Password := Param.ValueFromIndex[1];

  // Query do MYSQL pra pegar a conta no Banco de Dados pelo username
  Query.SetQuery('SELECT * FROM accounts WHERE username = :pusername');
  Query.AddParameter('pusername', AnsiString(Username));
  Query.Run();

  if (Query.Query.IsEmpty) then // se a conta n�o for encontrada, retorna 0
  begin
    Response := '0'; // conta n�o encontrada
    Logger.Write('Usu�rio [' + Username + '] n�o foi encontrado no db.',
      TlogType.Warnings);
    Exit;
  end;

  // pega os valores na struct player da query do banco de dados
  Player.Username := Query.Query.FieldByName('username').AsString;
  Player.Password := Query.Query.FieldByName('password').AsString;
  Player.PasswordHash := Query.Query.FieldByName('password_hash').AsString;
  Player.LastTokenTime :=
    StrToDateTime(Query.Query.FieldByName('last_token_creation_time').AsString);
  Player.Status := BYTE(Query.Query.FieldByName('account_status').AsInteger);

  // se a senha for diferente, ent�o retorna -1
  if (Password <> Player.PasswordHash) then
  begin
    Response := '-1'; // senha incorreta
    Logger.Write('Usu�rio [' + Player.Username + '] errou a senha.',
      TlogType.Warnings);
    Exit;
  end;

  case Player.Status of
    2:
      begin
        Response := '-2'; // msg: conta cancelada
        Exit;
      end;

    8:
      begin
        Response := '-8'; // msg: conta bloqueada entre em contato com o suporte
        Logger.Write('Usu�rio [' + Player.Username + '] est� banido.',
          TlogType.Warnings);
        Exit;
      end;

    10:
      begin
        Response := '-10'; // msg: n�o � usu�rio cbt
        Exit;
      end;
  end;

  Player.LastTokenTime := Now; // pega a data/hora atuais geradas pelo token

  // gera o md5 da senha_hash + o md5 do tempo do token
  Player.Token := TFunctions.StringToMD5
    (TFunctions.StringToMD5(Player.PasswordHash) + TFunctions.StringToMD5
    (DateTimeToStr(Player.LastTokenTime)));

  // guarda os dados no banco (token e tempo de token)
  Query.SetQuery('UPDATE accounts SET last_token=:plast_token,' +
    ' last_token_creation_time=:plast_token_creation_time WHERE username =:pusername');
  Query.AddParameter('pusername', AnsiString(Player.Username));
  Query.AddParameter('plast_token', AnsiString(String(Player.Token)));
  Query.AddParameter('plast_token_creation_time',
    AnsiString(DateTimeToStr(Player.LastTokenTime)));
  Query.Query.ExecSQL;

  Logger.Write('Token [' + Player.Token + '] criado para [' + Player.Username +
    '] em ' + DateTimeToStr(Player.LastTokenTime) + '.',
    TlogType.ClientConnect);

  // envia o token pro client
  Response := Player.Token;
end;

class procedure TTokenHandler.AikaGetChrCnt(Param: TStrings;
  var Response: String);
var
  Username, Password: String;
  Player: TPlayerAuth;
  CharCount: Integer;
begin
  // pega o username em https://*:8090/member/aika_get_chrcnt.asp?id=
  Username := Param.ValueFromIndex[0];
  // pega o username em https://*:8090/member/aika_get_chrcnt.asp?pw=
  Password := Param.ValueFromIndex[1];

  // Query do MYSQL pra pegar a conta no Banco de Dados pelo username
  Query.SetQuery('SELECT * FROM accounts WHERE username = :pusername');
  Query.AddParameter('pusername', AnsiString(Username));
  Query.Run();

  if (Query.Query.IsEmpty) then // se a conta n�o for encontrada, retorna 0
  begin
    Response := '0'; // conta n�o encontrada
    Exit;
  end;

  // pega os valores na struct player da query do banco de dados
  Player.ID := Query.Query.FieldByName('id').AsInteger;
  Player.Username := Query.Query.FieldByName('username').AsString;
  Player.Password := Query.Query.FieldByName('password').AsString;
  Player.PasswordHash := Query.Query.FieldByName('password_hash').AsString;
  Player.LastTokenTime :=
    StrToDateTime(Query.Query.FieldByName('last_token_creation_time').AsString);
  Player.Status := BYTE(Query.Query.FieldByName('account_status').AsInteger);
  Player.Token := Query.Query.FieldByName('last_token').AsString;
  Player.Nation := BYTE(Query.Query.FieldByName('nation').AsInteger);

  // se o token vindo do client for diferente do gerado no aik_get_token ent�o -1
  if (Password <> Player.Token) then
  begin
    Response := '-1'; // senha incorreta
    Logger.Write('Usu�rio [' + Player.Username +
      '] tentou logar com token indevido.', TlogType.Warnings);
    Exit;
  end;

  if (Player.Status = 8) then
  begin
    Response := '-8'; // usu�rio banido
    Exit;
  end;

  // pega as informa��es sobre quantos personagens o player tem no banco de dados
  Query.SetQuery('SELECT * FROM characters WHERE owner_accid = :powner_accid');
  Query.AddParameter('powner_accid', AnsiString(IntToStr(Player.ID)));
  Query.Run();

  // aqui ele conta quantos personagens ele tem no banco
  CharCount := Query.Query.RecordCount;

  // aqui ele envia pro client essas informa��es
  Response := 'CNT ' + CharCount.ToString + ' 0 0 0<br>' +
    Player.Nation.ToString + ' 0 0 0';
end;

class procedure TTokenHandler.GetServerPlayers(var Response: String);
var
  i: Integer;
  Cnt: Integer;
  strResp: String;
begin
  for i := 1 to 12 do // (12)  5 na��es (pvp,pve = 10) + 2n(Karena/Leopold)
  begin
    // pega informa��es do banco de dados
    Query.SetQuery('SELECT * FROM server WHERE nation_id = :pnation_id');
    Query.AddParameter('pnation_id', AnsiString(IntToStr(i)));
    Query.Run();

    // pega quantos player tem on
    Cnt := Query.Query.FieldByName('nation_player_on').AsInteger;

    // constroi a resposta pro client
    strResp := strResp + Cnt.ToString + ' ';

    if (i = 10) then
      strResp := strResp + '-1 -1 -1 -1 -1 '; // tem 5 na��es em branco
  end;

  Response := strResp;
end;

class procedure TTokenHandler.AikaResetFlag(Param: TStrings;
  var Response: String);
var
  Username, Password: String;
  Player: TPlayerAuth;
begin
  // pega o username em https://*:8090/member/aika_reset_flag.asp?id=
  Username := Param.ValueFromIndex[0];
  // pega o username em https://*:8090/member/aika_reset_flag.asp?pw=
  Password := Param.ValueFromIndex[1];

  // Query do MYSQL pra pegar a conta no Banco de Dados pelo username
  Query.SetQuery('SELECT * FROM accounts WHERE username = :pusername');
  Query.AddParameter('pusername', AnsiString(Username));
  Query.Run();

  if (Query.Query.IsEmpty) then // se a conta n�o for encontrada, retorna 0
  begin
    Response := '0'; // conta n�o encontrada
    Exit;
  end;

  // pega os valores na struct player da query do banco de dados
  Player.Username := Query.Query.FieldByName('username').AsString;
  Player.Password := Query.Query.FieldByName('password').AsString;
  Player.PasswordHash := Query.Query.FieldByName('password_hash').AsString;
  Player.LastTokenTime :=
    StrToDateTime(Query.Query.FieldByName('last_token_creation_time').AsString);
  Player.Status := BYTE(Query.Query.FieldByName('account_status').AsInteger);

  // se a senha for diferente, ent�o retorna -1
  if (Password <> Player.PasswordHash) then
  begin
    Response := '-1'; // senha incorreta
    Exit;
  end;

  case Player.Status of
    2:
      begin
        Response := '-2'; // msg: conta cancelada
        Exit;
      end;

    8:
      begin
        Response := '-8'; // msg: conta bloqueada entre em contato com o suporte
        Exit;
      end;

    10:
      begin
        Response := '-10'; // msg: n�o � usu�rio cbt
        Exit;
      end;
  end;

  // reseta o tempo do token do player
  Player.LastTokenTime := Now;

  Query.SetQuery('UPDATE accounts SET last_token=:plast_token,' +
    ' last_token_creation_time=:plast_token_creation_time WHERE username =:pusername');
  Query.AddParameter('pusername', AnsiString(Player.Username));
  Query.AddParameter('plast_token', AnsiString(String(Player.Token)));
  Query.AddParameter('plast_token_creation_time',
    AnsiString(DateTimeToStr(Player.LastTokenTime)));
  Query.Query.ExecSQL;

  Logger.Write('Token [' + Player.Token + '] resetado para [' + Player.Username
    + '] em ' + DateTimeToStr(Player.LastTokenTime) + '.',
    TlogType.ClientConnect);

  // envia o token pro client
  Response := Player.Token;
end;

end.
