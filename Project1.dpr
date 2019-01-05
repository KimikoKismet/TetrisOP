program Project1;

uses
  Vcl.Forms,
  Menu in 'Menu.pas' {MenuForm},
  Highscore in 'Highscore.pas' {Form1},
  game in 'game.pas' {Singleplayer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMenuForm, MenuForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSingleplayer, Singleplayer);
  Application.Run;
end.
