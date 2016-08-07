unit UFunc;

interface

uses Forms,UMainForm,
     UConst,Classes,StdCtrls,SysUtils,Controls,Dialogs,ComCtrls, Messages, ShlObj, Winapi.Windows,

     IOUtils,Types,UFileCopier;



 function MyGreatFormModal(var Form; MyFormClass: TFormClass):boolean;

 function CallBack( TotalFileSize, TotalBytesTransferred, StreamSize, StreamBytesTransferred: int64;
                          StreamNumber, CallbackReason: Dword;
                          SourceFile, DestinationFile: THandle;
                          Data: Pointer): DWord;

 function BrowseFolder(title: PChar; h: hwnd): String;

 function TicketToTime(Tm:Cardinal):string;
 procedure MyDBSave(AName:string; ASize:string; ATime:String);



implementation


function MyGreatFormModal(var Form; MyFormClass: TFormClass):boolean;
begin
 try
  Result:=True;
  if Not Assigned(TForm(Form)) then
                                   Application.CreateForm(MyFormClass, Form);
  TForm(Form).ShowModal;
  TForm(Form).Free;
 except
  Result:=False;
 end;
end;

function TicketToTime(Tm:Cardinal):string;
var
 H,M,S,Ms:integer;
  //Tm:Cardinal;
begin
 //Tm:=GetTickCount;
 try
  H:=Trunc(Tm/3600000);
  Tm:=Tm-H*3600000;
  M:=Trunc(Tm/60000);
  Tm:=Tm-M*60000;
  S:=Trunc(Tm/1000);
  Tm:=Tm-S*1000;
  Ms:=Tm;
 finally
 end;
  Result:={IntToStr(H)+}'Общее время '+IntToStr(M)+' мин. '+IntToStr(S)+' с.';
end;


function CallBack( TotalFileSize, TotalBytesTransferred, StreamSize, StreamBytesTransferred: int64;
                          StreamNumber, CallbackReason: Dword;
                          SourceFile, DestinationFile: THandle;
                          Data: Pointer): DWord;
begin
  if CancelCopy = True then
  begin
    result := PROGRESS_CANCEL;
    exit;
  end;

  MainForm.ProgressBar1.Position:=Copier.PercentFilesTotal;
  MainForm.LabelFullSize.Caption:='Завершено '+(Copier.StrFilesSizeTotal)+'. Файлов ' + IntToStr(Copier.CopyCount);

  MainForm.Label3.Caption := 'Текущий файл ' + Copier.FileName;

  MainForm.ProgressBar2.Position:=(Round((TotalBytesTransferred*100)/Copier.FileSizeCopy));

  Result := PROGRESS_CONTINUE;

  application.ProcessMessages;
end;

function BrowseFolder(title: PChar; h: hwnd): String;
var
  lpItemID: PItemIDList;
  path: array[0..Max_path] of char;
  BrowseInfo: TBrowseInfo;
begin
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  SHGetSpecialFolderLocation(h,csidl_desktop,BrowseInfo.pidlRoot);

  with BrowseInfo do
    begin
    hwndOwner := h;
    lpszTitle := title;
    ulFlags := BIF_RETURNONLYFSDIRS+BIF_EDITBOX+BIF_STATUSTEXT;
  end;

  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then
    begin
    SHGetPathFromIDList(lpItemID, Path);
    result:=path;
    GlobalFreePtr(lpItemID);
  end;

end;

procedure MyDBSave(AName:string; ASize:string; ATime:String);
begin
 try
  MainForm.FDTable1.Insert;
  MainForm.FDTable1FILE_NAME.Value:=AName;
  MainForm.FDTable1FILE_SIZE.Value:=ASize;
  MainForm.FDTable1FILE_TIME.Value:=ATime;
  MainForm.FDTable1.Post;
 finally
 end;
end;

end.

