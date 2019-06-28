unit Packets;

interface

uses
  Windows, ServerUtils;

type
  TPacketHeader = packed record
    Size: WORD;
    Key: Byte;
    ChkSum: Byte;
    Index, Code: WORD;
    Time: DWORD;
  end;

type
  PPacket_81 = ^TCheckTokenPacket;

  TCheckTokenPacket = packed record
    Header: TPacketHeader;
    Username: ARRAY [0 .. 31] OF AnsiChar;
    Token: ARRAY [0 .. 31] OF AnsiChar;
    Null_1: ARRAY [0 .. 1039] OF Byte;
  end;

type
  PPacket_82 = ^TResponseLoginPacket;

  TResponseLoginPacket = packed record
    Header: TPacketHeader;
    Index, Time: DWORD;
    Nation: TCitizenship;
    Null_1: DWORD;
  end;

implementation

end.
