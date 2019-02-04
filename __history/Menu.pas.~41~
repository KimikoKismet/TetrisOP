unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

function gameModeSelection : String;

type
  TMenuForm = class(TForm)
    Background: TImage;
    singleplayerButton: TImage;
    highScoreButton: TImage;
    multiplayerButton: TImage;
    exitButton: TImage;
    procedure exitButtonClick(Sender: TObject);
    procedure highScoreButtonClick(Sender: TObject);
    procedure singleplayerButtonClick(Sender: TObject);
    procedure multiplayerButtonClick(Sender: TObject);
    procedure singleplayerButtonMouseEnter(Sender: TObject);
    procedure singleplayerButtonMouseLeave(Sender: TObject);
    procedure multiplayerButtonMouseEnter(Sender: TObject);
    procedure multiplayerButtonMouseLeave(Sender: TObject);
    procedure highScoreButtonMouseLeave(Sender: TObject);
    procedure highScoreButtonMouseEnter(Sender: TObject);
    procedure exitButtonMouseEnter(Sender: TObject);
    procedure exitButtonMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  MenuForm: TMenuForm;
  gameMode : Integer;

implementation
uses Highscore, game;
{$R *.dfm}



procedure TMenuForm.exitButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMenuForm.exitButtonMouseEnter(Sender: TObject);
begin
  ExitButton.Picture.LoadFromFile('obrazky\ExitClickButton.png');
end;

procedure TMenuForm.exitButtonMouseLeave(Sender: TObject);
begin
  ExitButton.Picture.LoadFromFile('obrazky\ExitButton.png')
end;

procedure TMenuForm.highScoreButtonClick(Sender: TObject);
begin
  Application.CreateForm(ThighScoreForm, highScoreForm);
  highScoreForm.Show;
  Self.Hide;
end;

procedure TMenuForm.highScoreButtonMouseEnter(Sender: TObject);
begin
  highScoreButton.Picture.LoadFromFile('obrazky\HighScoreClickButton.png');
end;

procedure TMenuForm.highScoreButtonMouseLeave(Sender: TObject);
begin
  highScoreButton.Picture.LoadFromFile('obrazky\HighScoreButton.png');
end;

procedure TMenuForm.multiplayerButtonClick(Sender: TObject);
begin
  gameMode := 2;
  Application.CreateForm(TGameForm, GameForm);
  GameForm.Show;
  Self.Hide;
end;

procedure TMenuForm.multiplayerButtonMouseEnter(Sender: TObject);
begin
  multiplayerButton.Picture.LoadFromFile('obrazky\MultiplayerClickButton.png');
end;

procedure TMenuForm.multiplayerButtonMouseLeave(Sender: TObject);
begin
  multiplayerButton.Picture.LoadFromFile('obrazky\MultiplayerButton.png');
end;

procedure TMenuForm.singleplayerButtonClick(Sender: TObject);
begin
  gameMode := 1;
  Application.CreateForm(TGameForm, GameForm);
  GameForm.Show;
  Self.Hide;
end;

procedure TMenuForm.singleplayerButtonMouseEnter(Sender: TObject);
begin
  SingleplayerButton.Picture.LoadFromFile('obrazky\SingleplayerClickButton.png');
end;

procedure TMenuForm.singleplayerButtonMouseLeave(Sender: TObject);
begin
  SingleplayerButton.Picture.LoadFromFile('obrazky\SingleplayerButton.png');
end;

function gameModeSelection : String;
begin
  if gameMode = 1 then result := 'obrazky\HowToPlaySingleplayer.png'
  else result := 'obrazky\HowToPlayMultiplayer.png';
end;

end.
