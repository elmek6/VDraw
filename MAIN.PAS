unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, ActnMan, ExtCtrls, StdCtrls, Buttons, ComCtrls,
  ToolWin, ColorGrd, ActnCtrls, ActnMenus;

type
  TfrmMain = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    sbMain: TStatusBar;
    ActionManager1: TActionManager;
    dosyaAc: TAction;
    gorunumZoomIn: TAction;
    gorunumZoomOut: TAction;
    gorunumZoom11: TAction;
    OpenDialog: TOpenDialog;
    MainMenu1: TMainMenu;
    Dosya1: TMenuItem;
    A1: TMenuItem;
    Dzen1: TMenuItem;
    Grnm1: TMenuItem;
    Zoom1: TMenuItem;
    Zoom2: TMenuItem;
    N111: TMenuItem;
    Ayarlar1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Zoom3: TMenuItem;
    Zoom4: TMenuItem;
    N112: TMenuItem;
    SaveDialog: TSaveDialog;
    dosyaFarkliKaydet: TAction;
    FarkliKaydet1: TMenuItem;
    duzenGeriAl: TAction;
    duzenGeriAl1: TMenuItem;
    gorunumCiz: TAction;
    iz1: TMenuItem;
    dosyaCikis: TAction;
    k1: TMenuItem;
    iz2: TMenuItem;
    ToolButton1: TToolButton;
    dosyaCizdir: TAction;
    dosyaYeni: TAction;
    Yeni1: TMenuItem;
    N1: TMenuItem;
    GeriAl1: TMenuItem;
    ayarlarGenel: TAction;
    Ayarlar2: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    procedure dosyaAcExecute(Sender: TObject);
    procedure gorunumZoomExecute(Sender: TObject);
    procedure dosyaFarkliKaydetExecute(Sender: TObject);
    procedure gorunumCizExecute(Sender: TObject);
    procedure dosyaCikisExecute(Sender: TObject);
    procedure dosyaCizdirExecute(Sender: TObject);
    procedure dosyaYeniExecute(Sender: TObject);
    procedure duzenGeriAlExecute(Sender: TObject);
    procedure ayarlarGenelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SatiriYorumla;
    procedure IzgaraCiz;
  published
    { Public declarations }
  end;

Const
  SBM_ZOOM     =0;
  SBM_FILENAME =1;

var
  frmMain: TfrmMain;

  Satir : Record
    PCount    :Integer;
    P         :array[0..6] of Integer;
    PCmd      :Char;
    PSatir    :String;
  end;

implementation

uses Paper, global, sablon, ayarlar, inilang, toolbox;

{$R *.dfm}

