unit Load;

interface

uses
  Windows, SysUtils, Classes, IniFiles;

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

  Path := GetCurrentDir + '\Config.ini'; //pega o caminho do arquivo

  if not(FileExists(Path)) then //se não encontrar o arquivo
  begin
    Logger.Write('Arquivo de configuração não encontrado.', TLogType.Warnings);
    Exit;
  end;

  F := TIniFile.Create(Path); //abre o arquivo pra leitura

  try
    ServerConfig.IP := F.ReadString('WebServer', 'IP', ''); //pega o ip no arqv
    ServerConfig.Port := F.ReadInteger('WebServer', 'Port', 0); //pega a porta

    //pega todas os dados do mysql no arquivo
    ServerConfig.MySQLServer := F.ReadString('MYSQL', 'Server', '');
    ServerConfig.MySQLPort := F.ReadInteger('MYSQL', 'Port', 0);
    ServerConfig.MySQLLogin := F.ReadString('MYSQL', 'Username', '');
    ServerConfig.MySQLPass := F.ReadString('MYSQL', 'Password', '');
    ServerConfig.MySQLDataBase := F.ReadString('MYSQL', 'Database', '');
  except
    on E: Exception do
    begin
      Logger.Write(E.ClassName + ':' + E.Message + ' <-- INI Error',
        TLogType.Errors);
      Exit;
    end;
  end;

  F.Free;

  Result := True;
end;

end.
