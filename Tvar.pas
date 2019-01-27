unit Tvar;

interface

uses
  Kosticka, Vcl.ExtCtrls, System.Variants;

type
  TTvar = Class(TObject)
    protected
      tvar : TArray<TArray<TKosticka>>;
      x,y : Integer;
      image : TImage;
    public
      constructor Create(image : TImage);
      function getTvar : TArray<TArray<TKosticka>>;
      procedure setTvar(tvar : TArray<TArray<TKosticka>>);
      function getBody : TArray<TArray<Integer>>;
      function createTvar(souradnice : TArray<TArray<Integer>>) : TArray<TArray<TKosticka>>;
      function getX : Integer;
      function getY : Integer;
      procedure setX(x : Integer);
      procedure setY(y : Integer);
      function CreateKosticka(pozice : TArray<TArray<Integer>>; image : TImage) : TArray<TArray<TKosticka>>;
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

function TTvar.getTvar : TArray<TArray<TKosticka>>;
begin
  result := tvar;
end;

procedure TTvar.setTvar(tvar : TArray<TArray<TKosticka>>);
begin
  self.tvar := tvar;
end;

function TTvar.getBody : TArray<TArray<Integer>>;
var
  souradnice : TArray<TArray<Integer>>;
  k,j,i : Integer;
  kostka : TArray<TArray<TKosticka>>;
  bod : TKosticka;
begin
  SetLength(souradnice, 2, 4);
  k := 0;
  kostka := getTvar;
  for i := 0 to Length(kostka)-1 do begin
    for j := 0 to Length(kostka[0])-1 do begin
      bod := kostka[j][i];
      if bod <> Nil then begin
        souradnice[0][k] := i;
        souradnice[1][k] := j;
        k := k + 1;
      end;
    end;
  end;
  result := souradnice;
end;

function TTvar.createTvar(souradnice : TArray<TArray<Integer>>) : TArray<TArray<TKosticka>>;
var
  tvar : TArray<TArray<TKosticka>>;
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

function TTvar.CreateKosticka(pozice: TArray<System.TArray<System.Integer>>; image : TImage) : TArray<TArray<TKosticka>>;
var
  tvar : TArray<TArray<TKosticka>>;
  i,j : Integer;
begin
  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      if pozice[i][j] = 0 then tvar[i][j] := nil
      else tvar[i][j] := TKosticka.Create(image);
    end;
  end;
end;


constructor TLkoMirror.Create(image : Timage);
var
  pozice : TArray<TArray<Integer>> =
    (
      (0,0,0,0),
      (0,1,0,0),
      (0,1,0,0),
      (1,1,0,0)
    );
begin
  inherited Create(image);
  self.tvar := TTvar.CreateKosticka(pozice,image);
end;

constructor TLkoNormal.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (nil, nil, nil, nil),
      (Tkosticka.Create(image), nil, nil, nil),
      (Tkosticka.Create(image), nil, nil, nil),
      (Tkosticka.Create(image), Tkosticka.Create(image), nil, nil)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TCtverec.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (nil, nil, nil, nil),
      (nil, nil, nil, nil),
      (Tkosticka.Create(image), Tkosticka.Create(image), nil, nil),
      (Tkosticka.Create(image), Tkosticka.Create(image),nil, nil)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TZkoMirror.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (nil, nil, nil, nil),
      (nil, nil, nil, nil),
      (nil, Tkosticka.Create(image), Tkosticka.Create(image), nil),
      (Tkosticka.Create(image), Tkosticka.Create(image), nil, nil)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TZkoNormal.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (nil, nil, nil, nil),
      (nil, nil, nil, nil),
      (Tkosticka.Create(image), Tkosticka.Create(image), nil, nil),
      (nil, Tkosticka.Create(image), Tkosticka.Create(image), nil)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TTkoKosticka.Create(image : Timage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (nil, nil, nil, nil),
      (nil, nil, nil, nil),
      (nil, Tkosticka.Create(image), nil, nil),
      (Tkosticka.Create(image), Tkosticka.Create(image), Tkosticka.Create(image), nil)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;

constructor TTrubka.Create(image : TImage);
var
  tvar : Array[1..4,1..4] of TKosticka =
    (
      (Tkosticka.Create(image), nil, nil, nil),
      (Tkosticka.Create(image), nil, nil, nil),
      (Tkosticka.Create(image), nil, nil, nil),
      (Tkosticka.Create(image), nil, nil, nil)
    );
begin
  inherited Create(image);
  self.tvar := tvar;
end;



end.
