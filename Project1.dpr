program Project1;

uses
  Vcl.Forms,
  Menu in 'Menu.pas' {MenuForm},
  Highscore in 'Highscore.pas' {highScoreForm},
  game in 'game.pas' {Singleplayer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMenuForm, MenuForm);
  Application.CreateForm(ThighScoreForm, highScoreForm);
  Application.CreateForm(TSingleplayer, Singleplayer);
  Application.Run;
end.
