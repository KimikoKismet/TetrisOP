unit game;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, System.Generics.Collections,
  Vcl.ExtCtrls,
  Menu, GameUtils, Kosticka, Constants, Tvar, Smer;

type
  TGameForm = class(TForm)
    Background: TImage;
    ScoreText: TLabel;
    ScoreNumber: TLabel;
    nasledujKosticka: TImage;
    RetryButton: TImage;
    Control: TImage;
    okraje: TImage;
    ExitButton: TImage;
    Casovac: TTimer;
    pole: TImage;
    procedure ExitButtonClick(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ExitButtonMouseEnter(Sender: TObject);
    procedure ExitButtonMouseLeave(Sender: TObject);
    procedure RetryButtonMouseEnter(Sender: TObject);
    procedure RetryButtonMouseLeave(Sender: TObject);
    procedure gameLoop(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    GameForm: TGameForm;
  end;

var
  GameForm : TGameForm;

  kostickyImages : TDictionary<TKostickaEnum, TImage>;
  image : TImage;

  aktualKosticka,nasledujiciKosticka : TTvar;
  hraciPole : TArray<TArray<TKosticka>>;

  scorelvl,score : Integer;

  procedure gameInit(pole : TImage);
  procedure gameOver;
  procedure vykresleni(pole : TImage; hraciPole : TArray<TArray<TKosticka>>; pocetViditelnychRadku : Integer);
  function posun(smer : TSmer; pole : TImage) : boolean;
  procedure vykresleniNK(pole : TImage; poleKosticky : TArray<TArray<TKosticka>>);
  procedure rotace(aktualKosticka : TTvar; pole : TImage; hraciPole : TArray<TArray<TKosticka>>);

implementation

{$R *.dfm}

procedure TGameForm.FormShow(Sender: TObject);
var
  bg,nk : TPicture;
begin
  Control.Picture.LoadFromFile(gameModeSelection);                  /// nalouduje nápovìdu

  bg := TPicture.Create;                                            /// nalouduje background do hracího pole
  try
    bg.LoadFromFile('obrazky\Pole.png');
    pole.Canvas.Draw(0,0,bg.Graphic);
  finally
    bg.Free;
  end;

  {nk:= TPicture.Create;
  try
    nk.LoadFromFile('obrazky\NasledujiciKosticka.png');
    NasledujiciKosticka.Canvas.Draw(0,0,nk.Graphic);
  finally
    nk.Free;
  end;     }

  score := 0;                                                       /// nastaví skóre na 0
  ScoreNumber.Caption := IntToStr(score);

  kostickyImages := TDictionary<TKostickaEnum, TImage>.Create;      /// vytvoøení mapy
  image := TImage.Create(Self);

  image.Picture.LoadFromFile('obrazky/CervenaKosticka.png');        /// naètení èervené kostièky
  kostickyImages.Add(TKostickaEnum.CERVENA,image);

  image.Picture.LoadFromFile('obrazky/ModraKosticka.png');          /// naètení modré kostièky
  kostickyImages.Add(TKostickaEnum.MODRA,image);

  image.Picture.LoadFromFile('obrazky/ZelenaKosticka.png');         /// naètení zelené kostièky
  kostickyImages.Add(TKostickaEnum.ZELENA,image);

  image.Picture.LoadFromFile('obrazky/OranzovaKosticka.png');       /// naètení oranžové kostièky
  kostickyImages.Add(TKostickaEnum.ORANZOVA,image);

  image.Picture.LoadFromFile('obrazky/FialovaKosticka.png');        /// naètení fialové kostièky
  kostickyImages.Add(TKostickaEnum.FIALOVA,image);

  gameInit(nasledujKosticka);   /// zahájí hru
end;

procedure TGameForm.gameLoop(Sender: TObject);
var
  smer : TSmer;
begin
  if kontrolaGameOver(hraciPole) then gameOver;

  smer := TDolu.Create;
  posun(smer, pole);

  vykresleniNK(nasledujKosticka, nasledujiciKosticka.getTvar)

end;

/// zmìna barvy tlaèítka pøi najetí kurzoru na tlaèítko
procedure TGameForm.RetryButtonMouseEnter(Sender: TObject);
begin
  RetryButton.Picture.LoadFromFile('obrazky\RetryClickButton.png');
end;

/// zmìna barvy tlaèítka pøi vyjetí kurzoru z tlaèítka
procedure TGameForm.RetryButtonMouseLeave(Sender: TObject);
begin
  RetryButton.Picture.LoadFromFile('obrazky\RetryButton.png');
end;

procedure TGameForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TGameForm.ExitButtonClick(Sender: TObject);
begin
  MenuForm.Show;
  Hide;
end;

/// zmìna barvy tlaèítka pøi najetí kurzoru na tlaèítko
procedure TGameForm.ExitButtonMouseEnter(Sender: TObject);
begin
  ExitButton.Picture.LoadFromFile('obrazky\ExitClickButton.png');
end;

/// zmìna barvy tlaèítka pøi vyjetí kurzoru z tlaèítka
procedure TGameForm.ExitButtonMouseLeave(Sender: TObject);
begin
  ExitButton.Picture.LoadFromFile('obrazky\ExitButton.png');
end;

procedure gameInit(pole : TImage);
begin
  aktualKosticka := nahodnaKosticka(kostickyImages);
  nasledujiciKosticka := nahodnaKosticka(kostickyImages);
  SetLength(hraciPole, Constants.HRA_POCET_RADKU, Constants.HRA_POCET_SLOUPCU);

  vykresleniNK(pole, nasledujiciKosticka.getTvar);

  GameForm.Casovac.Interval := Constants.POCATECNI_RYCHLOST;
  GameForm.Casovac.Enabled := true;

  scorelvl := 1;

  //hraciPole[4][0] := TKosticka.Create(GameUtils.nahodnaBarva(kostickyImages));
end;

procedure gameOver;
begin

end;

procedure vykresleniNK(pole : TImage; poleKosticky : TArray<TArray<TKosticka>>);
var
  sloupec, radek : Integer;
  bg : TPicture;
begin
  bg := TPicture.Create;
  try
    bg.LoadFromFile('obrazky\NasledujiciKosticka.png');
    pole.Canvas.Draw(0,0,bg.Graphic);
    for radek := 0 to (Length(poleKosticky)-1) do begin
      for sloupec := 0 to (Length(poleKosticky[0])-1) do begin
        if (poleKosticky[radek][sloupec] <> nil) then begin
          pole.Canvas.Draw((sloupec)*Constants.KOSTICKA_SIZE, (radek)*Constants.KOSTICKA_SIZE, poleKosticky[radek][sloupec].getKosticka.Picture.Graphic);
        end;
      end;
    end;
  finally
    bg.Free;
  end;
end;

procedure vykresleni(pole : TImage; hraciPole : TArray<TArray<TKosticka>>; pocetViditelnychRadku : Integer);
var
  offset,radek,sloupec : Integer;
  background : TPicture;
begin
  background := TPicture.Create;
  offset := Length(hraciPole) - pocetViditelnychRadku;
  try
    background.LoadFromFile('obrazky\Pole.png');
    pole.Canvas.Draw(0,0,background.Graphic);
    for radek := 0 to (Length(hraciPole)-offset-1) do begin
      for sloupec := 0 to (Length(hraciPole[0])-1) do begin
        if (hraciPole[radek + offset][sloupec] <> nil) then begin
          pole.Canvas.Draw((sloupec)*Constants.KOSTICKA_SIZE, (radek)*Constants.KOSTICKA_SIZE, hraciPole[radek + offset][sloupec].getKosticka.Picture.Graphic);
        end;
      end;
    end;
  finally
    background.Free;
  end;
end;

function posun(smer : TSmer; pole : TImage) : boolean;
var
  x,y : Integer;
  copyPole : TArray<TArray<TKosticka>>;
  status : VlozeniKostkyStatus;
begin
  x := aktualKosticka.getX + smer.getX;
  y := aktualKosticka.getY + smer.getY;

  copyPole := GameUtils.copy(hraciPole);
  status := vlozeniKosticky(aktualKosticka,hraciPole,copyPole,smer);

  case status of
    OK:
      begin
        vykresleni(pole, copyPole, Constants.HRA_POCET_VIDITELNYCH_RADKU);
        aktualKosticka.setX(x);
        aktualKosticka.setY(y);
        result := true;
      end;
    KOLIZE_S_KOSTKOU_ZE_STRANY:
      begin
        copyPole := copy(hraciPole);
        GameUtils.vlozeniKosticky(aktualKosticka, hraciPole, copyPole, TNic.Create);
        vykresleni(pole, copyPole, Constants.HRA_POCET_VIDITELNYCH_RADKU);
        result := true;
      end;
    KOLIZE_SE_STENOU:
      begin
        copyPole := copy(hraciPole);
        GameUtils.vlozeniKosticky(aktualKosticka, hraciPole, copyPole, TNic.Create);
        vykresleni(pole, copyPole, Constants.HRA_POCET_VIDITELNYCH_RADKU);
        result := true;
      end;
    KOLIZE_S_KONCEM:
      begin
        copyPole := copy(hraciPole);
        GameUtils.vlozeniKosticky(aktualKosticka, hraciPole, copyPole, TNic.Create);
        hraciPole := copyPole;
        aktualKosticka := nasledujiciKosticka;
        nasledujiciKosticka := GameUtils.nahodnaKosticka(kostickyImages);
        result := false;
      end;
  end;
end;

procedure rotace(aktualKosticka : TTvar; pole : TImage; hraciPole : TArray<TArray<TKosticka>>);
var
  otoceni : TArray<TArray<Integer>>;
  min,i : Integer;
  tmp : TArray<TArray<TKosticka>>;
  image : TImage;
  j: Integer;
  smer : TSmer;
  //status : VlozeniKostkyStatus;
  //copyPole : TArray<TArray<TKosticka>>;
begin
  otoceni := GameUtils.nasobeniMatic(Constants.maticeOtoceni,aktualKosticka.getBody);
  min := Integer.MaxValue;

  for i := 0 to (Length(otoceni[0])-1) do begin
    if (otoceni[0][i] < min) then  min := otoceni[0][i];
  end;

  min := Abs(min);

  for i := 0 to (Length(otoceni[0])-1) do begin
    otoceni[0][i] := otoceni[0][i] + min;
  end;

  smer := TNic.Create;
  image := aktualKosticka.getImage(aktualKosticka.getTvar);
  tmp := aktualKosticka.createTvar(otoceni, image);

  {copyPole := GameUtils.copy(hraciPole);
  status := vlozeniKosticky(aktualKosticka,hraciPole,copyPole,smer);}


 { case status of
    OK: aktualKosticka.setTvar(tmp);
    KOLIZE_S_KOSTKOU_ZE_STRANY: aktualKosticka.setTvar(aktualKosticka.getTvar);
    KOLIZE_SE_STENOU: aktualKosticka.setTvar(aktualKosticka.getTvar);
    KOLIZE_S_KONCEM: aktualKosticka.setTvar(aktualKosticka.getTvar);
  end;}

  aktualKosticka.setTvar(tmp); // možná nebude potøeba
  posun(smer, pole);
end;

end.
