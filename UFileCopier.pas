unit UFileCopier;

interface

uses
  Windows, Messages, SysUtils, Classes, controls, stdctrls, strUtils, ComCtrls, ShellApi, Math,IOUtils;

Type
  TFolderOp = (foCopy, foCount, foSize);
  TCopyCallBack = function( TotalFileSize, TotalBytesTransferred, StreamSize, StreamBytesTransferred: int64;
                            StreamNumber, CallbackReason: Dword;
                            SourceFile, DestinationFile: THandle; Data: Pointer): DWord;

  TFileCopier = class(TPersistent)
  private
    fCopyCount: Integer;
    fFileCount: Integer;
    fFileSize: Int64;
    fCallBack: TCopyCallBack;
    fFilesSizeCopyCount: Int64;
    fFileSizeCopy: Int64;
    fFileCopyCount: Integer;
    fPercentFilesTotal:Integer;
    fPercentFileTotal:Integer;
    fFileName:string;
    fStrFilesSizeTotal:string;
    fRewriteFile:boolean;
     function DoFolderFiles(const ASourcePath, ATargetPath: string; const Op: TFolderOp): Int64;
     function DoFolderTree(const ASourcePath, ATargetPath: string; const Op: TFolderOp): Int64;
     procedure SetPercentFilesTotal(const Value: Integer);
     procedure SetPercentFileTotal(const Value: Integer);
     procedure GetPercentFilesTotal;
     procedure GetPercentFileTotal;
     procedure SetStrFilesSizeTotal(const Value: string);
     procedure GetStrFilesSizeTotal;
     procedure SetRewriteFile(const Value: boolean);
  public
     constructor Create; virtual;
     function AddBackSlash(const S: String): string;
     function DoFiles(const ASourcePath, ATargetPath: string; const Op: TFolderOp): Int64;
     function FileSizeToStr(i:Int64):string;
   //  function FileSizeTemp(fileName : wideString) : Int64;
     property CallBack: TCopyCallBack read fCallBack write fCallBack;
     property CopyCount: Integer read fCopyCount;
     property FileCount: Integer read fFileCount;
     property FileSize: Int64 read fFileSize;
     property PercentFilesTotal: Integer read fPercentFilesTotal write SetPercentFilesTotal;
     property PercentFileTotal: Integer read fPercentFileTotal write SetPercentFileTotal;
     property FileCopyCount: Integer read fFileCopyCount;
     property StrFilesSizeTotal: string read fStrFilesSizeTotal write SetStrFilesSizeTotal;
     property FilesSizeCopyCount: Int64 read fFilesSizeCopyCount;
     property FileSizeCopy: Int64 read fFileSizeCopy;
     property FileName: string read fFileName;
     property RewriteFile: boolean read fRewriteFile write SetRewriteFile default False;
  end;

implementation

uses UMainForm,UConst, UFunc;

{ TFileCopier }

function TFileCopier.AddBackSlash(const S: String): string;
begin
  Result := S;
  if S <> '' then
  begin
    If S[length(S)] <> '\' then
      Result := S + '\';
  end
  else
    Result := '\';
end;

function TFileCopier.DoFiles(const ASourcePath, ATargetPath: string;
  const Op: TFolderOp): Int64;
begin
 try
  if fRewriteFile then
   begin
    TDirectory.Delete(ATargetPath,true);
    CreateDir(ATargetPath)
   end;
 finally
   SetRewriteFile(False);
 end;


  case Op of
   foCopy: begin fCopyCount := 0;  fFileCopyCount := 0; fFilesSizeCopyCount:=0 end;
   foCount: fFileCount := 0;
   foSize: fFileSize:= 0;
  end;
  Result := DoFolderTree(ASourcePath, ATargetPath, Op);
end;

constructor TFileCopier.Create;
begin
  inherited;
  CallBack := nil;
end;

function TFileCopier.DoFolderFiles( const ASourcePath, ATargetPath: string;
                                    const Op: TFolderOp): Int64;
var
  StrName,
  MySearchPath,
  MyTargetPath,
  MySourcePath: string;
  FindRec: TSearchRec;
  i: Integer;
  Cancelled: Boolean;
  Attributes: WIN32_FILE_ATTRIBUTE_DATA;
begin
  Result := 0;
  Cancelled := False;
  MyTargetPath := AddBackSlash(ATargetPath);
  MySourcePath := AddBackSlash(ASourcePath);
  MySearchPath := AddBackSlash(ASourcePath) + '*.*';
  i := FindFirst(MySearchPath, 0 , FindRec);
  try
    while (i = 0) and (Result <> -1) do
    begin
      try
      case op of
       foCopy:
       begin
          MainForm.Label5.Caption :='';
          StrName := MySourcePath + FindRec.Name;
          fFileName:=FindRec.Name;
          fFileSizeCopy:=FindRec.Size;
          MainForm.Label5.Caption :=FileSizeToStr(fFileSizeCopy)+' ';
           startfiletime:=GetTickCount;
            if CopyFileEx(PWideChar(StrName), PWideChar(MyTargetPath + FindRec.Name), @fCallBack, nil, @Cancelled, COPY_FILE_FAIL_IF_EXISTS) then
              begin
               endfiletime:=GetTickCount;
               inc(Result);
               inc(fCopyCount);
               inc(fFileCopyCount);
               fFilesSizeCopyCount:=fFilesSizeCopyCount+FindRec.Size;
               GetPercentFilesTotal;
               GetStrFilesSizeTotal;
               MainForm.Label5.Caption := MainForm.Label5.Caption + TicketToTime(endfiletime-startfiletime);
               MyDBSave(fFileName,FileSizeToStr(fFileSizeCopy),TicketToTime(endfiletime-startfiletime));
              end
               else
                Result := -1;
        end;
       foCount:
       begin
         Inc(Result);
         Inc(fFileCount);
       end;
       foSize:
       begin
         Result := Result + FindRec.Size;
         fFileSize := fFileSize + FindRec.Size;
       end;
      end;
      except
        Result := -1;
      end;
      i := FindNext(FindRec);
    end;
  finally
    FindClose(FindRec);
  end;

