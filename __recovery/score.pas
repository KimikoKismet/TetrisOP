unit score;

interface
uses System.SysUtils, Classes;

function nactiSoubor(nazevSouboru : String) : TStringList;
function rozdeleni(radek : String) : TArray<String>;

implementation
uses Highscore;

function rozdeleni(radek : String) : TArray<String>;
var chararray : Array[0..1] of Char;
begin
  chararray[0] := ':';
  chararray[1] := ' ';
  SetLength(result, 2);
  result[0] := radek.Split(chararray)[0];
  result[1] := radek.Split(chararray)[2];
end;

function nactiSoubor(nazevSouboru : String) : TStringList;
var   score : TStringList;
begin
  score := TStringList.Create;
  score.LoadFromFile(nazevSouboru);
  result := score;
end;

end.
