unit ayarlar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, NumEdit;

type
  TfrmAyarlar = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    chkIzgarayiGoster: TCheckBox;
    chkIzgarayaOturt: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    txtLevhaGen: TNumEdit;
    txtLevgaYuk: TNumEdit;
    txtIzgaraGen: TNumEdit;
    txtIzgaraYuk: TNumEdit;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    procedure FormuOkuYaz(Rq:Boolean; T:TObject; var V);
    procedure Formdan(istek: Boolean);
  public
  published
    { Public declarations }
  end;

var
  frmAyarlar: TfrmAyarlar;

implementation

uses global;

{$R *.dfm}

procedure TfrmAyarlar.FormShow(Sender: TObject);
begin
  Formdan(OKU);
end;

procedure TfrmAyarlar.BitBtn1Click(Sender: TObject);
begin
  Formdan(YAZ);

  Ayarlari(YAZ);
  close;
end;

procedure TfrmAyarlar.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmAyarlar.Formdan(istek: Boolean);
begin
  FormuOkuYaz(istek, chkIzgarayiGoster, Gorunum.IzgarayiGoster);
  FormuOkuYaz(istek, chkIzgarayaOturt, Gorunum.IzgarayaOturt);

  FormuOkuYaz(istek, txtIzgaraGen, string(Gorunum.IzgaraW));
  FormuOkuYaz(istek, txtIzgaraYuk, string(Gorunum.IzgaraH));
end;

procedure TfrmAyarlar.FormuOkuYaz(Rq:Boolean; T:TObject; var V);
begin
  if T.ClassType = TCheckBox then
    if Rq then
      Boolean(V) := (T as TCheckBox).Checked
    else
      (T as TCheckBox).Checked := Boolean(V)

  else if T.ClassType = TEdit then
    if Rq then
      String(V) := (T as TEdit).Text
    else
      (T as TEdit).Text := String(V)

  else if T.ClassType = TNumEdit then
    if Rq then
      Integer(V) := Round((T as TNumEdit).Value)
    else
      (T as TNumEdit).Value := Integer(V)
end;

end.
