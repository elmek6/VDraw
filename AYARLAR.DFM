object frmAyarlar: TfrmAyarlar
  Left = 235
  Top = 119
  BorderStyle = bsDialog
  Caption = 'Ayarlar'
  ClientHeight = 327
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 28
    Width = 68
    Height = 13
    Caption = 'Levha genislik'
  end
  object Label2: TLabel
    Left = 20
    Top = 48
    Width = 77
    Height = 13
    Caption = 'Levha y'#252'kseklik'
  end
  object Label3: TLabel
    Left = 20
    Top = 108
    Width = 67
    Height = 13
    Caption = 'Izgara geni'#351'lik'
  end
  object Label4: TLabel
    Left = 20
    Top = 132
    Width = 76
    Height = 13
    Caption = 'Izgara y'#252'kseklik'
  end
  object chkIzgarayiGoster: TCheckBox
    Left = 20
    Top = 156
    Width = 97
    Height = 17
    Caption = 'Izgaray'#305' g'#246'ster'
    TabOrder = 0
  end
  object chkIzgarayaOturt: TCheckBox
    Left = 20
    Top = 176
    Width = 97
    Height = 17
    Caption = 'Izgaraya oturt'
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 228
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Tamam'
    Default = True
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 308
    Top = 296
    Width = 75
    Height = 25
    Cancel = True
    Caption = #304'ptal'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object txtLevhaGen: TNumEdit
    Left = 116
    Top = 20
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = '#,##0'
    MaxLength = 20
    TabOrder = 4
    Text = '0'
  end
  object txtLevgaYuk: TNumEdit
    Left = 116
    Top = 44
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = '#,##0'
    MaxLength = 20
    TabOrder = 5
    Text = '0'
  end
  object txtIzgaraGen: TNumEdit
    Left = 116
    Top = 104
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = '#,##0'
    MaxLength = 20
    TabOrder = 6
    Text = '0'
  end
  object txtIzgaraYuk: TNumEdit
    Left = 116
    Top = 128
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = '#,##0'
    MaxLength = 20
    TabOrder = 7
    Text = '0'
  end
end
