object frmNewMap: TfrmNewMap
  Left = 384
  Top = 204
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'New Map'
  ClientHeight = 160
  ClientWidth = 208
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 52
    Height = 13
    Caption = 'Map Width'
  end
  object Label2: TLabel
    Left = 112
    Top = 8
    Width = 55
    Height = 13
    Caption = 'Map Height'
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 48
    Height = 13
    Caption = 'Tile Width'
  end
  object Label4: TLabel
    Left = 112
    Top = 64
    Width = 51
    Height = 13
    Caption = 'Tile Height'
  end
  object edtMapHeight: TNumEdit
    Left = 112
    Top = 24
    Width = 81
    Height = 21
    TabOrder = 0
    Text = '44'
  end
  object edtMapWidth: TNumEdit
    Left = 8
    Top = 24
    Width = 81
    Height = 21
    TabOrder = 1
    Text = '18'
  end
  object edtTileWidth: TNumEdit
    Left = 8
    Top = 80
    Width = 81
    Height = 21
    Enabled = False
    TabOrder = 2
    Text = '64'
  end
  object EdtTileHeight: TNumEdit
    Left = 112
    Top = 80
    Width = 81
    Height = 21
    Enabled = False
    TabOrder = 3
    Text = '32'
  end
  object btnOk: TButton
    Left = 67
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 4
    OnClick = btnOkClick
  end
end
