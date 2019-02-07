unit game;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, System.Generics.Collections,
  Vcl.ExtCtrls, System.UITypes,
  Menu, GameUtils, Kosticka, Constants, Tvar, Smer, Dialog;

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
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gameInit(pole : TImage);
    procedure gameOver;
    procedure vykresleni(pole : TImage; hraciPole : TArray<TArray<TKosticka>>; pocetViditelnychRadku : Integer);
    function posun(smer : TSmer; pole : TImage) : boolean;
    procedure vykresleniNK(pole : TImage; poleKosticky : TArray<TArray<TKosticka>>);
    procedure rotace(aktual : TTvar; pole : TImage; hraciPole : TArray<TArray<TKosticka>>);
    procedure vymazZaplneneRadky(pole : TImage; hraciPole : TArray<TArray<TKosticka>>);
    function timerUp(lvl : Integer) : Integer;
    function levelUp(score : Integer) : Integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    kostickyImages : TDictionary<TKostickaEnum, TImage>;
    image : TImage;

    aktualKosticka,nasledujiciKosticka : TTvar;
    hraciPole : TArray<TArray<TKosticka>>;

    scorelvl : Integer;
  public
    GameForm: TGameForm;
    score : Integer;
  end;

var
  GameForm: TGameForm;

implementation

{$R *.dfm}

procedure TGameForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TGameForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  smer : TSmer;
begin
  case Key of
    vkUP: rotace(aktualKosticka, pole, hraciPole);
    vkDOWN: begin
      smer := TDolu.Create;
      posun(smer,pole);
    end;
    vkRIGHT: begin
      smer := TDoprava.Create;
      posun(smer, pole);
    end;
    vkLEFT: begin
      smer := TDoleva.Create;
      posun(smer, pole);
    end;
    vkSPACE: begin
      smer := TDolu.Create;
      while posun(smer, pole) do score := score + 2*scorelvl;
    end;
  end;
end;

procedure TGameForm.FormShow(Sender: TObject);
var
  bg : TPicture;
begin
  Control.Picture.LoadFromFile(gameModeSelection);                  /// nalouduje n�pov�du

  bg := TPicture.Create;                                            /// nalouduje background do hrac�ho pole
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

  score := 0;                                                       /// nastav� sk�re na 0
  ScoreNumber.Caption := IntToStr(score);

  kostickyImages := TDictionary<TKostickaEnum, TImage>.Create;      /// vytvo�en� mapy
  image := TImage.Create(Self);

  image.Picture.LoadFromFile('obrazky/CervenaKosticka.png');        /// na�ten� �erven� kosti�ky
  kostickyImages.Add(TKostickaEnum.CERVENA,image);

  image.Picture.LoadFromFile('obrazky/ModraKosticka.png');          /// na�ten� modr� kosti�ky
  kostickyImages.Add(TKostickaEnum.MODRA,image);

  image.Picture.LoadFromFile('obrazky/ZelenaKosticka.png');         /// na�ten� zelen� kosti�ky
  kostickyImages.Add(TKostickaEnum.ZELENA,image);

  image.Picture.LoadFromFile('obrazky/OranzovaKosticka.png');       /// na�ten� oran�ov� kosti�ky
  kostickyImages.Add(TKostickaEnum.ORANZOVA,image);

  image.Picture.LoadFromFile('obrazky/FialovaKosticka.png');        /// na�ten� fialov� kosti�ky
  kostickyImages.Add(TKostickaEnum.FIALOVA,image);

  gameInit(nasledujKosticka);   /// zah�j� hru
end;

/// procedura, ktar� se vykon� p�i ka�d�m tiku
procedure TGameForm.gameLoop(Sender: TObject);
var
  smer : TSmer;
  kontrola : boolean;
begin
  kontrola := GameUtils.kontrolaGameOver(hraciPole);
  if kontrola then gameOver;

  smer := TDolu.Create;
  posun(smer, pole);

  vykresleniNK(nasledujKosticka, nasledujiciKosticka.getTvar);

  vymazZaplneneRadky(pole, hraciPole);
  ScoreNumber.Caption := IntToStr(score);

  scorelvl := timerUp(levelUp(score));
end;

/// zm�na barvy tla��tka p�i najet� kurzoru na tla��tko
procedure TGameForm.RetryButtonMouseEnter(Sender: TObject);
begin
  RetryButton.Picture.LoadFromFile('obrazky\RetryClickButton.png');
end;

/// zm�na barvy tla��tka p�i vyjet� kurzoru z tla��tka
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

/// zm�na barvy tla��tka p�i najet� kurzoru na tla��tko
procedure TGameForm.ExitButtonMouseEnter(Sender: TObject);
begin
  ExitButton.Picture.LoadFromFile('obrazky\ExitClickButton.png');
end;

/// zm�na barvy tla��tka p�i vyjet� kurzoru z tla��tka
procedure TGameForm.ExitButtonMouseLeave(Sender: TObject);
begin
  ExitButton.Picture.LoadFromFile('obrazky\ExitButton.png');
end;

