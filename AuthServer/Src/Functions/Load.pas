unit Load;

interface

uses
  Windows, SysUtils, IniFiles;

type
  TLoad = class(TObject)
    class function InitServerConfig(): Boolean;
  end;

implementation

uses
  GlobalDefs, ServerUtils;

{ TLoad }

class function TLoad.InitServerConfig: Boolean;
var
  F: TIniFile;
  Path: String;
begin
  Result := False;

  Path := GetCurrentDir + '\Config.ini';

  if not(FileExists(Path)) then
  begin
    Logger.Write('O arquivo de configuração não foi encontrado.',
      TLogType.Warnings);
    Exit;
  end;

  F := TIniFile.Create(Path);

  try
    ServerConf.IP := F.ReadString('AuthServer', 'IP', '');
    ServerConf.Port := F.ReadInteger('AuthServer', 'Port', 0);

    ServerConf.MySQLServer := F.ReadString('MYSQL', 'Server', '');
    ServerConf.MySQLPort := F.ReadInteger('MYSQL', 'Port', 0);
    ServerConf.MySQLLogin := F.ReadString('MYSQL', 'Username', '');
    ServerConf.MySQLPass := F.ReadString('MYSQL', 'Password', '');
    ServerConf.MySQLDataBase := F.ReadString('MYSQL', 'Database', '');
  except
    on E: Exception do
    begin
      Logger.Write(E.ClassName + ':' + E.Message + '| on .INI Reader.',
        TLogType.Errors);
      Exit;
    end;
  end;

  F.Free;

  Result := True;
end;

end.
