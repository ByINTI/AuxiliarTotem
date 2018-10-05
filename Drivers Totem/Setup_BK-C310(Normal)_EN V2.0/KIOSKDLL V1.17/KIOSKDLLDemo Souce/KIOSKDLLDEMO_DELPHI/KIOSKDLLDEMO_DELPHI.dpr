program KIOSKDLLDEMO_DELPHI;

uses
  Forms,
  KIOSKDLLDEMO in 'KIOSKDLLDEMO.pas' {MainForm},
  LoadDLL in 'LoadDLL.pas',
  StatusThread in 'StatusThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
