program Napominalka;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uAbout in 'uAbout.pas' {frmAbout},
  uSettings in 'uSettings.pas' {frmSettings};

{$R *.res}

begin
  Application.Initialize;
  //Application.ShowMainForm:= False;
  Application.Title := 'Напоминалка';
  Application.CreateForm(TfrmMain, frmMain);
  //Application.CreateForm(TfrmSettings, frmSettings);
  //Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
