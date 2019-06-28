unit Log;

interface

uses
  ServerUtils, Windows, SysUtils;

type
  TLog = class(TObject)
    class procedure Write(str: String; LogType: TLogType);
  end;

implementation

{ TLog }

class procedure TLog.Write(str: String; LogType: TLogType);
begin
  case LogType of
    ServerStatus:
      begin
        WriteLn('[Server]' + str);
      end;

    Warnings:
      begin
        SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 14 // yellow
          OR FOREGROUND_INTENSITY);
        WriteLn('[Warning] ' + str);
      end;

    Errors:
      begin
        SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),
          FOREGROUND_RED OR FOREGROUND_INTENSITY);
        WriteLn('[Error] ' + str);
      end;

    Load:
      begin
        SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 13 // Purple
          OR FOREGROUND_INTENSITY);
        WriteLn('[Load] ' + str);
      end;

    ClientConnect:
      begin
        SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 11 // Light Blue
          OR FOREGROUND_INTENSITY);
        WriteLn('[New] ' + str);
      end;
  end;

  SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 15 // Light White
          OR FOREGROUND_INTENSITY);
end;

end.
