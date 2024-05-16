program Project2;

{$R *.dres}

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {mainForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'MTPC - Control Parental';
  TStyleManager.TrySetStyle('Auric');
  Application.CreateForm(TmainForm, mainForm);
  Application.Run;
end.
