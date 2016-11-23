program StaticMaker;

uses
  Forms,
  main in 'main.pas' {frmMain},
  frameEdit in 'frameEdit.pas' {frmFrameEdit},
  staticlist in 'staticlist.pas' {frmStaticList};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmFrameEdit, frmFrameEdit);
  Application.CreateForm(TfrmStaticList, frmStaticList);
  Application.Run;
end.
