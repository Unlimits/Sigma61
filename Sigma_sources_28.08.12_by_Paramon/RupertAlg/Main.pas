{*********************************************************************}
{                                                                     }
{                    ���������� ����������� ��������                  }
{                                                                     }
{                               ������� 609                           }
{                                                                     }
{                         ����� ���� ������� 2008                     }
{                                                                     }
{*********************************************************************}
unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ResFunc;
Const
  PluginRegName='RupertGraph';

type
// ������(�����)
     TModule = Record
               Name: String;
           FullPath: String;
            Default: String;
            Current: String;
     end;
// ����� ��� ��������
     TFiles = Record
         RESULT1BIN: String;
         RESULT2BIN: String;
        GRIDDMNODES: String;
       GRIDDMFINOUT: String;
        GRIDDMINOUT: String;
        GRIDDMELEMS: String;
    ProjectFormFile: String;
        NetVariants: String;
     end;
// ������
     TPluginReg = Record
      PluginRegName: String;
      PluginRegPath: String;
           SigmaReg: String;
              Files: TFiles;
        ShowFormReg: TModule;
    SysSettingsRegF: TModule;
       SegmentsRegF: TModule;
            AlgRegF: TModule;
     end;
  TMainForm = class(TForm)
    StatusBar1: TStatusBar;
    ShowCells: TButton;
    algform: TButton;
    bntSysSettings: TButton;
    Statistics: TButton;
    Segments: TButton;
    Exit: TButton;
    CheckPoint: TComboBox;
    WorkPoint: TGroupBox;
    Windows: TGroupBox;
    ActiveWindow: TListBox;
    CalculateProgress: TProgressBar;
    ReCalculate: TButton;
    SaveVariant: TButton;
    Operations: TGroupBox;
    ClearVariant: TButton;
    new_name: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ShowForm(Sender: TObject);
    procedure ShowCellsClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure algformClick(Sender: TObject);
    procedure SegmentsClick(Sender: TObject);
    procedure bntSysSettingsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ActiveWindowClick(Sender: TObject);
    procedure ReCalculateClick(Sender: TObject);
    procedure SaveVariantClick(Sender: TObject);
    procedure SaveDefaulVariant(Sender: TObject);
    procedure CheckPointChange(Sender: TObject);
    procedure ClearVariantClick(Sender: TObject);
  private
    { Private declarations }
  public
    ActiveForm: Array [0..6] of Integer; // 1 - ShowCells, 2 - AlgF, 3 - Segment, 4 -, 5- SysSettings
    procedure RefreshIndexes;
    procedure CheckRegForRupert;
    procedure ErrorOut(Num: Integer);
    { Public declarations }
  end;

var
// ShowCells
  LoadShowForm: Boolean;
  SaveShowForm: Boolean;
  ReLoadRegShowForm: Boolean;
  LegendTieColorBar: Boolean; // ����� checkbox Lenend � ColorBar + �����������
// Segment
  LoadSegmentF: Boolean;
  SaveSegmentF: Boolean;
    ReDrawAuto: Boolean;
  ReLoadResWhenShow:  Boolean;
// Main
         MainR: TMainForm;
     PluginReg: TPluginReg;
implementation

USES Math, MainInterface, Registry, AlgForm, ShowCells, Segment, SysSettings;

{$R *.dfm}

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// ��������� ������� �����
  Upload.CopyToVariant(MainVariant);
// ��������� �������� ����� ��
  IF not ErrorM then UpLoad.WriteVariants;
// ��������� ��� �����
  if AlgF <> nil then  AlgF.Close;
  if SegF <> nil then  SegF.Close;
  if SysSettingF <> nil then  SysSettingF.Close;
  if ShowCellsForm<>nil then ShowCellsForm.Close;
  Action:=caFree;
  MainR:=nil;
  Upload.free;
END;

procedure TMainForm.FormShow(Sender: TObject);
var
  Registry:TRegistry;

  FUNCTION ReadSTRING(Name:STRING;Def:STRING):STRING;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadSTRING(Name) ELSE Result:=def;
  END;

BEGIN
  if not ErrorM then begin
    Registry:=TRegistry.Create;
    Registry.RootKey:=HKEY_CURRENT_USER;
    if FileExists(ChangeFileExt(String(GetProject_FileName), '.res')) then  ShowCells.Enabled:=true
      else ShowCells.Enabled:=false;
