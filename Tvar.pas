unit Tvar;

interface

uses
  Kosticka, Vcl.ExtCtrls, System.Variants;

type
  TTvar = Class(TObject)
    protected
      tvar : Array of Array of TKosticka;
      x,y : Integer;
      image : TImage;
    public
      constructor Create(image : TImage);
      function getTvar : Array of Array of TKosticka;
      procedure setTvar(tvar : Array of Array of TKosticka);
      function getBody : Array of Integer;
      function createTvar(souradnice : Array of Array of Integer) : Array of Array of TKosticka;
      function getX : Integer;
      function getY : Integer;
      procedure setX(x : Integer);
      procedure setY(y : Integer);
  End;
  TCtverec = Class(TTvar)
    constructor Create(image : TImage);
  End;
  TLkoMirror = Class(TTvar)
    constructor Create(image : TImage);
  End;
  TLkoNormal = Class(TTvar)
    constructor Create(image : TImage);
  End;
  TTkoKosticka = Class(TTvar)
    constructor Create(image : TImage);
  End;
  TTrubka = Class(TTvar)
    constructor Create(image : TImage);
  End;
  TZkoMirror = Class(TTvar)
    constructor Create(image : TImage);
  End;
  TZkoNormal = Class(TTvar)
    constructor Create(image : TImage);
  End;


implementation

constructor TTvar.Create(image: TImage);
begin
  self.image := image;
end;

function TTvar.getTvar : Array of Array of TKosticka;
begin
  result := tvar;
end;

procedure TTvar.setTvar(tvar : Array of Array of TKosticka);
begin
  self.tvar := tvar;
end;

function TTvar.getBody : Array of Integer;
var
  souradnice : Array of Array of Integer;
  k,j,i : Integer;
  kostka : Array of Array of TKosticka;
  bod : TKosticka;
begin
  SetLength(souradnice, 2, 4);
  k := 0;
  kostka := getTvar;
  for i := 0 to Length(kostka)-1 do begin
    for j := 0 to Length[0](kostka)-1 do begin
      bod := kostka[j][i];
      if bod <> Null then begin
        souradnice[0][k] := i;
        souradnice[1][k] := j;
        k := k + 1;
      end;
    end;
  end;
  result := souradnice;
end;

function TTvar.createTvar(souradnice : Array of Array of Integer) : Array of Array of TKosticka;
var
  tvar : Array of Array of TKosticka;
  sloupec : Integer;
begin
  SetLength(tvar, 4, 4);
  for sloupec := 0 to Length(souradnice[0])-1 do tvar[souradnice[0][sloupec]][souradnice[1][sloupec]] := TKosticka.Create(image);
  result := tvar;
end;

function TTvar.getX;
begin
  result := x;
end;

function TTvar.getY;
begin
  result := y;
end;

procedure TTvar.setX(x: Integer);
begin
  self.x := x;
end;

procedure TTvar.setY(y: Integer);
begin
  self.y := y;
end;




constructor TLkoMirror.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (Null, Null, Null, Null),
      (Null, Tkosticka.Create(image),Null, Null),
      (Null, Tkosticka.Create(image),Null, Null),
      (Tkosticka.Create(image), Tkosticka.Create(image),Null, Null)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TLkoNormal.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (Null, Null, Null, Null),
      (Tkosticka.Create(image), Null, Null, Null),
      (Tkosticka.Create(image), Null, Null, Null),
      (Tkosticka.Create(image), Tkosticka.Create(image),Null, Null)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TCtverec.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (Null, Null, Null, Null),
      (Null, Null, Null, Null),
      (Tkosticka.Create(image), Tkosticka.Create(image), Null, Null),
      (Tkosticka.Create(image), Tkosticka.Create(image),Null, Null)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TZkoMirror.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (Null, Null, Null, Null),
      (Null, Null, Null, Null),
      (Null, Tkosticka.Create(image), Tkosticka.Create(image), Null),
      (Tkosticka.Create(image), Tkosticka.Create(image), Null, Null)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TZkoNormal.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (Null, Null, Null, Null),
      (Null, Null, Null, Null),
      (Tkosticka.Create(image), Tkosticka.Create(image), Null, Null),
      (Null, Tkosticka.Create(image), Tkosticka.Create(image), Null)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TTkoKosticka.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (Null, Null, Null, Null),
      (Null, Null, Null, Null),
      (Null, Tkosticka.Create(image), Null, Null),
      (Tkosticka.Create(image), Tkosticka.Create(image), Tkosticka.Create(image), Null)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TTrubka.Create(image : TImage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (Tkosticka.Create(image), Null, Null, Null),
      (Tkosticka.Create(image), Null, Null, Null),
      (Tkosticka.Create(image), Null, Null, Null),
      (Tkosticka.Create(image), Null, Null, Null)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;



end.
