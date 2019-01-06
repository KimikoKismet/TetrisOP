unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TMenuForm = class(TForm)
    Image1: TImage;
    singleplayerButton: TImage;
    highScoreButton: TImage;
    multiplayerButton: TImage;
    exitButton: TImage;
    procedure exitButtonClick(Sender: TObject);
    procedure highScoreButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MenuForm: TMenuForm;

implementation

{$R *.dfm}

uses HighScore;

procedure TMenuForm.exitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMenuForm.highScoreButtonClick(Sender: TObject);
begin
  MenuForm.Visible := false;
  highScoreForm.ShowModal;
end;

end.
