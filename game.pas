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
    procedure CreateParams(var Params: TCreateParams); override;

  private
    { Private declarations }
  public
    GameForm: TGameForm;
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

end.
