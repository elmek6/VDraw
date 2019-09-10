program cizici;

uses
  Forms,
  main in 'main.pas' {frmMain},
  ayarlar in 'ayarlar.pas' {frmAyarlar},
  toolbox in 'toolbox.pas' {frmToolBox},
  paper in 'paper.pas' {frmPaper},
  global in 'global.pas',
  sablon in 'sablon.pas' {frmSablon},
  prob in 'prob.pas',
  inilang in 'inilang.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAyarlar, frmAyarlar);
  Application.CreateForm(TfrmToolBox, frmToolBox);
  Application.CreateForm(TfrmPaper, frmPaper);
  Application.CreateForm(TfrmSablon, frmSablon);
  Application.Run;
end.
