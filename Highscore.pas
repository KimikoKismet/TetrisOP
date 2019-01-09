unit Highscore;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  ThighScoreForm = class(TForm)
    Image1: TImage;
    score: TStringGrid;
    backButton: TImage;
    procedure backButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    highScoreForm: ThighScoreForm;
    { Public declarations }
  end;

var
  highScoreForm: ThighScoreForm;

implementation
uses Menu;
{$R *.dfm}

procedure ThighScoreForm.backButtonClick(Sender: TObject);
begin
  Close;
  MenuForm.Show;
  MenuForm.SetFocus;
end;

end.