procedure TGameForm.gameInit(pole : TImage);
begin
  aktualKosticka := nahodnaKosticka(kostickyImages);
  nasledujiciKosticka := nahodnaKosticka(kostickyImages);
  SetLength(hraciPole, Constants.HRA_POCET_RADKU, Constants.HRA_POCET_SLOUPCU);

  vykresleniNK(pole, nasledujiciKosticka.getTvar);

  Casovac.Interval := Constants.POCATECNI_RYCHLOST;
  Casovac.Enabled := true;

  scorelvl := 1;
end;

procedure TGameForm.vykresleniNK(pole : TImage; poleKosticky : TArray<TArray<TKosticka>>);
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

procedure TGameForm.vykresleni(pole : TImage; hraciPole : TArray<TArray<TKosticka>>; pocetViditelnychRadku : Integer);
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

function TGameForm.posun(smer : TSmer; pole : TImage) : boolean;
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

procedure TGameForm.rotace(aktual : TTvar; pole : TImage; hraciPole : TArray<TArray<TKosticka>>);
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
  SetLength(otoceni,2,4);
  otoceni := GameUtils.nasobeniMatic(Constants.maticeOtoceni,aktual.getBody);
  min := Integer.MaxValue;

  for i := 0 to (Length(otoceni[0])-1) do begin
    if (otoceni[0][i] < min) then  min := otoceni[0][i];
  end;

  min := Abs(min);

  for i := 0 to (Length(otoceni[0])-1) do begin
    otoceni[0][i] := otoceni[0][i] + min;
  end;

  smer := TNic.Create;
  image := aktual.getImage;
  tmp := aktual.createTvar(otoceni, image);

  {copyPole := GameUtils.copy(hraciPole);
  status := vlozeniKosticky(aktualKosticka,hraciPole,copyPole,smer);}


 { case status of
    OK: aktualKosticka.setTvar(tmp);
    KOLIZE_S_KOSTKOU_ZE_STRANY: aktualKosticka.setTvar(aktualKosticka.getTvar);
    KOLIZE_SE_STENOU: aktualKosticka.setTvar(aktualKosticka.getTvar);
    KOLIZE_S_KONCEM: aktualKosticka.setTvar(aktualKosticka.getTvar);
  end;}

  aktualKosticka.setTvar(tmp); // mo�n� nebude pot�eba
  posun(smer, pole);
end;

procedure TGameForm.vymazZaplneneRadky(pole : TImage; hraciPole : TArray<TArray<TKosticka>>);
var
  scoreCounter,radek,sloupec : Integer;
  kontrola : Boolean;
begin
  scoreCounter := 0;
  for radek := 0 to (Length(hraciPole)-1) do begin
    kontrola := true;

    for sloupec := 0 to (Length(hraciPole[0])-1) do begin

      if (hraciPole[radek][sloupec] = nil) then begin
        kontrola := false;
        break;
      end;

    end;

    if kontrola then begin

      GameUtils.umazRadek(radek, hraciPole);
      hraciPole := GameUtils.posunZbytekDolu(radek, hraciPole);
      vykresleni(pole, hraciPole, Constants.HRA_POCET_VIDITELNYCH_RADKU);

      scoreCounter := scoreCounter + 1;
    end;
  end;

  case scoreCounter of
    1: score := score + Constants.SCORE_UMAZANI_RADKU * scorelvl;
    2: score := score + Constants.SCORE_UMAZANI_RADKU * scorelvl * 3;
    3: score := score + Constants.SCORE_UMAZANI_RADKU * scorelvl * 5;
  end;
end;

function TGameForm.timerUp(lvl : Integer) : Integer;
begin
  case lvl of
    1: begin
      Casovac.Interval := Constants.POCATECNI_RYCHLOST div Constants.TIMER_LEVEL_1;
      result := 1;
    end;
    2: begin
      Casovac.Interval := Constants.POCATECNI_RYCHLOST div Constants.TIMER_LEVEL_2;
      result := 10;
    end;
    3: begin
      Casovac.Interval := Constants.POCATECNI_RYCHLOST div Constants.TIMER_LEVEL_3;
      result := 50;
    end;
    4: begin
      Casovac.Interval := Constants.POCATECNI_RYCHLOST div Constants.TIMER_LEVEL_4;
      result := 100;
    end;
    5: begin
      Casovac.Interval := Constants.POCATECNI_RYCHLOST div Constants.TIMER_LEVEL_5;
      result := 1000;
    end;
  end;
  result := 1;
end;

function TGameForm.levelUp(score : Integer) : Integer;
begin
  if (score >= Constants.SCORE_LEVEL_5) then begin
    result:= 5;
  end;

  if (score >= Constants.SCORE_LEVEL_4) then begin
    result := 4;
  end;

  if (score >= Constants.SCORE_LEVEL_3) then begin
    result := 3;
  end;

  if (score >= Constants.SCORE_LEVEL_2) then begin
    result := 2;
  end;

  result := 1;
end;

procedure TGameForm.gameOver;
begin
  Casovac.Enabled := false;

  Dialog.GameOver.ShowModal;
end;


end.
