unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MenuForm: TMenuForm;

implementation
uses Highscore, game;
{$R *.dfm}



procedure TMenuForm.exitButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMenuForm.highScoreButtonClick(Sender: TObject);
begin
  Application.CreateForm(ThighScoreForm, highScoreForm);
  highScoreForm.Show;
  Self.Hide;
end;

procedure TMenuForm.multiplayerButtonClick(Sender: TObject);
begin
  Application.CreateForm(TGameForm, GameForm);
  GameForm.Show;
  Self.Hide;
end;

procedure TMenuForm.singleplayerButtonClick(Sender: TObject);
begin
  Application.CreateForm(TGameForm, GameForm);
  GameForm.Show;
  Self.Hide;
end;

end.