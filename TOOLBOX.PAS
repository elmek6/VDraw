unit toolbox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ColorGrd;

type
  TfrmToolBox = class(TForm)
    cgMain: TColorGrid;
    SpeedButton1: TSpeedButton;
    cmdLine: TSpeedButton;
    cmdPoint: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure cgMainClick(Sender: TObject);
    procedure cmdShapeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmToolBox: TfrmToolBox;

implementation

uses paper;

{$R *.dfm}

procedure TfrmToolBox.cgMainClick(Sender: TObject);
begin
  frmPaper.imgMain.Canvas.Pen.Color := cgMain.ForegroundColor
end;

procedure TfrmToolBox.cmdShapeClick(Sender: TObject);
begin
  if sender=cmdLine then
    frmPaper.DrawingTool := dtLine
  else if sender=cmdPoint then
    frmPaper.DrawingTool := dtPoint
end;

end.
