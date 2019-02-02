unit game;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

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
  Control.Picture.LoadFromFile(gameModeSelection);
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