end;

function TFileCopier.DoFolderTree( const ASourcePath, ATargetPath: string;
                                     const Op: TFolderOp): Int64;
var
  FindRec: TSearchRec;
  StrName, StrExt,
  MySearchPath,
  MyTargetPath,
  MySourcePath: string;
  InterimResult :Int64;
  i: Integer;
begin
  Result := 0;
  MySearchPath := AddBackSlash(ASourcePath) + '*.*';
  MySourcePath := AddBackSlash(ASourcePath);
  MyTargetPath := AddBackSlash(ATargetPath);
  i := FindFirst(MySearchPath, faDirectory , FindRec);
  try
    while (i = 0) and (Result <> -1) do
    begin
      StrName := FindRec.Name;
      if (Bool(FindRec.Attr and faDirectory)) and (StrName <> '.') and (StrName <> '..') then
      begin
        try
          case op of
           foCopy:
             if CreateDir(MyTargetPath + StrName) then
              begin
                InterimResult := DoFolderTree(MySourcePath + StrName, MyTargetPath + StrName, Op);
                if InterimResult <> -1 then
                begin
                  Result := Result + InterimResult;
                  fCopyCount := Result;
                end
                else
                  Result := -1;
              end;
           foCount, foSize:
           begin
             InterimResult := DoFolderTree(MySourcePath + StrName, MyTargetPath + StrName, Op);
             if InterimResult <> -1 then
               Result := Result + InterimResult
             else
               Result := -1;
           end;
          end;
        except
          Result := -1;
        end;
      end;
      i := FindNext(FindRec);
    end;
  finally
    FindClose(FindRec);
  end;
  if Result <> -1 then
  case op of
   foCopy:
    begin
     InterimResult := DoFolderFiles( AddBackSlash(ASourcePath), AddBackSlash(ATargetPath), Op);
     if InterimResult <> -1 then
     begin
       Result := Result + InterimResult;
       fCopyCount := Result;
     end
     else
       Result := InterimResult;
    end;
   foCount:
   begin
     InterimResult := DoFolderFiles(AddBackSlash(ASourcePath), AddBackSlash(ATargetPath), Op);
     if InterimResult <> -1 then
     begin
       Result := Result + InterimResult;
       fFileCount := Result;
     end
     else
       Result := InterimResult;
   end;
   foSize:
   begin
     InterimResult := DoFolderFiles(AddBackSlash(ASourcePath), AddBackSlash(ATargetPath), Op);
     if InterimResult <> -1 then
     begin
       Result := Result + InterimResult;
       fFileSize := Result;
     end
     else
       Result := InterimResult;
   end;
  end;
end;

function TFileCopier.FileSizeToStr(i: Int64): string;
begin
  if i > 1024*1024*1024 then
    Result := IntToStr(i div (1024*1024*1024)) + 'รแ'
  else
  if i > 1024*1024 then
    Result := IntToStr(i div (1024*1024)) + 'Mแ'
  else
  if i > 1024 then
    Result := IntToStr(i div (1024)) + 'Kแ'
  else
    Result := IntToStr(i) + 'แ'
end;

procedure TFileCopier.GetStrFilesSizeTotal;
begin
 SetStrFilesSizeTotal(FileSizeToStr(fFilesSizeCopyCount));
end;

procedure TFileCopier.GetPercentFilesTotal;
begin
 SetPercentFilesTotal(Floor((fFileCopyCount) * 100 / fFileCount));
end;

procedure TFileCopier.GetPercentFileTotal;
begin
 SetPercentFileTotal(Floor((fFileCopyCount) * 100 / fFileCount));
end;

procedure TFileCopier.SetStrFilesSizeTotal(const Value: string);
begin
  if Value <> fStrFilesSizeTotal then
  begin
    fStrFilesSizeTotal := Value;
  end;
end;

procedure TFileCopier.SetPercentFilesTotal(const Value: Integer);
begin
  if Value <> fPercentFilesTotal then
  begin
    fPercentFilesTotal := Value;
  end;
end;

procedure TFileCopier.SetPercentFileTotal(const Value: Integer);
begin
  if Value <> fPercentFileTotal then
  begin
    fPercentFileTotal := Value;
  end;
end;

procedure TFileCopier.SetRewriteFile(const Value: boolean);
begin
  if Value <> fRewriteFile then
  begin
    fRewriteFile := Value;
  end;
end;

end.
