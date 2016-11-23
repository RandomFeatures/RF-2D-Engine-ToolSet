object frmSetting: TfrmSetting
  Left = 237
  Top = 102
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Envrioment Settings'
  ClientHeight = 484
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 407
    Height = 484
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'File Paths'
      object Label1: TLabel
        Left = 16
        Top = 8
        Width = 136
        Height = 13
        Caption = 'Map File (*.map) Output Path'
      end
      object Label2: TLabel
        Left = 16
        Top = 50
        Width = 96
        Height = 13
        Caption = 'Texture Output Path'
      end
      object Label3: TLabel
        Left = 16
        Top = 91
        Width = 87
        Height = 13
        Caption = 'Script Output Path'
      end
      object Label4: TLabel
        Left = 16
        Top = 133
        Width = 74
        Height = 13
        Caption = 'Tile Image Path'
      end
      object Label5: TLabel
        Left = 16
        Top = 175
        Width = 96
        Height = 13
        Caption = 'Character DAT Path'
      end
      object Label6: TLabel
        Left = 16
        Top = 216
        Width = 64
        Height = 13
        Caption = 'Static Images'
      end
      object Label7: TLabel
        Left = 16
        Top = 258
        Width = 64
        Height = 13
        Caption = 'Editor Images'
      end
      object SpeedButton1: TSpeedButton
        Left = 370
        Top = 23
        Width = 23
        Height = 22
        Caption = '...'
      end
      object SpeedButton2: TSpeedButton
        Left = 370
        Top = 65
        Width = 23
        Height = 22
        Caption = '...'
      end
      object SpeedButton3: TSpeedButton
        Left = 370
        Top = 106
        Width = 23
        Height = 22
        Caption = '...'
      end
      object SpeedButton4: TSpeedButton
        Left = 370
        Top = 148
        Width = 23
        Height = 22
        Caption = '...'
      end
      object SpeedButton5: TSpeedButton
        Left = 370
        Top = 189
        Width = 23
        Height = 22
        Caption = '...'
      end
      object SpeedButton6: TSpeedButton
        Left = 370
        Top = 231
        Width = 23
        Height = 22
        Caption = '...'
      end
      object SpeedButton7: TSpeedButton
        Left = 370
        Top = 272
        Width = 23
        Height = 22
        Caption = '...'
      end
      object Label8: TLabel
        Left = 16
        Top = 299
        Width = 64
        Height = 13
        Caption = 'Sprite Images'
      end
      object SpeedButton8: TSpeedButton
        Left = 369
        Top = 314
        Width = 23
        Height = 22
        Caption = '...'
      end
      object Label10: TLabel
        Left = 16
        Top = 341
        Width = 60
        Height = 13
        Caption = 'Particle Path'
      end
      object SpeedButton10: TSpeedButton
        Left = 369
        Top = 355
        Width = 23
        Height = 22
        Caption = '...'
      end
      object Label11: TLabel
        Left = 16
        Top = 381
        Width = 57
        Height = 13
        Caption = 'Editor Script'
      end
      object SpeedButton11: TSpeedButton
        Left = 368
        Top = 395
        Width = 23
        Height = 22
        Caption = '...'
      end
      object edtMapPath: TEdit
        Left = 16
        Top = 24
        Width = 350
        Height = 21
        TabOrder = 0
      end
      object edtTexturePath: TEdit
        Left = 16
        Top = 66
        Width = 350
        Height = 21
        TabOrder = 1
      end
      object edtScriptPath: TEdit
        Left = 16
        Top = 107
        Width = 350
        Height = 21
        TabOrder = 2
      end
      object edtTilePath: TEdit
        Left = 16
        Top = 149
        Width = 350
        Height = 21
        TabOrder = 3
      end
      object edtChrPath: TEdit
        Left = 16
        Top = 190
        Width = 350
        Height = 21
        TabOrder = 4
      end
      object edtStaticPath: TEdit
        Left = 16
        Top = 232
        Width = 350
        Height = 21
        TabOrder = 5
      end
      object edtEditorPath: TEdit
        Left = 16
        Top = 273
        Width = 350
        Height = 21
        TabOrder = 6
      end
      object btnSave: TButton
        Left = 158
        Top = 424
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 7
        OnClick = btnSaveClick
      end
      object edtSpritePath: TEdit
        Left = 16
        Top = 315
        Width = 350
        Height = 21
        TabOrder = 8
      end
      object edtParticlePath: TEdit
        Left = 16
        Top = 356
        Width = 350
        Height = 21
        TabOrder = 9
      end
      object edtEditorScriptPath: TEdit
        Left = 16
        Top = 396
        Width = 350
        Height = 21
        TabOrder = 10
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object Label9: TLabel
        Left = 16
        Top = 11
        Width = 64
        Height = 13
        Caption = 'Game Engine'
      end
      object SpeedButton9: TSpeedButton
        Left = 369
        Top = 25
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton9Click
      end
      object edtGameEngine: TEdit
        Left = 16
        Top = 26
        Width = 350
        Height = 21
        TabOrder = 0
      end
    end
  end
  object PBFolderDialog1: TPBFolderDialog
    Flags = [ShowPath]
    NewFolderVisible = True
    NewFolderEnabled = True
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
    Left = 240
    Top = 16
  end
  object OpenExe: TOpenDialog
    Left = 284
    Top = 16
  end
end
