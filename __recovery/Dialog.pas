unit Dialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TGameOver = class(TForm)
    Popis: TLabel;
    Username: TEdit;
    SaveHighScoreButton: TButton;
    procedure SaveHighScoreButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GameOver: TGameOver;


implementation

{$R *.dfm}
uses
    game;


procedure TGameOver.SaveHighScoreButtonClick(Sender: TObject);
var
  ulozeni : String;
begin
  ulozeni := Username.Text + ': ' + IntToStr(game.GameForm.score);

  GameOver.CloseModal;
end;

end.
