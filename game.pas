unit game;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  Kosticka;

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

  private
    { Private declarations }
  public
    GameForm: TGameForm;
    { Public declarations }
  end;

var
  GameForm : TGameForm;
  aktualKosticka,nasledujiciKosticka : TKosticka;

implementation
uses Menu;

{$R *.dfm}

procedure TGameForm.FormActivate(Sender: TObject);
begin
  Control.Picture.LoadFromFile(gameModeSelection);
end;

procedure TGameForm.RetryButtonMouseEnter(Sender: TObject);
begin
  RetryButton.Picture.LoadFromFile('obrazky\RetryClickButton.png');
end;

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

procedure TGameForm.ExitButtonMouseEnter(Sender: TObject);
begin
  ExitButton.Picture.LoadFromFile('obrazky\ExitClickButton.png');
end;

procedure TGameForm.ExitButtonMouseLeave(Sender: TObject);
begin
  ExitButton.Picture.LoadFromFile('obrazky\ExitButton.png');
end;

procedure gameInit;
begin

end;

end.
