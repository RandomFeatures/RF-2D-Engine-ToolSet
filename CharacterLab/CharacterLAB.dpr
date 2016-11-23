program CharacterLAB;

{%ToDo 'BuildLayer.todo'}
{%ToDo 'CharacterLAB.todo'}

uses
  Forms,
  BuildLayer1 in 'BuildLayer1.pas' {frmBuildLayer},
  Actions in 'Actions.pas' {frmAction},
  process in 'process.pas' {frmProcess},
  options in 'Options.pas' {frmOptions};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Character LAB';
  Application.CreateForm(TfrmBuildLayer, frmBuildLayer);
  Application.CreateForm(TfrmAction, frmAction);
  Application.CreateForm(TfrmProcess, frmProcess);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
