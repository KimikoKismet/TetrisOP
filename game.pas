unit game;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TGameForm = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image2: TImage;
    RetryButton: TImage;
    Control: TImage;
    Image5: TImage;
    ExitButton: TImage;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GameForm: TGameForm;

implementation
uses Menu;

{$R *.dfm}

procedure TGameForm.FormActivate(Sender: TObject);
begin
  Control.Picture.LoadFromFile('C:\Users\gmich\Dropbox\TetrisOP\obrazky\HowToPlaySingleplayer.png');
end;


procedure TGameForm.ExitButtonClick(Sender: TObject);
begin
  Close;
  MenuForm.Show;
  MenuForm.SetFocus;
end;

end.
