program TileMapEditor;

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
  GameObjects in 'GameObjects.pas',
  mapList in 'mapList.pas' {frmMapList},
  mapsfx in 'mapsfx.pas' {frmSFX};

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
  Application.CreateForm(TfrmMapList, frmMapList);
  Application.CreateForm(TfrmSFX, frmSFX);
  Application.Run;
end.
