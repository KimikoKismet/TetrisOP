program Project1;

uses
  Vcl.Forms,
  Menu in 'Menu.pas' {MenuForm},
  Highscore in 'Highscore.pas' {highScoreForm},
  game in 'game.pas' {GameForm},
  score in 'score.pas',
  Constants in 'Constants.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMenuForm, MenuForm);
  Application.CreateForm(ThighScoreForm, highScoreForm);
  Application.CreateForm(TGameForm, GameForm);
  Application.Run;
end.
