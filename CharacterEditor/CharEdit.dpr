program CharEdit;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  charObj in 'charObj.pas',
  CharacterFiles in 'CharacterFiles.pas' {frmCharacterFiles};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmCharacterFiles, frmCharacterFiles);
  Application.Run;
end.
