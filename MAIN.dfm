object frmMain: TfrmMain
  Left = 90
  Top = 63
  Width = 623
  Height = 478
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 615
    Height = 29
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        Width = 611
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 598
      Height = 25
      ButtonHeight = 21
      ButtonWidth = 43
      Caption = 'ToolBar1'
      EdgeInner = esNone
      EdgeOuter = esNone
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      object ToolButton2: TToolButton
        Left = 0
        Top = 2
        Action = gorunumZoomIn
        AutoSize = True
      end
      object ToolButton3: TToolButton
        Left = 47
        Top = 2
        Action = gorunumZoomOut
        AutoSize = True
      end
      object ToolButton1: TToolButton
        Left = 91
        Top = 2
        Action = gorunumZoom11
        AutoSize = True
      end
      object Button1: TButton
        Left = 117
        Top = 2
        Width = 75
        Height = 21
        Caption = 'Button1'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 192
        Top = 2
        Width = 75
        Height = 21
        Caption = 'Button2'
        TabOrder = 1
      end
    end
  end
  object sbMain: TStatusBar
    Left = 0
    Top = 413
    Width = 615
    Height = 19
    Panels = <
      item
        Text = 'Zoom: -'
        Width = 50
      end>
    SimplePanel = False
  end
  object ActionManager1: TActionManager
    ActionBars.SessionCount = 20
    ActionBars = <>
    LinkedActionLists = <>
    Left = 268
    Top = 236
    object dosyaYeni: TAction
      Category = 'dosya'
      Caption = 'Yeni'
      OnExecute = dosyaYeniExecute
    end
    object dosyaAc: TAction
      Category = 'dosya'
      Caption = 'A'#231'...'
      OnExecute = dosyaAcExecute
    end
    object gorunumZoomIn: TAction
      Category = 'gorunum'
      Caption = 'Zoom +'
      OnExecute = gorunumZoomExecute
    end
    object gorunumZoomOut: TAction
      Category = 'gorunum'
      Caption = 'Zoom -'
      OnExecute = gorunumZoomExecute
    end
    object gorunumZoom11: TAction
      Category = 'gorunum'
      Caption = '1:1'
      OnExecute = gorunumZoomExecute
    end
    object dosyaFarkliKaydet: TAction
      Category = 'dosya'
      Caption = 'Farkli Kaydet ...'
      OnExecute = dosyaFarkliKaydetExecute
    end
    object duzenGeriAl: TAction
      Category = 'duzen'
      Caption = 'Geri Al ...'
      ShortCut = 16474
      OnExecute = duzenGeriAlExecute
    end
    object gorunumCiz: TAction
      Category = 'gorunum'
      Caption = #199'iz'
      OnExecute = gorunumCizExecute
    end
    object dosyaCizdir: TAction
      Category = 'dosya'
      Caption = #199'izdir'
      OnExecute = dosyaCizdirExecute
    end
    object dosyaCikis: TAction
      Category = 'dosya'
      Caption = #199#305'k'#305#351
      OnExecute = dosyaCikisExecute
    end
    object ayarlarGenel: TAction
      Category = 'ayarlar'
      Caption = 'Ayarlar'
      OnExecute = ayarlarGenelExecute
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'Cizici|*.ciz|Metin Dosyasi|*.txt|T'#252'm Dosyalar|*.*'
    Left = 268
    Top = 264
  end
  object MainMenu1: TMainMenu
    Left = 296
    Top = 236
    object Dosya1: TMenuItem
      Caption = 'Dosya'
      object Yeni1: TMenuItem
        Action = dosyaYeni
      end
      object A1: TMenuItem
        Action = dosyaAc
      end
      object FarkliKaydet1: TMenuItem
        Action = dosyaFarkliKaydet
      end
      object k1: TMenuItem
        Action = dosyaCikis
      end
    end
    object Dzen1: TMenuItem
      Caption = 'D'#252'zen'
      object duzenGeriAl1: TMenuItem
        Action = duzenGeriAl
      end
    end
    object Grnm1: TMenuItem
      Caption = 'G'#246'r'#252'n'#252'm'
      object Zoom1: TMenuItem
        Action = gorunumZoomIn
      end
      object Zoom2: TMenuItem
        Action = gorunumZoomOut
      end
      object N111: TMenuItem
        Action = gorunumZoom11
      end
      object iz1: TMenuItem
        Action = gorunumCiz
      end
    end
    object Ayarlar1: TMenuItem
      Caption = 'Ayarlar'
      object Ayarlar2: TMenuItem
        Action = ayarlarGenel
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 324
    Top = 236
    object GeriAl1: TMenuItem
      Action = duzenGeriAl
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Zoom3: TMenuItem
      Action = gorunumZoomIn
    end
    object Zoom4: TMenuItem
      Action = gorunumZoomOut
    end
    object N112: TMenuItem
      Action = gorunumZoom11
    end
    object iz2: TMenuItem
      Action = gorunumCiz
    end
  end
  object SaveDialog: TSaveDialog
    Filter = 'Cizici|*.ciz|Metin Dosyasi|*.txt|T'#252'm Dosyalar|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 296
    Top = 264
  end
end
