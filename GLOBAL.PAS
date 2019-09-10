unit GLOBAL;

interface


uses Windows;

const
  OKU = False;
  YAZ = True;

var
  Gorunum : Record
    Zoom      :Double;
    Alan      :TRect;
    IzgaraW,
    IzgaraH   :Integer;
    IzgarayaOturt,
    IzgarayiGoster :Boolean;
  end;

procedure Ayarlari(istek :Boolean);

implementation

uses prob;

procedure Ayarlari(istek :Boolean);
  var
    PAyar : TProb;
begin
  PAyar := TProb.Create('ayarlar.ini');

  try
    PAyar.ProbRW(istek, 'genel', 'IzgaraW', gorunum.IzgaraW, 5);
    PAyar.ProbRW(istek, 'genel', 'IzgaraH', gorunum.IzgaraH, 5);
    PAyar.ProbRW(istek, 'genel', 'Izgarayi Goster', Gorunum.IzgarayiGoster, True);
    PAyar.ProbRW(istek, 'genel', 'Izgaraya Oturt', Gorunum.IzgarayaOturt, True);
  finally
    PAyar.Free;
  end;
end;

end.