//  if (ResultNodes.BlockedNodes.Count>0)and(ResultNodes.UnBlockedNodes.Count>0) then algform.Enabled:=true
//  else algform.Enabled:=false;
    if FileExists(ChangeFileExt(String(GetProject_FileName), '.res')) then Segments.Enabled:=true
      else Segments.Enabled:=false;
  end
  else begin // ����� ���������� - ����� ������ �����
    StatusBar1.Enabled:=False;
    ShowCells.Enabled:=False;
    algform.Enabled:=False;
    bntSysSettings.Enabled:=False;
    Statistics.Enabled:=False;
    Segments.Enabled:=False;
    Exit.Enabled:=True;
    CheckPoint.Enabled:=False;
    WorkPoint.Enabled:=False;
    Windows.Enabled:=False;
    ActiveWindow.Enabled:=False;
    CalculateProgress.Enabled:=False;
    ReCalculate.Enabled:=False;
    SaveVariant.Enabled:=False;
    Operations.Enabled:=False;
    ClearVariant.Enabled:=False;
  end;
end;

procedure TMainForm.ShowForm(Sender: TObject);
BEGIN
  Show;
  CheckState;
  CheckRegForRupert;
end;

procedure TMainForm.CheckRegForRupert;
var
Registry:TRegistry;
Begin
// �������� � ��������
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  IF Registry.KeyExists(PluginReg.SigmaReg) then begin // ���� ����� �����
    IF not(Registry.KeyExists(PluginReg.PluginRegPath)) then begin // ��� ����� ���������
      Registry.CreateKey(PluginReg.PluginRegPath);
      Registry.OpenKey(PluginReg.PluginRegPath,True);
      Registry.WriteInteger('StressMethod',1);
      Registry.CloseKey;
    end
  end
  else begin ErrorOut(1);
  end;
end;

procedure TMainForm.ExitClick(Sender: TObject);
begin
  MainR.Close;
end;

//�������� � �������� (��� ���������� ����� ��������) ����� "����������� �����������"
//��� ������� ������ ����� "����������� �����������"
procedure TMainForm.ShowCellsClick(Sender: TObject);
begin
  if ShowCellsForm=nil then
  begin
    ShowCellsForm:=TShowCellsForm.Create(nil);
    ShowCellsForm.CheckRegForShowCells;
    ShowCellsForm.ShowForm(ChangeFileExt(GetProject_FileName, '.res'));
    IF LoadShowForm = True then ShowCellsForm.LoadForm(PluginReg.ShowFormReg.Current)
      else ShowCellsForm.LoadForm(PluginReg.ShowFormReg.Default);
    ShowCellsForm.BestFitActionClick(nil);
    IF LoadShowForm = False then ShowCellsForm.Start;
    ActiveWindow.Items.Add('����������� �����������');
    ActiveForm[1]:=ActiveWindow.items.IndexOf('����������� �����������')+1;
    ActiveWindow.ItemIndex:=ActiveWindow.items.IndexOf('����������� �����������');
    ActiveWindowClick(Sender);
  end
  else begin
    IF SaveShowForm = True then ShowCellsForm.SaveForm(PluginReg.ShowFormReg.Current);
    //���� ����� ��� �������, �� ������ � ��������.
    ActiveWindow.ItemIndex:=ActiveWindow.items.IndexOf('����������� �����������');
    ActiveWindowClick(Sender);
    ShowCellsForm.FormResize(nil);
  end;
end;

//�������� � �������� (��� ���������� ����� ��������) ����� "���������"
//��� ������� ������ ����� "���������"
procedure TMainForm.algformClick(Sender: TObject);
begin
  if AlgF=nil then
  begin
    AlgF:=TAlgForm.Create(nil);
    AlgF.Show;
    ActiveWindow.Items.Add('���������');
    ActiveForm[2]:=ActiveWindow.items.IndexOf('���������')+1;
    ActiveWindow.ItemIndex:=ActiveWindow.items.IndexOf('���������');
    ActiveWindowClick(Sender);
  end
  else begin
    //���� ����� ��� �������, �� ������ � ��������.
    ActiveWindow.ItemIndex:=ActiveWindow.items.IndexOf('���������');
    ActiveWindowClick(Sender);
  end;
end;

