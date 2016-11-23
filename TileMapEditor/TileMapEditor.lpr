program TileMapEditor;

{$MODE Delphi}

uses
  Forms,
  main in 'main.pas' {frmMain},
  newMap in 'newMap.pas' {frmNewMap},
  settings in 'settings.pas' {frmSetting},
  NPCProp in 'NPCProp.pas' {frmNPCProp},
  scriptMain in 'scriptMain.pas' {frmScript},
  TileData in 'TileData.pas',
  StaticProp in 'StaticProp.pas' {frmStaticProp},
  mapprop in 'mapprop.pas' {frmMapProp},
  GameObjects in 'GameObjects.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Tile Map Editor';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmNewMap, frmNewMap);
  Application.CreateForm(TfrmSetting, frmSetting);
  Application.CreateForm(TfrmNPCProp, frmNPCProp);
  Application.CreateForm(TfrmScript, frmScript);
  Application.CreateForm(TfrmStaticProp, frmStaticProp);
  Application.CreateForm(TfrmMapProp, frmMapProp);
  Application.Run;
end.