procedure TfrmMain.dosyaAcExecute(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    frmPaper.memo1.Lines.LoadFromFile(OpenDialog.FileName);
    frmPaper.Caption := OpenDialog.FileName;
  end;
end;

procedure TfrmMain.SatiriYorumla;
  var
    c,
    i     :Integer;
    s     :char;
    rakamlar :string;
begin
  c := 0;
  rakamlar := '';
  Satir.P[0] := 0;
  Satir.P[1] := 0;
  Satir.P[2] := 0;
  Satir.P[3] := 0;
  Satir.P[4] := 0;
  Satir.P[5] := 0;
  Satir.P[6] := 0;

  if Satir.PSatir='' then { Enter }
    exit;

  Satir.PCmd := Satir.PSatir[1];
  for i:=1 to Length(Satir.PSatir) do begin
    s:=Satir.PSatir[i];
    if s='/' then begin
      inc(c);
      rakamlar := '';
    end else if(s<>' ')and(s in ['0'..'9']) then begin
        rakamlar := rakamlar + s;
        Satir.P[c] := strtoint(rakamlar);
    end;
  end;
end;

procedure TfrmMain.gorunumZoomExecute(Sender: TObject);
begin
  if sender=gorunumZoomIn then
    Gorunum.Zoom := Gorunum.Zoom + Gorunum.Zoom
  else if sender=gorunumZoomOut then
    Gorunum.Zoom := Gorunum.Zoom / 2
  else if sender=gorunumZoom11 then
    Gorunum.Zoom := 1;

  gorunumZoom11.Checked := Gorunum.Zoom=1;
  frmPaper.imgMain.Stretch := Gorunum.Zoom<>1;
  sbMain.Panels.Items[SBM_ZOOM].Text := format('Zoom : %f', [Gorunum.Zoom]);

  frmPaper.imgMain.Width := trunc(Gorunum.Alan.Right * Gorunum.Zoom);
  frmPaper.imgMain.Height := trunc(Gorunum.Alan.Bottom * Gorunum.Zoom);
end;

procedure TfrmMain.dosyaFarkliKaydetExecute(Sender: TObject);
begin
  if SaveDialog.Execute then begin
    frmPaper.Memo1.Lines.SaveToFile(SaveDialog.FileName);
    frmPaper.Caption := SaveDialog.FileName;
  end;
end;

procedure TfrmMain.gorunumCizExecute(Sender: TObject);
  var
    i     :Integer;
begin
  for i:=0 to frmPaper.memo1.Lines.Count-1 do begin
    Satir.PSatir := UpperCase(frmPaper.memo1.Lines.Strings[i]);
    SatiriYorumla;
    case Satir.PCmd of
      '@': { Remark }
        ;
      'E': { Erase }
        begin
//        imgMain.Picture.Metafile.Clear;
//        imgMain.Picture.Bitmap.TransparentColor := cl;
          frmPaper.imgMain.Picture.Bitmap := nil;
        end;
      'B': { Background picture }
        begin
//          frmPaper.imgMain.Picture.LoadFromFile(PSatir);
        end;
      'S': { Size }
        begin
          Gorunum.Alan.TopLeft.X := 0;
          Gorunum.Alan.TopLeft.Y := 0;
          Gorunum.Alan.BottomRight.X := Satir.P[1];
          Gorunum.Alan.BottomRight.Y := Satir.P[2];

          frmPaper.imgMain.Width := Gorunum.Alan.Right;
          frmPaper.imgMain.Height := Gorunum.Alan.Bottom;
        end;
      'L': { Line }
        begin
          with frmPaper.imgMain.Canvas do begin
            Pen.Color := Satir.P[5];
            MoveTo (Satir.P[1], Satir.P[2]);
            LineTo(Satir.P[3], Satir.P[4]);
          end;
        end;
      'P': { Point }
        begin
          frmPaper.ImgMain.Canvas.Pixels[Satir.P[1],Satir.P[2]] := Satir.P[3];
        end;
    end;
  end;

  IzgaraCiz;

end;

procedure TfrmMain.dosyaCikisExecute(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.dosyaCizdirExecute(Sender: TObject);
begin
{
  Kalemi bos
  Motor X = 0 konumuna al
  Motor Y = 0 konumuna al

  t = (|X2-X1|+|Y2-Y1|) / 1;
  k = ((X2-X1)+(Y2-Y1)) / 2;
  step = 
}
end;

procedure TfrmMain.dosyaYeniExecute(Sender: TObject);
begin
  frmSablon.ShowModal;
end;

procedure TfrmMain.IzgaraCiz;
  var
    x, y    :Integer;
begin
  if Gorunum.IzgarayiGoster then
    for x := 0 to gorunum.Alan.Right do
    begin
      for y := 0 to gorunum.Alan.Bottom do
      begin
        with frmPaper.imgMain.Canvas do
        begin
          if x mod gorunum.IzgaraW = 0 then
            if y mod gorunum.IzgaraH = 0 then
              Pixels[x,y] := clGreen;
        end;
      end;
    end;
end;

procedure TfrmMain.duzenGeriAlExecute(Sender: TObject);
begin
  with frmPaper do
    memo1.Lines.Delete(memo1.Lines.Count-1);

  gorunumCiz.Execute;
end;

procedure TfrmMain.ayarlarGenelExecute(Sender: TObject);
begin
  frmAyarlar.ShowModal;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Ayarlari(OKU);

  Gorunum.Zoom := 1;

end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    inilang.CL := LoadIni('Custom.ini');
    FillProps([frmMain, frmAyarlar, frmPaper, frmSablon, frmToolBox], IniLang.CL);
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
