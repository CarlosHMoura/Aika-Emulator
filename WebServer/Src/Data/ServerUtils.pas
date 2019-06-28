unit ServerUtils;

interface

uses
  Windows;

type
  TLogType = (ServerStatus, Warnings, Errors, Load, ClientConnect);

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

implementation

end.
