program WebServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Windows,
  Log in 'Src\Functions\Log.pas',
  ServerUtils in 'Src\Data\ServerUtils.pas',
  GlobalDefs in 'Src\Data\GlobalDefs.pas',
  Load in 'Src\Functions\Load.pas',
  ServerSocket in 'Src\Connection\ServerSocket.pas',
  TokenHandlers in 'Src\Handlers\TokenHandlers.pas',
  DataBase in 'Src\Connection\DataBase.pas',
  GlobalFuncs in 'Src\Functions\GlobalFuncs.pas';

begin
  try
    Logger := TLog.Create;

    SetConsoleTitle('Aika Web Server');

    Logger.Write('Web Server está iniciando...', TLogType.Load);

    TLoad.InitServerConfig;

    Logger.Write('Web Server será iniciado no IP:Port ' +
      ServerConfig.IP + ':' + ServerConfig.Port.ToString(),
      TLogType.Load);

    Server := TServerSocket.Create;

    isActive := Server.StartServer;

    while (True) do
    begin
      ReadLn;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
