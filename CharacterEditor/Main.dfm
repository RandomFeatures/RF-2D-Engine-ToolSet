object frmMain: TfrmMain
  Left = 617
  Top = 318
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Character Editor'
  ClientHeight = 280
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 160
    Top = 16
    Width = 27
    Height = 13
    Caption = 'GUID'
  end
  object Label2: TLabel
    Left = 320
    Top = 16
    Width = 77
    Height = 13
    Caption = 'Character Name'
  end
  object Label3: TLabel
    Left = 160
    Top = 119
    Width = 65
    Height = 13
    Caption = 'Attack Rating'
  end
  object Label4: TLabel
    Left = 262
    Top = 119
    Width = 78
    Height = 13
    Caption = 'Hitpoints  Rating'
  end
  object Label5: TLabel
    Left = 363
    Top = 120
    Width = 74
    Height = 13
    Caption = 'Defense Rating'
  end
  object Label6: TLabel
    Left = 457
    Top = 207
    Width = 50
    Height = 13
    Caption = 'Movement'
  end
  object Label7: TLabel
    Left = 462
    Top = 175
    Width = 45
    Height = 13
    Caption = 'Hit Points'
  end
  object Label8: TLabel
    Left = 160
    Top = 175
    Width = 69
    Height = 13
    Caption = 'Magical Resist'
  end
  object Label9: TLabel
    Left = 158
    Top = 207
    Width = 71
    Height = 13
    Caption = 'Physical Resist'
  end
  object Label10: TLabel
    Left = 320
    Top = 175
    Width = 60
    Height = 13
    Caption = 'Min Damage'
  end
  object Label11: TLabel
    Left = 317
    Top = 207
    Width = 63
    Height = 13
    Caption = 'Max Damage'
  end
  object Label12: TLabel
    Left = 160
    Top = 64
    Width = 25
    Height = 13
    Caption = 'Class'
  end
  object Label13: TLabel
    Left = 467
    Top = 120
    Width = 61
    Height = 13
    Caption = 'Move Rating'
  end
  object Label14: TLabel
    Left = 472
    Top = 64
    Width = 60
    Height = 13
    Caption = 'Character ID'
  end
  object Label15: TLabel
    Left = 248
    Top = 64
    Width = 37
    Height = 13
    Caption = 'Spell ID'
  end
  object btnCharDat: TSpeedButton
    Left = 538
    Top = 79
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = btnCharDatClick
  end
  object Label16: TLabel
    Left = 8
    Top = 16
    Width = 65
    Height = 13
    Caption = 'Character List'
  end
  object Label17: TLabel
    Left = 368
    Top = 64
    Width = 29
    Height = 13
    Caption = 'Group'
  end
  object Label18: TLabel
    Left = 520
    Top = 16
    Width = 32
    Height = 13
    Caption = 'DB_ID'
  end
  object lbMain: TListBox
    Left = 8
    Top = 32
    Width = 137
    Height = 233
    ItemHeight = 13
    TabOrder = 0
    OnClick = lbMainClick
    OnDblClick = btnEditClick
  end
  object cbHitRating: TComboBox
    Left = 262
    Top = 135
    Width = 96
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 4
    Items.Strings = (
      'Low-'
      'Low'
      'Medium'
      'High'
      'High+')
  end
  object cbDefRating: TComboBox
    Left = 363
    Top = 135
    Width = 96
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 5
    Items.Strings = (
      'Low-'
      'Low'
      'Medium'
      'High'
      'High+')
  end
  object cbAttRating: TComboBox
    Left = 160
    Top = 135
    Width = 96
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      'Low-'
      'Low'
      'Medium'
      'High'
      'High+')
  end
  object edtGUID: TEdit
    Left = 160
    Top = 32
    Width = 153
    Height = 21
    TabStop = False
    Enabled = False
    TabOrder = 14
    Text = 'auto'
  end
  object edtName: TEdit
    Left = 320
    Top = 32
    Width = 193
    Height = 21
    Enabled = False
    TabOrder = 1
    Text = 'Name'
  end
  object edtMagResist: TNumEdit
    Left = 240
    Top = 171
    Width = 49
    Height = 21
    Enabled = False
    TabOrder = 7
    Text = '0.0'
  end
  object edtPhyResist: TNumEdit
    Left = 240
    Top = 203
    Width = 49
    Height = 21
    Enabled = False
    TabOrder = 10
    Text = '0.0'
  end
  object edtHits: TNumEdit
    Left = 512
    Top = 171
    Width = 49
    Height = 21
    Enabled = False
    TabOrder = 9
    Text = '100'
  end
  object editMin: TNumEdit
    Left = 384
    Top = 171
    Width = 49
    Height = 21
    Enabled = False
    TabOrder = 8
    Text = '1'
  end
  object edtMax: TNumEdit
    Left = 384
    Top = 203
    Width = 49
    Height = 21
    Enabled = False
    TabOrder = 11
    Text = '5'
  end
  object cbMove: TComboBox
    Left = 512
    Top = 203
    Width = 49
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 12
    Items.Strings = (
      '3'
      '4'
      '6'
      '8'
      '10'
      '12'
      '16')
  end
  object btnNew: TButton
    Left = 160
    Top = 240
    Width = 75
    Height = 25
    Caption = 'New'
    TabOrder = 13
    OnClick = btnNewClick
  end
  object btnUpdate: TButton
    Left = 336
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Save'
    Enabled = False
    TabOrder = 15
    OnClick = btnUpdateClick
  end
  object btnDelete: TButton
    Left = 456
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 16
    OnClick = btnDeleteClick
  end
  object cbClass: TComboBox
    Left = 160
    Top = 80
    Width = 81
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      'Warrior'
      'Thief'
      'Caster'
      'Archer')
  end
  object cbMoveRating: TComboBox
    Left = 467
    Top = 135
    Width = 96
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 6
    Items.Strings = (
      'Low-'
      'Low'
      'Medium'
      'High'
      'High+')
  end
  object btnEdit: TButton
    Left = 248
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Edit'
    TabOrder = 17
    OnClick = btnEditClick
  end
  object cbSpells: TComboBox
    Left = 248
    Top = 80
    Width = 113
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 18
  end
  object Panel1: TPanel
    Left = 568
    Top = 32
    Width = 137
    Height = 233
    BevelOuter = bvLowered
    TabOrder = 19
    object imgPreview: TImage
      Left = 1
      Top = 1
      Width = 135
      Height = 231
      Align = alClient
      Center = True
      Transparent = True
    end
  end
  object edtISO_CharacterID: TNumEdit
    Left = 472
    Top = 79
    Width = 65
    Height = 21
    Enabled = False
    TabOrder = 20
    Text = '0'
  end
  object cbGroup: TComboBox
    Left = 368
    Top = 80
    Width = 97
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 21
    Items.Strings = (
      'Human'
      'Orc'
      'Undead'
      'Barbarian')
  end
  object edtDB_ID: TEdit
    Left = 520
    Top = 32
    Width = 41
    Height = 21
    Enabled = False
    TabOrder = 22
    Text = '0'
  end
  object MainMenu1: TMainMenu
    Left = 600
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
  end
  object PBFolderDialog1: TPBFolderDialog
    Flags = [OnlyFileSystem, ShowPath]
    NewFolderVisible = False
    NewFolderEnabled = False
    LabelCaptions.Strings = (
      'Default=Current folder:'
      '0009=Current folder:'
      '0406=Valgt mappe:'
      '0407=Ausgewählter Ordner:'
      '0409=Current folder:'
      '0410=Cartella selezionata:'
      '0413=Huidige map'
      '0416=Pasta Atual:'
      '0807=Ausgewählter Ordner:'
      '0809=Current folder:'
      '0810=Cartella selezionata:'
      '0C07=Ausgewählter Ordner:'
      '0C09=Current folder:'
      '1007=Ausgewählter Ordner:'
      '1009=Current folder:'
      '1407=Ausgewählter Ordner:'
      '1409=Current folder:'
      '1809=Current folder:'
      '1C09=Current folder:'
      '2009=Current folder:'
      '2809=Current folder:'
      '2C09=Current folder:')
    NewFolderCaptions.Strings = (
      'Default=New folder'
      '0009=New folder'
      '0406=Ny mappe'
      '0407=Neuer Ordner'
      '0409=New folder'
      '0410=Nuova Cartella'
      '0413=Nieuwe map'
      '0416=Nova Pasta'
      '0807=Neuer Ordner'
      '0809=New folder'
      '0810=Nuova Cartella'
      '0C07=Neuer Ordner'
      '0C09=New folder'
      '1007=Neuer Ordner'
      '1009=New folder'
      '1407=Neuer Ordner'
      '1409=New folder'
      '1809=New folder'
      '1C09=New folder'
      '2009=New folder'
      '2809=New folder'
      '2C09=New folder')
    Left = 624
  end
  object SaveDialog1: TSaveDialog
    Left = 648
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.chr'
    Filter = '*.chr|*.chr'
    Left = 576
  end
end
