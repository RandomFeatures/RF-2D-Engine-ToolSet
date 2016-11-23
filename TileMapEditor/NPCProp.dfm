object frmNPCProp: TfrmNPCProp
  Left = 272
  Top = 491
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Character Properties'
  ClientHeight = 161
  ClientWidth = 522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 522
    Height = 177
    ActivePage = tsStatic
    Align = alTop
    TabOrder = 0
    object tsCmmon: TTabSheet
      Caption = 'Common'
      object GroupBox1: TGroupBox
        Left = 177
        Top = 0
        Width = 163
        Height = 105
        Caption = 'Color/Blend'
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 17
          Width = 20
          Height = 13
          Caption = 'Red'
        end
        object Label8: TLabel
          Left = 88
          Top = 17
          Width = 21
          Height = 13
          Caption = 'Blue'
        end
        object Label9: TLabel
          Left = 8
          Top = 57
          Width = 29
          Height = 13
          Caption = 'Green'
        end
        object Label10: TLabel
          Left = 88
          Top = 57
          Width = 27
          Height = 13
          Caption = 'Blend'
        end
        object edtRed: TNumEdit
          Left = 8
          Top = 31
          Width = 73
          Height = 21
          TabOrder = 0
          OnChange = edtNPCNameChange
        end
        object edtBlue: TNumEdit
          Left = 88
          Top = 31
          Width = 65
          Height = 21
          TabOrder = 1
          OnChange = edtNPCNameChange
        end
        object edtGreen: TNumEdit
          Left = 8
          Top = 71
          Width = 73
          Height = 21
          TabOrder = 2
          OnChange = edtNPCNameChange
        end
        object edtBlend: TNumEdit
          Left = 88
          Top = 71
          Width = 65
          Height = 21
          TabOrder = 3
          OnChange = edtNPCNameChange
        end
      end
      object GroupBox2: TGroupBox
        Left = 345
        Top = 0
        Width = 163
        Height = 57
        Caption = 'Group'
        TabOrder = 1
        object Label6: TLabel
          Left = 8
          Top = 12
          Width = 11
          Height = 13
          Caption = 'ID'
        end
        object Label7: TLabel
          Left = 88
          Top = 12
          Width = 26
          Height = 13
          Caption = 'Layer'
        end
        object cbGroupID: TComboBox
          Left = 8
          Top = 28
          Width = 73
          Height = 21
          ItemHeight = 13
          MaxLength = 20
          Sorted = True
          TabOrder = 0
          OnChange = edtNPCNameChange
        end
        object cbLayer: TComboBox
          Left = 88
          Top = 28
          Width = 65
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          MaxLength = 20
          Sorted = True
          TabOrder = 1
          OnChange = edtNPCNameChange
          Items.Strings = (
            '0 - Below Ground'
            '1 - Ground'
            '2 - World'
            '3 - Roof')
        end
      end
      object GroupBox3: TGroupBox
        Left = 9
        Top = 0
        Width = 163
        Height = 113
        Caption = 'Common'
        TabOrder = 2
        object Label1: TLabel
          Left = 8
          Top = 14
          Width = 28
          Height = 13
          Caption = 'Name'
        end
        object lblX: TLabel
          Left = 8
          Top = 54
          Width = 31
          Height = 13
          Caption = 'X = 0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 8
          Top = 69
          Width = 32
          Height = 13
          Caption = 'Facing'
        end
        object lblY: TLabel
          Left = 88
          Top = 54
          Width = 31
          Height = 13
          Caption = 'Y = 0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 88
          Top = 69
          Width = 27
          Height = 13
          Caption = 'GUID'
        end
        object Label19: TLabel
          Left = 88
          Top = 16
          Width = 21
          Height = 13
          Caption = 'Side'
        end
        object edtNPCName: TEdit
          Left = 8
          Top = 30
          Width = 73
          Height = 21
          MaxLength = 20
          TabOrder = 0
          OnChange = edtNPCNameChange
          OnKeyDown = edtNPCNameKeyDown
        end
        object cbFacing: TComboBox
          Left = 8
          Top = 85
          Width = 73
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          OnChange = cbFacingChange
          Items.Strings = (
            'NE'
            'NW'
            'SE'
            'SW')
        end
        object edtGUID: TEdit
          Left = 88
          Top = 85
          Width = 65
          Height = 21
          TabOrder = 2
          OnChange = edtNPCNameChange
        end
      end
    end
    object tsEvents: TTabSheet
      Caption = 'Events'
      ImageIndex = 4
      object Label3: TLabel
        Left = 8
        Top = 12
        Width = 53
        Height = 13
        Caption = 'OnActivate'
      end
      object Label11: TLabel
        Left = 8
        Top = 36
        Width = 57
        Height = 13
        Caption = 'OnAttacked'
      end
      object Label12: TLabel
        Left = 8
        Top = 60
        Width = 40
        Height = 13
        Caption = 'OnClose'
      end
      object Label13: TLabel
        Left = 8
        Top = 84
        Width = 30
        Height = 13
        Caption = 'OnDie'
      end
      object Label14: TLabel
        Left = 8
        Top = 108
        Width = 76
        Height = 13
        Caption = 'OnFirstAttacked'
      end
      object Label15: TLabel
        Left = 240
        Top = 12
        Width = 38
        Height = 13
        Caption = 'OnLoad'
      end
      object Label16: TLabel
        Left = 240
        Top = 36
        Width = 40
        Height = 13
        Caption = 'OnOpen'
      end
      object Label17: TLabel
        Left = 240
        Top = 60
        Width = 36
        Height = 13
        Caption = 'Combat'
      end
      object Label18: TLabel
        Left = 240
        Top = 84
        Width = 17
        Height = 13
        Caption = 'Idle'
      end
      object cbOnActivate: TComboBox
        Left = 94
        Top = 8
        Width = 123
        Height = 21
        Hint = '_OnActivate'
        ItemHeight = 13
        TabOrder = 0
        OnChange = edtNPCNameChange
        OnDblClick = cbOnActivateDblClick
      end
      object cbOnAttacked: TComboBox
        Left = 94
        Top = 32
        Width = 123
        Height = 21
        Hint = '_OnAttacked'
        ItemHeight = 13
        TabOrder = 1
        OnChange = edtNPCNameChange
        OnDblClick = cbOnActivateDblClick
      end
      object cbOnClose: TComboBox
        Left = 94
        Top = 56
        Width = 123
        Height = 21
        Hint = '_OnClose'
        ItemHeight = 13
        TabOrder = 2
        OnChange = edtNPCNameChange
        OnDblClick = cbOnActivateDblClick
      end
      object cbOnDie: TComboBox
        Left = 94
        Top = 80
        Width = 123
        Height = 21
        Hint = '_OnDie'
        ItemHeight = 13
        TabOrder = 3
        OnChange = edtNPCNameChange
        OnDblClick = cbOnActivateDblClick
      end
      object cbOnFirstAttacked: TComboBox
        Left = 94
        Top = 104
        Width = 123
        Height = 21
        Hint = '_OnFirstAttacked'
        ItemHeight = 13
        TabOrder = 4
        OnChange = edtNPCNameChange
        OnDblClick = cbOnActivateDblClick
      end
      object cbOnLoad: TComboBox
        Left = 326
        Top = 8
        Width = 123
        Height = 21
        Hint = '_OnLoad'
        ItemHeight = 13
        TabOrder = 5
        OnChange = edtNPCNameChange
        OnDblClick = cbOnActivateDblClick
      end
      object cbOnOpen: TComboBox
        Left = 326
        Top = 32
        Width = 123
        Height = 21
        Hint = '_OnOpen'
        ItemHeight = 13
        TabOrder = 6
        OnChange = edtNPCNameChange
        OnDblClick = cbOnActivateDblClick
      end
      object cbOnCombat: TComboBox
        Left = 326
        Top = 56
        Width = 123
        Height = 21
        Hint = '_Combat'
        ItemHeight = 13
        TabOrder = 7
        OnChange = edtNPCNameChange
        OnDblClick = cbOnActivateDblClick
      end
      object cbOnIdle: TComboBox
        Left = 326
        Top = 80
        Width = 123
        Height = 21
        Hint = '_Idle'
        ItemHeight = 13
        TabOrder = 8
        OnChange = edtNPCNameChange
        OnDblClick = cbOnActivateDblClick
      end
    end
    object tsCharacter: TTabSheet
      Caption = 'Character'
      Enabled = False
      ImageIndex = 2
      object Label20: TLabel
        Left = 4
        Top = 0
        Width = 25
        Height = 13
        Caption = 'Class'
      end
      object Label21: TLabel
        Left = 117
        Top = 0
        Width = 37
        Height = 13
        Caption = 'Spell ID'
      end
      object Label22: TLabel
        Left = 117
        Top = 41
        Width = 65
        Height = 13
        Caption = 'Attack Rating'
      end
      object Label23: TLabel
        Left = 4
        Top = 41
        Width = 78
        Height = 13
        Caption = 'Hitpoints  Rating'
      end
      object Label24: TLabel
        Left = 4
        Top = 83
        Width = 74
        Height = 13
        Caption = 'Defense Rating'
      end
      object Label25: TLabel
        Left = 117
        Top = 83
        Width = 61
        Height = 13
        Caption = 'Move Rating'
      end
      object Label26: TLabel
        Left = 228
        Top = 4
        Width = 80
        Height = 13
        Caption = 'Magical Resist %'
      end
      object Label27: TLabel
        Left = 341
        Top = 4
        Width = 60
        Height = 13
        Caption = 'Min Damage'
      end
      object Label28: TLabel
        Left = 228
        Top = 87
        Width = 45
        Height = 13
        Caption = 'Hit Points'
      end
      object Label29: TLabel
        Left = 228
        Top = 46
        Width = 82
        Height = 13
        Caption = 'Physical Resist %'
      end
      object Label30: TLabel
        Left = 341
        Top = 46
        Width = 63
        Height = 13
        Caption = 'Max Damage'
      end
      object Label31: TLabel
        Left = 341
        Top = 87
        Width = 50
        Height = 13
        Caption = 'Movement'
      end
      object Label32: TLabel
        Left = 330
        Top = 23
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label33: TLabel
        Left = 328
        Top = 63
        Width = 8
        Height = 13
        Caption = '%'
      end
      object cbClass: TComboBox
        Left = 3
        Top = 16
        Width = 102
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = edtNPCNameChange
        Items.Strings = (
          'Warrior'
          'Thief'
          'Caster'
          'Archer')
      end
      object cbSpells: TComboBox
        Left = 117
        Top = 16
        Width = 102
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = edtNPCNameChange
      end
      object cbAttRating: TComboBox
        Left = 117
        Top = 57
        Width = 102
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        OnChange = edtNPCNameChange
        Items.Strings = (
          'Low-'
          'Low'
          'Medium'
          'High'
          'High+')
      end
      object cbHealthRating: TComboBox
        Left = 3
        Top = 57
        Width = 102
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnChange = edtNPCNameChange
        Items.Strings = (
          'Low-'
          'Low'
          'Medium'
          'High'
          'High+')
      end
      object cbDefRating: TComboBox
        Left = 3
        Top = 97
        Width = 102
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        OnChange = edtNPCNameChange
        Items.Strings = (
          'Low-'
          'Low'
          'Medium'
          'High'
          'High+')
      end
      object cbMoveRating: TComboBox
        Left = 117
        Top = 97
        Width = 102
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
        OnChange = edtNPCNameChange
        Items.Strings = (
          'Low-'
          'Low'
          'Medium'
          'High'
          'High+')
      end
      object edtMagResist: TNumEdit
        Left = 227
        Top = 18
        Width = 102
        Height = 21
        MaxLength = 2
        TabOrder = 6
        Text = '0'
        OnChange = edtNPCNameChange
        OnExit = edtMagResistExit
      end
      object editMin: TNumEdit
        Left = 341
        Top = 18
        Width = 102
        Height = 21
        TabOrder = 7
        Text = '1'
        OnChange = edtNPCNameChange
      end
      object edtHits: TNumEdit
        Left = 227
        Top = 99
        Width = 102
        Height = 21
        TabOrder = 10
        Text = '100'
        OnChange = edtNPCNameChange
      end
      object edtPhyResist: TNumEdit
        Left = 227
        Top = 58
        Width = 102
        Height = 21
        MaxLength = 2
        TabOrder = 8
        Text = '0'
        OnChange = edtNPCNameChange
        OnExit = edtMagResistExit
      end
      object edtMax: TNumEdit
        Left = 341
        Top = 58
        Width = 102
        Height = 21
        TabOrder = 9
        Text = '5'
        OnChange = edtNPCNameChange
      end
      object cbMove: TComboBox
        Left = 341
        Top = 99
        Width = 102
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 11
        OnChange = edtNPCNameChange
        Items.Strings = (
          '3'
          '4'
          '6'
          '8'
          '10'
          '12'
          '16')
      end
    end
    object tsStatic: TTabSheet
      Caption = 'Statics'
      ImageIndex = 3
      object lblStX: TLabel
        Left = 424
        Top = 24
        Width = 31
        Height = 13
        Caption = 'X = 0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStY: TLabel
        Left = 472
        Top = 24
        Width = 31
        Height = 13
        Caption = 'Y = 0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label36: TLabel
        Left = 8
        Top = 89
        Width = 43
        Height = 13
        Caption = 'Group ID'
      end
      object Label37: TLabel
        Left = 8
        Top = 49
        Width = 33
        Height = 13
        Caption = 'Length'
      end
      object Label38: TLabel
        Left = 112
        Top = 49
        Width = 28
        Height = 13
        Caption = 'Width'
      end
      object Label39: TLabel
        Left = 8
        Top = 9
        Width = 52
        Height = 13
        Caption = 'Frame Indx'
      end
      object Label40: TLabel
        Left = 112
        Top = 9
        Width = 54
        Height = 13
        Caption = 'Draw Order'
      end
      object Label41: TLabel
        Left = 216
        Top = 9
        Width = 20
        Height = 13
        Caption = 'Red'
      end
      object Label42: TLabel
        Left = 320
        Top = 9
        Width = 21
        Height = 13
        Caption = 'Blue'
      end
      object Label43: TLabel
        Left = 216
        Top = 49
        Width = 29
        Height = 13
        Caption = 'Green'
      end
      object Label44: TLabel
        Left = 320
        Top = 49
        Width = 27
        Height = 13
        Caption = 'Blend'
      end
      object Label45: TLabel
        Left = 112
        Top = 87
        Width = 26
        Height = 13
        Caption = 'Layer'
      end
      object cbStGroupID: TComboBox
        Left = 8
        Top = 103
        Width = 89
        Height = 21
        ItemHeight = 13
        Sorted = True
        TabOrder = 0
        OnClick = edtFrameIndxChange
      end
      object edtLength: TNumEdit
        Left = 8
        Top = 63
        Width = 89
        Height = 21
        TabOrder = 1
        OnClick = edtFrameIndxChange
      end
      object edtWidth: TNumEdit
        Left = 112
        Top = 63
        Width = 89
        Height = 21
        TabOrder = 2
        OnClick = edtFrameIndxChange
      end
      object edtDrawOrder: TNumEdit
        Left = 112
        Top = 23
        Width = 89
        Height = 21
        TabOrder = 3
        OnClick = edtFrameIndxChange
      end
      object edtStRed: TNumEdit
        Left = 216
        Top = 23
        Width = 89
        Height = 21
        TabOrder = 4
        OnClick = edtFrameIndxChange
      end
      object edtStBlue: TNumEdit
        Left = 320
        Top = 23
        Width = 89
        Height = 21
        TabOrder = 5
        OnClick = edtFrameIndxChange
      end
      object edtStGreen: TNumEdit
        Left = 216
        Top = 63
        Width = 89
        Height = 21
        TabOrder = 6
        OnClick = edtFrameIndxChange
      end
      object edtStBlend: TNumEdit
        Left = 320
        Top = 63
        Width = 89
        Height = 21
        TabOrder = 7
        OnClick = edtFrameIndxChange
      end
      object cbStLayer: TComboBox
        Left = 112
        Top = 103
        Width = 89
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        MaxLength = 20
        Sorted = True
        TabOrder = 8
        OnClick = edtFrameIndxChange
        Items.Strings = (
          '0 - Below Ground'
          '1 - Ground'
          '2 - World'
          '3 - Roof')
      end
      object cbShadow: TCheckBox
        Left = 216
        Top = 104
        Width = 89
        Height = 17
        Caption = 'Shadow'
        Checked = True
        State = cbChecked
        TabOrder = 9
        OnClick = edtFrameIndxChange
      end
      object edtFrameIndx: TEdit
        Left = 8
        Top = 23
        Width = 89
        Height = 21
        TabOrder = 10
        OnChange = edtFrameIndxChange
      end
      object pnAmbientColor: TPanel
        Left = 320
        Top = 96
        Width = 41
        Height = 25
        BevelOuter = bvLowered
        Color = clWhite
        TabOrder = 11
        OnClick = edtFrameIndxChange
      end
    end
  end
  object cDialog: TColorDialog
    Ctl3D = True
    Left = 248
    Top = 137
  end
end
