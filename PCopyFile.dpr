program PCopyFile;

uses
  Vcl.Forms,
  UMainForm in 'UMainForm.pas' {MainForm},
  UFunc in 'UFunc.pas',
  UConst in 'UConst.pas',
  UFileCopier in 'UFileCopier.pas',
  UCopyFileThread in 'UCopyFileThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
