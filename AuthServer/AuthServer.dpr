program AuthServer;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Windows,
  Log in 'Src\Functions\Log.pas',
  ServerUtils in 'Src\Data\ServerUtils.pas',
  ServerSocket in 'Src\Connection\ServerSocket.pas',
  GlobalDefs in 'Src\Data\GlobalDefs.pas',
  Load in 'Src\Functions\Load.pas',
  Packets in 'Src\Data\Packets.pas',
  EncDec in 'Src\Connection\EncDec.pas',
  PacketHandler in 'Src\Handlers\PacketHandler.pas',
  DataBase in 'Src\Connection\DataBase.pas';

begin
  try
    SetConsoleTitle('Aika Auth Server');

    Logger := TLog.Create;
    Server := TServerSocket.Create;

    Logger.Write('AuthServer está iniciando...', TLogType.Load);

    Server.StartServer;

    while (True) do
    begin
      ReadLn;
    end;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
