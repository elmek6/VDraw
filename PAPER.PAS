unit paper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Menus;

type
  TDrawingTool = (dtLine, dtPoint);
  TfrmPaper = class(TForm)
    SpeedButton1: TSpeedButton;
    Memo1: TMemo;
    ScrollBox1: TScrollBox;
    imgMain: TImage;
    CheckBox1: TCheckBox;
    procedure imgMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Origin, MovePt :TPoint;
    Drawing        :Boolean;
    DrawingTool    :TDrawingTool;
    procedure DrawShape(TopLeft, BottomRight: TPoint; AMode: TPenMode);
    procedure IzgarayaYerlestir(var X, Y: Integer);
  end;

var
  frmPaper: TfrmPaper;

implementation

uses global, main;

{$R *.dfm}

procedure TfrmPaper.DrawShape(TopLeft, BottomRight: TPoint;
  AMode: TPenMode);
begin
  with imgMain.Canvas do begin
    Pen.Mode := AMode;
    case DrawingTool of
      dtLine:
        begin
          imgMain.Canvas.MoveTo(TopLeft.X, TopLeft.Y);
          imgMain.Canvas.LineTo(BottomRight.X, BottomRight.Y);
        end;
      dtPoint:
        imgMain.Canvas.Pixels[TopLeft.X, TopLeft.Y] := imgMain.Canvas.Pen.Color;
{
      dtRectangle: Image.Canvas.Rectangle(TopLeft.X, TopLeft.Y, BottomRight.X,
        BottomRight.Y);
      dtEllipse: Image.Canvas.Ellipse(Topleft.X, TopLeft.Y, BottomRight.X,
        BottomRight.Y);
      dtRoundRect: Image.Canvas.RoundRect(TopLeft.X, TopLeft.Y, BottomRight.X,
        BottomRight.Y, (TopLeft.X - BottomRight.X) div 2,
        (TopLeft.Y - BottomRight.Y) div 2);}
    end;
  end;
end;

procedure TfrmPaper.imgMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button<>mbLeft then
    exit;

  IzgarayaYerlestir(X, Y);
  Drawing := True;
  imgMain.Canvas.MoveTo(X, Y);
  Origin := Point(X, Y);
  MovePt := Origin;
//  StatusBar1.Panels[0].Text := Format('Origin: (%d, %d)', [X, Y]);
end;

procedure TfrmPaper.imgMainMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Drawing then
  begin
    IzgarayaYerlestir(X, Y);
{
012345678012345678012345678012345678012345678012345678
}
    DrawShape(Origin, MovePt, pmNotXor);
    MovePt := Point(X, Y);
    DrawShape(Origin, MovePt, pmNotXor);
  end;
//  StatusBar1.Panels[1].Text := Format('Current: (%d, %d)', [X, Y]);
end;

procedure TfrmPaper.imgMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Drawing then
  begin
    IzgarayaYerlestir(X, Y);
    DrawShape(Origin, Point(X, Y), pmCopy);
    Drawing := False;

    case DrawingTool of
      dtLine:  memo1.Lines.Add(format('L /%d/%d/%d/%d/%d', [Origin.X,Origin.Y,X,Y,imgMain.Canvas.Pen.Color]));
      dtPoint: memo1.Lines.Add(format('P /%d/%d/%d', [Origin.X,Origin.Y,imgMain.Canvas.Pen.Color]));
      end;
  end;
end;

procedure TfrmPaper.CheckBox1Click(Sender: TObject);
begin
  DoubleBuffered := CheckBox1.Checked;
end;

procedure TfrmPaper.IzgarayaYerlestir(var X, Y: Integer);
begin
  if Gorunum.Zoom<>1 then begin
    X := Round(X / (Gorunum.Zoom));
    Y := Round(Y / (Gorunum.Zoom));
  end;

  if Gorunum.IzgarayaOturt then begin
    X := Gorunum.IzgaraW * Round(X / Gorunum.IzgaraW);
    Y := Gorunum.IzgaraH * Round(Y / Gorunum.IzgaraH);
  end;
end;

end.
