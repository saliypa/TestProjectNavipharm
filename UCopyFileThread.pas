unit UCopyFileThread;

interface

uses
  System.Classes, System.SysUtils, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TCopyFileThread = class(TThread)
  private
    { Private declarations }
    procedure UpdateControls;
  protected
    procedure Execute; override;
    public
     ProgressBar: TProgressBar;
     MyLabel: TLabel;
  end;

implementation
uses UMainForm, UFunc, UFileCopier, UConst;
{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure TCopyFileThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or 
    
    Synchronize( 
      procedure 
      begin
        Form1.Caption := 'Updated in thread via an anonymous method' 
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ TCopyFileThread }

procedure TCopyFileThread.Execute;
begin
  { Place thread code here }
  starttime:=GetTickCount;
  Copier:= TFileCopier.Create;
  try
  Copier.CallBack := CallBack;
  CopyCount := 0;
  MainForm.ProgressBar1.Position:=0;
  Copier.RewriteFile:=MainForm.CheckBox2.Checked;


  Copier.DoFiles(WorkDirFrom,WorkDirTo, foCount);
  Copier.DoFiles(WorkDirFrom,WorkDirTo, foSize);
  MainForm.Label4.Caption:='־בשטי מבת¸ל האםםûץ ' + Copier.FileSizeToStr(Copier.FileSize)+'. װאיכמג '+inttostr(Copier.FileCount);
  Copier.DoFiles(WorkDirFrom,WorkDirTo, foCopy);

  finally
    UpdateControls;
    Copier.Free;
    endtime:=GetTickCount;
    MainForm.LabelFullSize.Caption :=MainForm.LabelFullSize.Caption + TicketToTime(endtime-starttime);
    MyCopyFileThread.Terminate;
  end;
end;

procedure TCopyFileThread.UpdateControls;
begin
    MainForm.ProgressBar1.Position:=100;
end;

end.
