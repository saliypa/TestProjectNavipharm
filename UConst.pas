unit UConst;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
   ComCtrls, ToolWin, ExtCtrls,UFileCopier,UCopyFileThread;

var
  Copier: TFileCopier;
  MyCopyFileThread: TCopyFileThread;
  WorkDirFrom : string;
  WorkDirTo : string;
  CopyCount :integer;
  CancelCopy:Boolean=False;
  starttime:Cardinal;
  endtime:Cardinal;
  startfiletime:Cardinal;
  endfiletime:Cardinal;

const
    My_Hints:array[0..1] of string=
     ('...',
      'Действительно закончить работу?');


implementation





end.
