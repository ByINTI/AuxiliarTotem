program POSdllDemoProj;

uses
  Forms,
  PosDllDemo in 'PosDllDemo.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