//�������� � �������� (��� ���������� ����� ��������) ����� "����� ��"
//��� ������� ������ ����� "����� ��"
procedure TMainForm.SegmentsClick(Sender: TObject);
begin
  if SegF=nil then
  begin
    SegF:=TSegment.Create(nil);
    SegF.CheckBaseRegKeysForSegments;
    IF LoadSegmentF = True then SegF.LoadForm(PluginReg.SegmentsRegF.Current)
      else SegF.LoadForm(PluginReg.SegmentsRegF.Default);
    SegF.ShowForm;
    ActiveWindow.Items.Add('����� ��');
    ActiveForm[3]:=ActiveWindow.items.IndexOf('����� ��')+1;
    ActiveWindow.ItemIndex:=ActiveWindow.items.IndexOf('����� ��');
    ActiveWindowClick(Sender);
  end
  else begin
    IF SaveSegmentF = True then SegF.SaveForm(PluginReg.SegmentsRegF.Current);
    //���� ����� ��� �������, �� ������ � ��������.
    ActiveWindow.ItemIndex:=ActiveWindow.items.IndexOf('����� ��');
    ActiveWindowClick(Sender);
  end;
end;

//�������� � �������� (��� ���������� ����� ��������) ����� "��������� ���������"
//��� ������� ������ ����� "��������� ���������"
procedure TMainForm.bntSysSettingsClick(Sender: TObject);
begin
  if SysSettingF=nil then
  begin
    SysSettingF:=TSysSettings.Create(nil);
    SysSettingF.Show;
    ActiveWindow.Items.Add('��������� ���������');
    ActiveForm[5]:=ActiveWindow.items.IndexOf('��������� ���������')+1;
    ActiveWindow.ItemIndex:=ActiveWindow.items.IndexOf('��������� ���������');
    ActiveWindowClick(Sender);
  end
  else begin
  //���� ����� ��� �������, �� ������ � ��������.
    ActiveWindow.ItemIndex:=ActiveWindow.items.IndexOf('��������� ���������');
    ActiveWindowClick(Sender);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
Var
  i : integer;
begin
  List.ResNodes.CountOfBlocked:=0;
  List.ResNodes.CountOfUnBlocked:=0;
// ����� �������
  PluginReg.PluginRegName:='RupertGraph';
  PluginReg.SigmaReg:=StringReg+'\';
  PluginReg.PluginRegPath:=PluginReg.SigmaReg+PluginReg.PluginRegName+'\';
  // ShowFormReg
  PluginReg.ShowFormReg.Name:='ShowRes';
  PluginReg.ShowFormReg.FullPath:=PluginReg.PluginRegPath+PluginReg.ShowFormReg.Name+'\';
  PluginReg.ShowFormReg.Default:=PluginReg.ShowFormReg.FullPath+'default\';
  PluginReg.ShowFormReg.Current:=PluginReg.ShowFormReg.FullPath+'current\';
  // SysSettingsRegF
  PluginReg.SysSettingsRegF.Name:='SysSettings';
  PluginReg.SysSettingsRegF.FullPath:=PluginReg.PluginRegPath+PluginReg.SysSettingsRegF.Name+'\';
  PluginReg.SysSettingsRegF.Default:=PluginReg.SysSettingsRegF.FullPath+'default\';
  PluginReg.SysSettingsRegF.Current:=PluginReg.SysSettingsRegF.FullPath+'current\';
  // SegmentsRegF
  PluginReg.SegmentsRegF.Name:='Segments';
  PluginReg.SegmentsRegF.FullPath:=PluginReg.PluginRegPath+PluginReg.SegmentsRegF.Name+'\';
  PluginReg.SegmentsRegF.Default:=PluginReg.SegmentsRegF.FullPath+'default\';
  PluginReg.SegmentsRegF.Current:=PluginReg.SegmentsRegF.FullPath+'current\';
  // AlgRegF
  PluginReg.AlgRegF.Name:='AlgParams';
  PluginReg.AlgRegF.FullPath:=PluginReg.PluginRegPath+PluginReg.AlgRegF.Name+'\';
  PluginReg.AlgRegF.Default:=PluginReg.AlgRegF.FullPath+'default\';
  PluginReg.AlgRegF.Current:=PluginReg.AlgRegF.FullPath+'current\';
// ���� � ������ �����������
  PluginReg.Files.RESULT1BIN:=ChangeFileExt(ExtractFilePath(GetProject_FileName)+'RESULT1','.BIN');
  PluginReg.Files.RESULT2BIN:=ChangeFileExt(ExtractFilePath(GetProject_FileName)+'RESULT2','.BIN');
  PluginReg.Files.GRIDDMNODES:=ChangeFileExt(ExtractFilePath(GetProject_FileName)+'griddm', '.nodes');
  PluginReg.Files.GRIDDMFINOUT:=ChangeFileExt(ExtractFilePath(GetProject_FileName)+'griddm', '.finout');
  PluginReg.Files.GRIDDMINOUT:=ChangeFileExt(ExtractFilePath(GetProject_FileName)+'griddm', '.inout');
  PluginReg.Files.GRIDDMELEMS:=ChangeFileExt(ExtractFilePath(GetProject_FileName)+'griddm', '.elems');
