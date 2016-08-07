unit UMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  UCopyFileThread, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, Vcl.DBCtrls;



type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel6: TPanel;
    Edit2: TEdit;
    CheckBox2: TCheckBox;
    Label6: TLabel;
    Edit1: TEdit;
    Label7: TLabel;
    FDConnection1: TFDConnection;
    Panel5: TPanel;
    Panel3: TPanel;
    TrackBar1: TTrackBar;
    CheckBox1: TCheckBox;
    Panel4: TPanel;
    LabelFullSize: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    ProgressBar1: TProgressBar;
    BitBtn3: TBitBtn;
    ProgressBar2: TProgressBar;
    BitBtn1: TBitBtn;
    Panel7: TPanel;
    Panel8: TPanel;
    FDTable1: TFDTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDTable1FILE_NAME: TStringField;
    FDTable1FILE_SIZE: TStringField;
    FDTable1FILE_TIME: TStringField;
    FDTable1FILE_ID: TSmallintField;
    Label2: TLabel;
    EditDB: TEdit;
    Label8: TLabel;
    EditUser: TEdit;
    Label9: TLabel;
    EditPas: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EditDBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses UFunc, UFileCopier, UConst;

{$R *.dfm}

procedure TMainForm.BitBtn1Click(Sender: TObject);
begin
 CancelCopy := True;
end;

procedure TMainForm.BitBtn3Click(Sender: TObject);
begin
  //***********
  FDConnection1.Params.Database:=EditDB.Text;
  FDConnection1.Params.UserName:=EditUser.Text;
  FDConnection1.Params.Password:=EditPas.Text;
  FDConnection1.Connected := True;
  FDTable1.Active:=True;
  //***********


 CancelCopy:=False;
 if Not(DirectoryExists(WorkDirFrom)) then
   begin
    ShowMessage(WorkDirFrom+' не существует');
    exit;
   end;

  try
   CreateDir(WorkDirTo);
  finally
  end;

 if Not(DirectoryExists(WorkDirTo)) then
   begin
    ShowMessage(WorkDirTo+' не существует');
    exit;
   end;

  MyCopyFileThread := TCopyFileThread.Create(True);
  MyCopyFileThread.Priority := tpIdle;
  MyCopyFileThread.Resume;

end;

procedure TMainForm.CheckBox1Click(Sender: TObject);
var
  Suspended: Boolean;
begin
 Suspended := (Sender as TCheckBox).Checked;
 MyCopyFileThread.Suspended := Suspended;
end;

procedure TMainForm.Edit1Click(Sender: TObject);
begin
 WorkDirFrom:=BrowseFolder('Укажите каталог',Application.Handle);
 MainForm.Edit1.Text:=WorkDirFrom+'\';
end;

procedure TMainForm.Edit2Click(Sender: TObject);
begin
 WorkDirTo:=BrowseFolder('Укажите каталог',Application.Handle);
 MainForm.Edit2.Text:=WorkDirTo+'\';
end;

procedure TMainForm.EditDBClick(Sender: TObject);
begin
 WorkDirFrom:=BrowseFolder('Укажите каталог',Application.Handle);
 MainForm.Edit1.Text:=WorkDirFrom+'\MYTEMPDB.FDB';
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if MessageDlg(UConst.My_Hints[1], mtConfirmation, [mbOK,mbCancel], 0) = mrCancel then
    begin
     Action:=caNone;
     exit;
    end;

   Application.Handle := 0;

  if Assigned(MyCopyFileThread) then MyCopyFileThread.Terminate;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 WorkDirFrom:=ExtractFilePath(Application.ExeName);
 WorkDirTo:=ExtractFilePath(Application.ExeName)+'Temp\';
 try
  CreateDir(WorkDirTo);
 finally
 end;

 MainForm.Edit1.Text:=WorkDirFrom;
 MainForm.Edit2.Text:=WorkDirTo;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  MainForm.Width:=530;
  MainForm.Height:=500;
  MainForm.Top:=(Screen.Height div 2)-(MainForm.Height div 2);
  MainForm.Left:=(Screen.Width div 2)-(MainForm.Width div 2);

  MainForm.Caption:='Демонстрация копирования для (Навифарм)';
end;

procedure TMainForm.TrackBar1Change(Sender: TObject);
var
  Priority: TThreadPriority;
begin
  case (Sender as TTrackBar).Position of
    3 : Priority := tpIdle;
    2 : Priority := tpLower;
    1 : Priority := tpNormal;
    0 : Priority := tpHigher;
  end;

 MyCopyFileThread.Priority := Priority;
end;

end.
