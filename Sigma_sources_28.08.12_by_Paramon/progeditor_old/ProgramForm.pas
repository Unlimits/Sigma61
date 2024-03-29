{*********************************************************************}
{                                                                     }
{                    ���������� ����������� ��������                  }
{                                                                     }
{                               ������� 609                           }
{                                                                     }
{                    ������� ����� ����������� 2001                   }
{                                                                     }
{*********************************************************************}
Unit ProgramForm;

Interface

Uses
     Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     ComCtrls, StdCtrls, ExtCtrls, Menus, IniFiles, PrnServ, Printers;

type
  TCustomEditHack = class(TCustomEdit);
  procedure CenterLineInEdit(Edit: TCustomEdit; LineNum: Integer);


Type
     TProgramForm1 = Class(TForm)
               PageControl2   : TPageControl;
               Memo1          : TMemo;
               Splitter1      : TSplitter;
               StatusBar1     : TStatusBar;
               MainMenu1      : TMainMenu;
               PopupMenu1     : TPopupMenu;
               MenuUndo       : TMenuItem;
               N1             : TMenuItem;
               MenuCut        : TMenuItem;
               MenuCopy       : TMenuItem;
               MenuPaste      : TMenuItem;
               MenuDelete     : TMenuItem;
               N2             : TMenuItem;
               MenuSelectAll  : TMenuItem;
               MenuFile       : TMenuItem;
               MenuEdit       : TMenuItem;
               MenuView       : TMenuItem;
               MenuSave       : TMenuItem;
               MenuSaveAs     : TMenuItem;
               N3             : TMenuItem;
               MenuExit       : TMenuItem;
               Menu1Undo      : TMenuItem;
               N4             : TMenuItem;
               Menu1Cut       : TMenuItem;
               Menu1Copy      : TMenuItem;
               Menu1Paste     : TMenuItem;
               Menu1Delete    : TMenuItem;
               N5             : TMenuItem;
               Menu1SelectAll : TMenuItem;
               MenuFont       : TMenuItem;
               FontDialog1    : TFontDialog;
               SaveDialog1    : TSaveDialog;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    FindDialog1: TFindDialog;
    CtrlF1: TMenuItem;
    N10: TMenuItem;
               Procedure PageControl2Change(Sender: TObject);
               Procedure MenuUndoClick(Sender: TObject);
               Procedure MenuCutClick(Sender: TObject);
               Procedure MenuCopyClick(Sender: TObject);
               Procedure MenuPasteClick(Sender: TObject);
               Procedure MenuDeleteClick(Sender: TObject);
               Procedure MenuSelectAllClick(Sender: TObject);
               Procedure MenuFontClick(Sender: TObject);
               Procedure MenuSaveClick(Sender: TObject);
               Procedure MenuSaveAsClick(Sender: TObject);
               Procedure FormCreate(Sender: TObject);
               procedure FormDestroy(Sender: TObject);
               procedure FormClose(Sender: TObject; var Action: TCloseAction);
               procedure MenuExitClick(Sender: TObject);
               procedure FindDialog1Find(Sender: TObject);
               procedure GoToLine(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
          private
               { Private declarations }
          public
               { Public declarations }
               Function CanClose:boolean;
               Procedure RichEditSelectionChange(Sender: TObject);
               Procedure AddFile(FileName:String);
               Function FindFile(FileName:String):integer;
               Function FindNotSaved:integer;
               procedure SaveForm(Name:string);
               procedure LoadForm(Name:string);
     End;

Var
     ProgramForm1 : TProgramForm1;
     dop :integer;
procedure ReloadFile(FileName:string);stdcall;
exports
       ReloadFile;
Implementation
Uses RichEdit, MainInterface, UFortranEdit, Registry;

{$R *.DFM}
procedure ReloadFile(FileName:string);stdcall;
begin
end;
procedure TProgramForm1.LoadForm(Name:string);
var
     Registry:TRegistry;
begin
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKeyReadOnly(StringReg+'\'+Name) then
     begin
          WindowState:=wsNormal;
          if Registry.ValueExists('Top') then
               Top:=Registry.ReadInteger('Top');
          if Registry.ValueExists('Left') then
               Left:=Registry.ReadInteger('Left');
          if Registry.ValueExists('Width') then
               Width:=Registry.ReadInteger('Width');
          if Registry.ValueExists('Height') then
               Height:=Registry.ReadInteger('Height');
          if Registry.ValueExists('Maximized') then
          begin
               if Registry.ReadBool('Maximized') then WindowState:=wsMaximized
               else WindowState:=wsNormal;
          end;
     end;
     Registry.free;
end;
procedure TProgramForm1.SaveForm(Name:string);
var
     Registry:TRegistry;
begin
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg+'\'+Name,true) then
     begin
          Registry.WriteBool('Maximized',WindowState=wsMaximized);
          //if WindowState=wsMaximized then WindowState:=wsNormal;
          WindowState:=wsNormal;
          Registry.WriteInteger('Top',Top);
          Registry.WriteInteger('Left',Left);
          Registry.WriteInteger('Width',Width);
          Registry.WriteInteger('Height',Height);
     end;
     Registry.free;
end;
Function TProgramForm1.FindFile;
Var
     i: word;
     res : integer;
Begin
     res:=-1;//�� ������
     If PageControl2.PageCount>0 Then
     Begin
          For i:=0 To PageControl2.PageCount-1 Do
          Begin
               if (PageControl2.Pages[i] is TFortranTab) then
               Begin
                    if (PageControl2.Pages[i] as TFortranTab).FFileName=FileName Then res:=i;
               End;
          End;
     End;
     Result:=res;
End;
Function TProgramForm1.FindNotSaved;
Var
     i   : word;
     res : integer;
Begin
     res:=-1;//�� ������
     If PageControl2.PageCount>0 Then
     Begin
          For i:=0 To PageControl2.PageCount-1 Do
          Begin
               if (PageControl2.Pages[i] is TFortranTab) then
               Begin
                    if (PageControl2.Pages[i] as TFortranTab).RichEdit.Modified Then res:=i;
               End;
          End;
     End;
     Result:=res;
End;
Procedure TProgramForm1.AddFile(FileName:String);
Var
     Page     : integer;
Begin
     Page:=FindFile(FileName);
     If Page<>-1 Then
     Begin
          PageControl2.ActivePage:=PageControl2.Pages[Page];
          RichEditSelectionChange(Nil);
     End
     Else Begin
          If FileExists(FileName) Then
          Begin
               with TFortranTab.Create(PageControl2) do
               begin
                    Load(FileName);
                    RichEdit.Font:=FontDialog1.Font;
                    RichEdit.Modified:=false;
                    RichEdit.PopupMenu:=PopupMenu1;
                    RichEdit.OnSelectionChange:=RichEditSelectionChange;
                    RichEditSelectionChange(Nil);
               End;
          End;
     End;

End;
Procedure TProgramForm1.RichEditSelectionChange(Sender: TObject);
Var
     position : TPoint;
Begin
     If (PageControl2.ActivePage is TFortranTab) Then
     begin
          with (PageControl2.ActivePage as TFortranTab) do
          Begin
               position:=RichEdit.CaretPos;
               StatusBar1.Panels.Items[0].text:=inttostr(position.y+1)+' : '+inttostr(position.x+1)+'  ';
               If RichEdit.Modified Then StatusBar1.Panels.Items[1].text:='Modified'
               Else StatusBar1.Panels.Items[1].text:='';
               MenuCut.Enabled := RichEdit.SelLength > 0;
               MenuCopy.Enabled := MenuCut.Enabled;
               If RichEdit.HandleAllocated Then
               Begin
                    MenuUndo.Enabled := RichEdit.Perform(EM_CANUNDO, 0, 0) <> 0;
                    MenuPaste.Enabled := RichEdit.Perform(EM_CANPASTE, 0, 0) <> 0;
               End;
               if RichEdit.ReadOnly then StatusBar1.Panels.Items[2].text:='Read only'
               Else StatusBar1.Panels.Items[2].text:='';
          end;
          Caption:=(PageControl2.ActivePage as TFortranTab).FFileName;
     end else Caption:='';
End;

Procedure TProgramForm1.PageControl2Change(Sender: TObject);
Begin
     RichEditSelectionChange(Nil);
End;

Procedure TProgramForm1.MenuUndoClick(Sender: TObject);
Begin
     If (PageControl2.ActivePage is TFortranTab) Then
     Begin
          (PageControl2.ActivePage as TFortranTab).RichEdit.Undo;
     End;
End;

Procedure TProgramForm1.MenuCutClick(Sender: TObject);
Begin
     If (PageControl2.ActivePage is TFortranTab) Then
     Begin
          (PageControl2.ActivePage as TFortranTab).RichEdit.CutToClipboard;
     End;
End;

Procedure TProgramForm1.MenuCopyClick(Sender: TObject);
Begin
     If (PageControl2.ActivePage is TFortranTab) Then
     Begin
          (PageControl2.ActivePage as TFortranTab).RichEdit.CopyToClipboard;
     End;
End;

Procedure TProgramForm1.MenuPasteClick(Sender: TObject);
Begin
     If (PageControl2.ActivePage is TFortranTab) Then
     Begin
          (PageControl2.ActivePage as TFortranTab).RichEdit.PasteFromClipboard;
     End;
End;

Procedure TProgramForm1.MenuDeleteClick(Sender: TObject);
Begin
     If (PageControl2.ActivePage is TFortranTab) Then
     Begin
          (PageControl2.ActivePage as TFortranTab).RichEdit.ClearSelection;
     End;
End;

Procedure TProgramForm1.MenuSelectAllClick(Sender: TObject);
Begin
     If (PageControl2.ActivePage is TFortranTab) Then
     Begin
          (PageControl2.ActivePage as TFortranTab).RichEdit.SelectAll;
     End;
End;

Procedure TProgramForm1.MenuFontClick(Sender: TObject);
Var
     i : word;
     modif:boolean;
Begin
     If FontDialog1.Execute Then
     Begin
          If PageControl2.PageCount>0 Then
          Begin
               For i:=0 To PageControl2.PageCount-1 Do
               Begin
                    If (PageControl2.Pages[i] is TFortranTab) Then
                    Begin
                         Modif:=(PageControl2.Pages[i] as TFortranTab).RichEdit.Modified;
                         (PageControl2.Pages[i] as TFortranTab).RichEdit.Font:=FontDialog1.Font;
                         (PageControl2.Pages[i] as TFortranTab).RichEdit.Modified:=Modif;
                    End;
               End;
          End;
     End;
End;
Function TProgramForm1.CanClose:boolean;
Var
     i        : word;
     Cancel   : boolean;
     FileName : String;
     Dialog   : word;
Begin
     Cancel:=false;
     If PageControl2.PageCount>0 Then
     Begin
          i:=0;
          Repeat
               If (PageControl2.Pages[i] is TFortranTab) Then
               Begin
                    If (PageControl2.Pages[i] as TFortranTab).RichEdit.Modified Then
                    Begin
                         FileName:=(PageControl2.Pages[i] as TFortranTab).FFileName;
                         Dialog:=MessageDlg('��������� '+ExtractFileName(FileName)+' ?', mtConfirmation,mbYesNoCancel, 0);
                         If Dialog=mrYes Then
                         Begin
                              (PageControl2.Pages[i] as TFortranTab).RichEdit.Lines.SaveToFile(FileName);
                         End
                         Else Begin
                              If Dialog=mrNo Then
                              Begin
                                   //not save
                              End
                              Else Cancel:=true;
                         End;
                    End;
               End;
               inc(i);
          Until (i>PageControl2.PageCount-1) Or Cancel;
          If Cancel Then Result:=false
          Else Result:=true;
     End
     Else Result:=true;
end;
procedure TProgramForm1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     if not CanClose then Action := caNone
     else begin
          Action := caFree;
          ProgramForm1:=nil;
     end;
end;
//������� ����� ���������� �����
Function ChangeExtension(FileName,ext:String):String;
Var
     name : String;
     i    : Integer;
Begin
     name:=ExtractFileName(FileName);
     i:=pos(ExtractFileExt(FileName),name);
     If i>0 Then SetLength(name,i-1);
     Result:=name+ext;
End;

Procedure TProgramForm1.MenuSaveClick(Sender: TObject);
var
     Bak:string;
     Registry:TRegistry;
     CreateBakReg:boolean;
Begin
     CreateBakReg:=false;
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKeyReadOnly(StringReg+'\'+Name) then
     begin
          if Registry.ValueExists('CreateBakReg') then
               CreateBakReg:=Registry.ReadBool('CreateBakReg');

     end;
     Registry.free;
     If (PageControl2.ActivePage is TFortranTab) Then
     Begin
          with (PageControl2.ActivePage as TFortranTab) do
          begin
               if FileExists(FFileName) and CreateBakReg then
               begin
                    Bak:=ChangeExtension(FFileName,'.bak');
                    if FileExists(Bak) then DeleteFile(Bak);
                    RenameFile(FFileName,Bak);
               end;
               RichEdit.Lines.SaveToFile(FFileName);
               RichEdit.Modified:=False;
               RichEditSelectionChange(nil);
               CheckState;
          end;
     End;
End;

Procedure TProgramForm1.MenuSaveAsClick(Sender: TObject);
Begin
     If (PageControl2.ActivePage is TFortranTab) Then
     Begin
          with (PageControl2.ActivePage as TFortranTab) do
          begin

               SaveDialog1.FileName:=FFileName;
               try
               If SaveDialog1.Execute Then
                    RichEdit.Lines.SaveToFile(SaveDialog1.FileName);
               finally
               end;
          end;
     End;
End;
Procedure TProgramForm1.FormCreate(Sender: TObject);
Var
     i,Count : word;
     p:PChar;
     filename,s : string;
Begin
     LoadForm('ProgramForm');
     Count:=Project_Fortran_Count;
     If Count>0 Then
     Begin
          For i:=1 To Count Do
          Begin
               p:=Project_Fortran_Get(i);
               filename:=String(p);
               s:=String(Project_PackFileName(p));
               If s[1]<>'*' Then
               Begin
                    AddFile(filename);
               End;
          End;
     End;
     if Memo1.Lines.Count>0 then
     begin
          Memo1.Show;
          Splitter1.Show;
     end else
     begin
          Memo1.Hide;
          Splitter1.Hide;
     end;
End;

procedure TProgramForm1.FormDestroy(Sender: TObject);
begin
     SaveForm('ProgramForm');
     ProgramForm1:=nil;
end;


procedure TProgramForm1.MenuExitClick(Sender: TObject);
begin
     close;
end;
function GetDOSFileName(FileName:string):string;
var
     buf:array[1..255] of char;
     count:word;
     s:string;
begin
     count:=GetShortPathName(PChar(FileName),@buf, SizeOf(buf));
     s:=Buf;
     SetLength(s,count);
     Result:=s;
end;

procedure TProgramForm1.Memo1Click(Sender: TObject);
var
     filename,s,x:string;
     i,p,z:integer;
begin
     s:=Memo1.Lines.Strings[Memo1.CaretPos.y];
     s:=LowerCase(s);
     p:=pos('.for',s);
     if p<>0 then
     begin
          filename:=copy(S,1,p+3);
          i:=0;
          while i<PageControl2.PageCount do
          begin
               If (PageControl2.Pages[i] is TFortranTab) Then
               Begin
                    x:=GetDOSFileName((PageControl2.Pages[i] as TFortranTab).FFileName);
                    if FileName=LowerCase(x) then
                    begin
                         PageControl2.ActivePageIndex:=i;
                         p:=pos('(',s);
                         i:=pos(')',s);
                         x:=copy(S,p+1,i-p-1);
                         val(x,p,i);
                         if i=0 then
                         begin
                              p:=p-1;
                              with (PageControl2.ActivePage as TFortranTab).RichEdit do
                              begin
                                   i:=0;
                                   z:=0;
                                   while (i<Lines.Count) and (i<p) do
                                   begin
                                        z:=z+Length(Lines.Strings[i])+2;
                                        inc(i);
                                   end;
                                   SetFocus;
                                   SelStart:=z;
                              end;
                         end;
                         i:=PageControl2.PageCount;
                    end;
               End;
               inc(i);
          End;
     end;
end;

procedure TProgramForm1.FormResize(Sender: TObject);
var
cfF: TIniFile;
SigmaLocation: string;
i: integer;
begin
     //����������� ����� ������������ �����
     SigmaLocation   :=LowerCase(ExtractFilePath(ParamStr(0)));
     i:=pos('\bin',SigmaLocation);
     if i>0 then SetLength(SigmaLocation,i);
     cfF:=TIniFile.Create(SigmaLocation+'bin\sforms.ini');

     dop:=0;
     top:=0;

//      cfF:=TIniFile.Create('sforms.ini');
      try
                dop:=CfF.ReadInteger('�������','������',top);
                top:=dop-StatusBar1.Height-8;
                left:=0;
                Height:=Screen.Height-dop;
                cfF.Free;
      except
                MessageDlg('�� ���� ��������� ���� sforms.ini!',mtError,[mbOk],0);
      end;
     Constraints.MaxHeight:=Screen.Height-dop;
     top:=dop-StatusBar1.Height-8;
end;

procedure TProgramForm1.N6Click(Sender: TObject);
var
        ttt:TPrintService;
begin
        ttt.PrinterSetupDialog;
end;

procedure TProgramForm1.N7Click(Sender: TObject);
var
        PText: TextFile;
begin
    If (PageControl2.ActivePage is TFortranTab) Then
     begin
          with (PageControl2.ActivePage as TFortranTab) do
          Begin
                richEdit.Print('bound.for');
          end;
     end;
end;

/////////////////////

procedure TProgramForm1.N10Click(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, ToEnd: Integer;
  mySearchTypes : TSearchTypes;
  myFindOptions : TFindOptions;
begin
  mySearchTypes := [];
  with (PageControl2.ActivePage as TFortranTab).richEdit do
  begin
    FindDialog1.Position :=
    Point(300, 300);
     FindDialog1.Execute;
  end;
end;


procedure CenterLineInEdit(Edit: TCustomEdit; LineNum: Integer);
var
  VisibleLines: Integer;
  TopLine: Integer;
  FirstLine: Integer;
begin
  FirstLine := Edit.Perform(EM_GETFIRSTVISIBLELINE, 0, 0);
  VisibleLines := Round(Edit.ClientHeight / Abs(TCustomEditHack(Edit).Font.Height));

  if VisibleLines <= 1 then
    TopLine := LineNum
  else
  if (LineNum - Round((VisibleLines/2)) + 1 > 0) then
   TopLine := LineNum - Round((VisibleLines/2)) + 1
  else
   TopLine := 0;


  if FirstLine <> TopLine then
    Edit.Perform(EM_LINESCROLL, 0, TopLine - FirstLine);
end;


procedure TProgramForm1.FindDialog1Find(Sender: TObject);
var s : string;
var k,i,z,t : Integer;
var
  VisibleLines: Integer;
  TopLine: Integer;
  FirstLine: Integer;
var
FTPos:Integer; // ���������� ��� ������� �������
IText,FText:String; // �������� �����, ������� �����
begin
 i:=0;
 t:=0;
 with (PageControl2.ActivePage as TFortranTab).RichEdit do
  begin

    SetFocus; // ������������� ����� ����� �� ���� ����� �� ������ �� ������
    if not (frMatchCase in FindDialog1.Options) then
     FText:=AnsiLowerCase(FindDialog1.FindText) else // ���� � ������� ���� ��� ����� ��������
     FText:=FindDialog1.FindText; // ���� � ������� ���� c ����� ��������
     if frDown in FindDialog1.Options then
      begin // ����� ����
       IText:=copy(Text,SelStart+SelLength+1,Length(Text)); // ������ �������� ����� ����� ������� ������� �������
       if not (frMatchCase in FindDialog1.Options) then IText:=AnsiLowerCase(IText); // ���� � ������� ���� ��� ����� ��������
       FTPos:=pos(FText,IText); // ���������� ��� �����
       if FTPos=0 then
       begin
       MessageDlg('����� �� ������!',mtError,[mbOk],0);
       Exit; // ���� ������ �� ����� �� ������� �� ���������
       end;
       FTPos:=FTPos+SelStart+SelLength; // ������ �������� �� ������� ��������� �������
       SetFocus;
       Perform( EM_SCROLLCARET, 0, 0 );
       SelStart:=FTPos-1;
       SelLength:=Length(FText); // �������� �����
       i:=0;
       z:=0;
       while (i<Lines.Count) and (z<FTPos) do
        begin
        z:=z+Length(Lines.Strings[i])+2;
        inc(i);
       end;
     end
     else  // ����� �����
      begin
       IText:=copy(Text,0,SelStart); // ������ �������� ����� �� ������� ������� �������
       if not (frMatchCase in FindDialog1.Options) then IText:=AnsiLowerCase(IText); // ���� � ������� ���� ��� ����� ��������
       for FTPos:=length(IText)-length(FText) downto 1 do // ���������� ����� � ����� �� ������
        if copy(IText,FTPos,length(FText))=FText then // ���� �������� ������ ������ � ������� ��
          begin
            t :=1;
            SetFocus;
            Perform( EM_SCROLLCARET, 0, 0 );
            SelStart:=FTPos-1;
            SelLength:=Length(FText); // �������� �����
            Perform( EM_SCROLLCARET, 0, 0 );
            i:=0;
            z:=0;
            while (i<Lines.Count) and (z<FTPos) do
             begin
             z:=z+Length(Lines.Strings[i])+2;
             inc(i);
            end;
            break;
          end;
      end;

     end;
      if i <> 0 then
       CenterLineInEdit((PageControl2.ActivePage as TFortranTab).RichEdit,i)
     else
        MessageDlg('����� �� ������!',mtError,[mbOk],0);

  end;

//////////////////////



procedure TProgramForm1.GoToLine(Sender: TObject);
var s,FText : string;
var k,i,z,len : Integer;
var
  VisibleLines: Integer;
  TopLine: Integer;
  FirstLine: Integer;
begin
 len:= 0;
 with (PageControl2.ActivePage as TFortranTab) do
  begin
    len:= RichEdit.lines.count;
    s:= Inputbox('������� ����� ������','����� ������','0');
    k := StrToInt(s);
    If len < k then k:= len;
    begin
     i:=0;
     z:=0;
     while (i<RichEdit.Lines.Count) and (i<k) do
     begin
       z:=z+Length(RichEdit.Lines.Strings[i])+2;
       inc(i);
     end;
     SetFocus;
     RichEdit.SelStart:=z;
    end;
    CenterLineInEdit( RichEdit, k);

  end;
end;

End.