// ������
  PluginReg.Files.ProjectFormFile:=Project_GetFormFile;
  PluginReg.Files.NetVariants:=ChangeFileExt(GetProject_FileName,'.Ralg'); {���� ��������� ����� ��}
// ����������
  Upload:=TResFunc.Create;
  Upload.DoIT;
// �������� ����
  for i:=1 to 6 do ActiveForm[i]:=-1;
// ��������� �����
  Width:=200;
  Height:=500;
  Top  :=95;
  Left :=Screen.Width-200;
  if not ErrorM then begin
    SaveDefaulVariant(Sender);
    UpLoad.ReadVariants;
    IF Rfile then begin
      for i:=2 to Upload.NumofVariants-1 do begin
        CheckPoint.Items.Add(format('������� �%d',[CheckPoint.Items.Count]));
//       CheckPoint.Items.Add(Upload.GetNameOfVariant(i));
      end;
      CheckPoint.ItemIndex:=0;
      MainVariant:=1;
      CountVar:=Upload.NumofVariants-2;
    end;
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
     Width:=200;
     Height:=500;
     Top  :=95;
     Left :=Screen.Width-200;
end;

procedure TMainForm.RefreshIndexes;
begin
  if ActiveForm[1]>0 then ActiveForm[1]:=ActiveWindow.items.IndexOf('����������� �����������')+1;
  if ActiveForm[2]>0 then ActiveForm[2]:=ActiveWindow.items.IndexOf('���������')+1;
  if ActiveForm[3]>0 then ActiveForm[3]:=ActiveWindow.items.IndexOf('����� ��')+1;
  if ActiveForm[4]>0 then ActiveForm[4]:=ActiveWindow.items.IndexOf('')+1;
  if ActiveForm[5]>0 then ActiveForm[5]:=ActiveWindow.items.IndexOf('��������� ���������')+1;
end;

procedure TMainForm.ActiveWindowClick(Sender: TObject);
begin
{  if ActiveForm[1]<>0 then ShowCellsForm.Visible:=False;
  if ActiveForm[2]<>0 then AlgF.Visible:=False;
  if ActiveForm[3]<>0 then SegF.Visible:=False;
  if ActiveForm[4]<>0 then  ;
  if ActiveForm[5]<>0 then SysSettingF.Visible:=False;}

// ������ ���������� ��� �����, � ������ �������
  If ((ActiveForm[1]>0)and((ActiveWindow.ItemIndex+1)=ActiveForm[1]))
    then begin ShowCellsForm.Visible:=True;  ShowCellsForm.FormResize(nil); end
  else if (ActiveForm[1]>0) then  ShowCellsForm.Visible:=False;
  If ((ActiveForm[2]>0)and((ActiveWindow.ItemIndex+1)=ActiveForm[2]))
    then  AlgF.Visible:=True
  else if (ActiveForm[2]>0) then  AlgF.Visible:=False;
  If ((ActiveForm[3]>0)and((ActiveWindow.ItemIndex+1)=ActiveForm[3]))
    then  SegF.Visible:=True
  else if (ActiveForm[3]>0) then  SegF.Visible:=False;
{  If ((ActiveForm[4]>0)and((ActiveWindow.ItemIndex+1)=ActiveForm[4]))
    then  :=True
  else if (ActiveForm[4]>0) then  :=False;}
  If ((ActiveForm[5]>0)and((ActiveWindow.ItemIndex+1)=ActiveForm[5]))
    then  SysSettingF.Visible:=True
  else if (ActiveForm[5]>0) then  SysSettingF.Visible:=False;
end;

