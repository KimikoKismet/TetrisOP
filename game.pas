unit game;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, System.Generics.Collections,
  Vcl.ExtCtrls,
  Menu, GameUtils, Kosticka, Constants, Tvar;

type
  TGameForm = class(TForm)
    Background: TImage;
    ScoreText: TLabel;
    ScoreNumber: TLabel;
    NasledujiciKosticka: TImage;
    RetryButton: TImage;
    Control: TImage;
    okraje: TImage;
    ExitButton: TImage;
    pole: TImage;
    Casovac: TTimer;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ExitButtonMouseEnter(Sender: TObject);
    procedure ExitButtonMouseLeave(Sender: TObject);
    procedure RetryButtonMouseEnter(Sender: TObject);
    procedure RetryButtonMouseLeave(Sender: TObject);
    procedure CasovacTimer(Sender: TObject);
    procedure gameLoop(Sender: TObject);

  private
    { Private declarations }
  public
    GameForm: TGameForm;
    { Public declarations }
  end;

var
  GameForm : TGameForm;

  kostickyImages : TDictionary<TKostickaEnum, TImage>;
  image : TImage;

  aktualKosticka,nasledujiciKosticka : TTvar;
  hraciPole : TArray<TArray<TKosticka>>;

  scorelvl,score : Integer;

implementation

{$R *.dfm}

///
procedure TGameForm.FormActivate(Sender: TObject);
begin
  Control.Picture.LoadFromFile(gameModeSelection);

  score := 0;
  ScoreNumber.Caption := IntToStr(score);

  kostickyImages := TDictionary<TKostickaEnum, TImage>.Create;
  image.Picture.LoadFromFile('obrazky/CervenaKosticka.png');
  kostickyImages.Add(TKostickaEnum.CERVENA,image);
end;

procedure TGameForm.gameLoop(Sender: TObject);
begin

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

procedure gameInit;
begin
  aktualKosticka := nahodnaKosticka(kostickyImages);
  nasledujiciKosticka := nahodnaKosticka(kostickyImages);
  SetLength(hraciPole, Constants.HRA_POCET_RADKU, Constants.HRA_POCET_SLOUPCU);

  GameForm.Casovac.Interval := Constants.POCATECNI_RYCHLOST;
  GameForm.Casovac.Enabled := true;

  scorelvl := 1
end;

end.
