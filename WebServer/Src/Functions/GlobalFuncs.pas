unit GlobalFuncs;

interface

uses
  Windows, SysUtils, IdHashMessageDigest;

type
  TFunctions = class(TObject)
    class function StringToMD5(str: String): String;
    class function TokenGenerator(): String;
  end;

implementation

{ TFunctions }

class function TFunctions.StringToMD5(str: String): String;
var
  MD5: TIdHashMessageDigest5;
begin
  MD5 := TIdHashMessageDigest5.Create;

  Result := MD5.HashStringAsHex(str);

  Result := AnsiLowerCase(Result);
end;

class function TFunctions.TokenGenerator: String;
var
  Rand, Rand2, Rand3: Integer;
  Alfa, AlfaNum: String;
  Token1, Letter, Num: String;
  i: Integer;
begin
  Alfa := 'abcdefghijklmnopqrstuvwxyz';
  AlfaNum := '1234567890';

  for I := 0 to 31 do //vai gerar um token de 32 caracteres
  begin
    Randomize;
    Rand := Random(26);
    Rand2 := Random(10);
    Rand3 := Random(1);

    if(Rand = 0) then
      Rand := 1;

    if(Rand2 = 0) then
      Rand2 := 1;

    Letter := Alfa[Rand];
    Num := AlfaNum[Rand2];

    case Rand3 of
      0:
        Token1 := Token1 + Letter;
      1:
        Token1 := Token1 + Num;
    end;
  end;

  Result := Token1;
end;

end.