procedure TMainForm.ErrorOut(Num: Integer);
Const
err0 = '������ � ������� - ��� �����:';
err1 = '�� ���� ��������:';
begin
  case Num of
  1: begin MessageDlg(err0+(StringReg+'\'),mtError,[mbOk],0); MainR.Close; end;
  2: begin MessageDlg(err1+(ChangeFileExt(ExtractFilePath(GetProject_FileName)+'RESULT1','.BIN'))
                      ,mtError,[mbOk],0); MainR.Close; end;
  3: begin MessageDlg(err1+(ChangeFileExt(ExtractFilePath(GetProject_FileName)+'RESULT1','.BIN'))
                      ,mtError,[mbOk],0); MainR.Close; end;
  end;
end;

// ��������� ������ �������
procedure TMainForm.CheckPointChange(Sender: TObject);
begin
  IF MainVariant <> 1  then begin
    Upload.CopyToVariant(MainVariant);
    Upload.CopyFromVariant(CheckPoint.ItemIndex+1);
  end
  else Upload.CopyFromVariant(CheckPoint.ItemIndex+1);
  MainVariant:=CheckPoint.ItemIndex+1;
end;

// ��������� ��� �������
procedure TMainForm.SaveVariantClick(Sender: TObject);
begin
//  Upload.CopyToVariant(MainVariant);
  Upload.CreateNewVariant;
  Inc(CountVar);
  Upload.CopyToVariant(CheckPoint.Items.Count+1);
  CheckPoint.Items.Add(new_name.text);
//  Upload.SetNameOfVariant(CheckPoint.Items.Count+1,format('������� �%d',[CountVar]));
  CheckPoint.ItemIndex:=CheckPoint.Items.Count-1;
  MainVariant:=CheckPoint.ItemIndex+1;
end;

// ��������� ����������� �������
procedure TMainForm.SaveDefaulVariant(Sender: TObject);
begin
  Upload.CreateNewVariant;
  Upload.CopyToVariant(CheckPoint.Items.Count+1);
  CheckPoint.Items.Add('�������� �����');
  CheckPoint.ItemIndex:=0;
  MainVariant:=CheckPoint.ItemIndex+1;
  CountVar:=CheckPoint.Items.Count-1;
end;

// ������� �������
procedure TMainForm.ClearVariantClick(Sender: TObject);
Var
  i: integer;
begin
  IF CheckPoint.ItemIndex>0 then begin
// ������ ������� �� ��������� �������� ��� ��������� ����� �� ���� ������� (����, �� ������ :(( )
//    ShowMessage(format('ItemIndex=%d;Items.Count=%d;MainVariant=%d', [CheckPoint.ItemIndex,CheckPoint.Items.Count, MainVariant]));
    For i:=CheckPoint.ItemIndex+1 to CheckPoint.Items.Count-1 do begin
      IF i>1 then begin
        Upload.CopyFromVariant(I+1);
        Upload.CopyToVariant(I);
      end;
    end;
    Upload.DeleteVariant;
// ������ ������� � ������ � ��������� �� �������� �����
    CheckPoint.Items.Delete(CheckPoint.ItemIndex);
    CheckPoint.ItemIndex:=0;
    MainVariant:=CheckPoint.ItemIndex+1;
    Upload.CopyFromVariant(CheckPoint.ItemIndex+1);    
  end;
end;

// ��������� ����������� ������� ����� � ��������� ����� Sigma
procedure TMainForm.ReCalculateClick(Sender: TObject);
Var
  idx: integer;
  Procedure incProcess;
  begin CalculateProgress.Position:=CalculateProgress.Position+1;  end;
begin
  Upload.CopyToVariant(MainVariant); {��������� ���������}
  idx:=CheckPoint.ItemIndex; {��������� ����� �������� ��������}

  MainR.Enabled:=False;
// ����� � ���� ����� ���������� ����� ���������������
// ������ ���� �������� � CORD � ��� �� ������������������
// �.�. ������ �������� ����� ������������ ����� �� �����
  CalculateProgress.Max:=16;
  CalculateProgress.Min:=0;
  incProcess;
//�������� ���������
  Upload.Params; incProcess;
//�������� �����
  Upload.UploadNodes;  incProcess;
//�������� ���������
  Upload.UploadElements;  incProcess;
//�������� ������ �����
  Upload.UploadGeTInOuT;  incProcess;
//���������� �������
  CompileNow;  incProcess;
//������ �������
  RunNow;  incProcess;
    Sleep(3000);  incProcess;
//�������� �����������
{ Upload.CreateRes;  incProcess;
  Upload.LoadResult;  incProcess;
  Upload.DestroyRes;  incProcess;
    Sleep(500);  incProcess;
//�������� ����� �������
  Upload.GeTInOuT;  incProcess;
//����������� ����� �����
  Upload.TieInOut;  incProcess;
    Sleep(500);  incProcess;
//�������� ���������� ����� ��������� �����
} Upload.DeleteUpLoadingFiles;  incProcess;
  CalculateProgress.Position:=0;
  MainR.Enabled:=true;

  CheckPoint.ItemIndex:=0;   {�������� �������� �����}
  Upload.CopyToVariant(1);
  MainR.CheckPoint.ItemIndex:=idx;   {������������ � �������� ��������}
  Upload.CopyFromVariant(MainVariant);

end;

end.
