unit ServerUtils;

interface

type
  TLogType = (ServerStatus, Load, ClientConnect, Warnings, Errors);

type
  TServerConfig = record
    IP: String;
    Port: Integer;

    MySQLServer: String;
    MySQLPort: Integer;
    MySQLLogin: String;
    MySQLPass: String;
    MySQLDataBase: String;
  end;

type
  TPlayerAuth = record
    ID: Integer;
    Username: String;
    Password: String;
    PasswordHash: String;
    LastTokenTime: TDateTime;
    Token: String;
    Status: Byte;
    Nation: BYTE;
  end;

type
  TCitizenship = (None = 0, Server1, Server2, Server3, Server4, Server5);

implementation

end.
