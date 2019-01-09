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
    procedure CreateParams(var Params: TCreateParams); override;
    procedure backButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure ThighScoreForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure ThighScoreForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure ThighScoreForm.backButtonClick(Sender: TObject);
begin
  MenuForm.Show;
  Close;
  //MenuForm.SetFocus;
end;

end.
