{*********************************************************************}
{                                                                     }
{                    ���������� ����������� ��������                  }
{                                                                     }
{                               ������� 609                           }
{                                                                     }
{                    ������� ����� ����������� 2001                   }
{                                                                     }
{                               ���������:                           }
{                                                                     }
{                 ����������� ������ ������������� 2003               }
{                                                                     }
{                     ������� ����� ���������� 2004                   }
{                                                                     }
{*********************************************************************}

UNIT ShowMovings;

INTERFACE

USES
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, ResultsArrays, ImgList, ToolWin, Menus,
  Grids, Buttons, printers, ExtDlgs, TSigmaForm, Spin;

CONST
  IniFileName='Sigma32.ini';
  HandAct = 1;
  HandPas = 2;
  ZoomIn = 3;
  Zoomout = 4;
  ZoomArea = 5;
  CM_Inch=2.5428571428571428571428571428571;
  cursorcrosdx=3;
  CountMaterial = 3;

TYPE
  TStress = Array [1..CountMaterial] of real;
  ZoneStruct = Record
               ZoneNum    : word;      // ����� ����
               NodesNum   : Array [0..7] of word;      // ������ �����
               NodesCoord : Array [0..1,0..7] of real;      // ���������� �����
     End;
     TZoneInfo = Array [0..20] Of ZoneStruct;
  TStressArray = ARRAY [1..7] OF MyReal;
  ElStressArray = ARRAY [1..3] OF MyReal;
  TShowMovingsForm = Class(TForm)
    ScrollBox1     : TScrollBox;
    Splitter1      : TSplitter;
    StatusBar1     : TStatusBar;
    LegendPanel    : TPanel;
    Splitter2      : TSplitter;
    Legend         : TPaintBox;
    Panel2         : TPanel;
    ControlBar1    : TControlBar;
    ToolBar1       : TToolBar;
    DefaultAction  : TToolButton;
    ImageList1     : TImageList;
    PaintBox1      : TPaintBox;
    MoveAction     : TToolButton;
    ZoomInAction   : TToolButton;
    ZoomOutAction  : TToolButton;
    ZoomAreaAction : TToolButton;
    BestFitAction  : TToolButton;
    Panel4         : TPanel;
    ColorMinus     : TPanel;
    ColorPlus      : TPanel;
    ColorDialog1   : TColorDialog;
    ColorZero      : TPanel;
    CheckColor     : TPopupMenu;
    PlusM          : TMenuItem;
    MinusM         : TMenuItem;
    ZeroM          : TMenuItem;
    BkgrM          : TMenuItem;
    ForceM         : TMenuItem;
    SavePicDlg     : TSavePictureDialog;
    Panel8         : TPanel;
    SpeedButton2   : TSpeedButton;
    SpeedButton3   : TSpeedButton;
    SpeedButton4   : TSpeedButton;
    GroupBox7: TGroupBox;
    StringGrid1: TStringGrid;
    GroupBox5: TGroupBox;
    Label9: TLabel;
    EditForce: TEdit;
    ForceTrackBar: TTrackBar;
    StressType: TRadioGroup;
    GroupBox8: TGroupBox;
    Panel9: TPanel;
    StressMethod1: TRadioButton;
    StressMethod2: TRadioButton;
    StressMethod3: TRadioButton;
    GroupBox9: TGroupBox;
    Label17: TLabel;
    Label16: TLabel;
    InfoMoveX: TEdit;
    InfoMoveY: TEdit;
    GroupBox4: TGroupBox;
    Mover: TTrackBar;
    Panel5: TPanel;
    Label8: TLabel;
    EditMover: TEdit;
    Group4: TGroupBox;
    UseBuffer: TCheckBox;
    UseLegend: TCheckBox;
    UseForce: TCheckBox;
    UseBound: TCheckBox;
    UseNumNode: TCheckBox;
    UseNumZone: TCheckBox;
    UseAxes: TCheckBox;
    GroupBox3: TGroupBox;
    LevelNumber: TLabel;
    ChangeLegend: TTrackBar;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    EditScale: TEdit;
    Panel1: TPanel;
    InfoX: TEdit;
    InfoY: TEdit;
    InfoXY: TEdit;
    InfoMax: TEdit;
    InfoMin: TEdit;
    InfoConer: TEdit;
    InfoEcv: TEdit;
    Edit1: TEdit;
    Panel6: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    EditX: TEdit;
    EditY: TEdit;
    Panel7: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Timer1: TTimer;
    TestElements: TCheckBox;
    LabelScale: TLabel;
    UseLines: TCheckBox;
    InfoFiniteElementNumber: TEdit;
    Label13: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox1: TGroupBox;
    KENumber: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    MUprug: TEdit;
    Label18: TLabel;
    KoefPuas: TEdit;
    Label19: TLabel;
    DopNapr: TEdit;
    Label20: TLabel;
    thickness: TEdit;
    Label21: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Panel10: TPanel;
    SpeedButton1: TSpeedButton;
    Panel11: TPanel;
    GroupBox6: TGroupBox;
    Label24: TLabel;
    Label26: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    SpeedButton5: TSpeedButton;
    EditMoveX: TEdit;
    EditMoveY: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label25: TLabel;
    UseNumMater: TCheckBox;
    Spin_0_max: TSpinEdit;
    ColorPlus_0: TPanel;
    ColorMinus_0: TPanel;
    Spin_0_min: TSpinEdit;
    CheckBox1: TCheckBox;
    pl: TLabel;
    mi: TLabel;
    Edit7: TEdit;
    Label29: TLabel;
    CheckBox2: TCheckBox;
    ZoneCheckBox: TCheckBox;
    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE FormDestroy(Sender: TObject);
    PROCEDURE FormResize(Sender: TObject);
    PROCEDURE PaintBox1Paint(Sender: TObject);
    PROCEDURE UseLegendClick(Sender: TObject);
    //�������� ����� ������
    PROCEDURE UseLinesClick(Sender: TObject);
    PROCEDURE RePaintPlate(Sender: TObject);
    PROCEDURE EditScaleChange(Sender: TObject);
    PROCEDURE TrackBar1Change(Sender: TObject);
    PROCEDURE ChangeLegendChange(Sender: TObject);
    PROCEDURE StressTypeClick(Sender: TObject);
    PROCEDURE LegendPaint(Sender: TObject);
    PROCEDURE PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: INTEGER);
    PROCEDURE MoverChange(Sender: TObject);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE ChangeActionClick(Sender: TObject);
    PROCEDURE PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
    PROCEDURE PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
    PROCEDURE BestFitActionClick(Sender: TObject);
    PROCEDURE ChangeColorClick(Sender: TObject);
    //����� ������ ����� � ������
    //PROCEDURE ChangeColorPlus(Sender: TObject);
    //PROCEDURE ChangeColorMinus(Sender: TObject);

    PROCEDURE EditMoverChange(Sender: TObject);
    PROCEDURE EditForceChange(Sender: TObject);
    PROCEDURE PlusMClick(Sender: TObject);
    PROCEDURE MinusMClick(Sender: TObject);
    PROCEDURE ZeroMClick(Sender: TObject);
    PROCEDURE BkgrMClick(Sender: TObject);
    PROCEDURE ForceMClick(Sender: TObject);
    PROCEDURE UpDown1ChangingEx(Sender: TObject; VAR AllowChange: BOOLEAN; NewValue: Smallint; Direction: TUpDownDirection);
    PROCEDURE EditXChange(Sender: TObject);
    PROCEDURE ForceTrackBarChange(Sender: TObject);
    PROCEDURE UseAxesClick(Sender: TObject);
    PROCEDURE GroupBox6DblClick(Sender: TObject);
    PROCEDURE SpeedButton2Click(Sender: TObject);
    PROCEDURE SpeedButton3Click(Sender: TObject);
    PROCEDURE SpeedButton4Click(Sender: TObject);
    procedure StressMethod1Click(Sender: TObject);
    procedure StressMethod2Click(Sender: TObject);
    procedure StressMethod3Click(Sender: TObject);
    Procedure StressMethodSave(Method: Integer);
    Function  StressMethodLoad(Method: Integer):Integer;
    procedure FormShow(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure EditMoveXChange(Sender: TObject);
    procedure Spin_0_Exit(Sender: TObject);
    procedure UseNumZoneClick(Sender: TObject);
    procedure UseNumMaterClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ZoneCheckBoxClick(Sender: TObject);

  PUBLIC
   DrawSelectedPoint: Boolean;
    dx, dy           : MyReal;
    x, y             : MyReal;
    Updating         : BOOLEAN;
    ActiveToolButton : TToolButton;
    ActiveRadio      : TRadioButton;
    MousePushed      : BOOLEAN;
    Force, BackGR    : TColor;

    Error    : WORD;
    PROCEDURE LoadResults(Path:STRING);
    PROCEDURE ChangeDrawSize;
    PROCEDURE Scaling;
    PROCEDURE SetDiapazon;
    PROCEDURE SetScale;
    PROCEDURE MainRePaint;
    PROCEDURE LegendRePaint;
    PROCEDURE ShowElements(Canvas:TCanvas);
    PROCEDURE ShowAxes(Canvas:TCanvas);
    PROCEDURE ShowSelectedPoint(Canvas:TCanvas);
    PROCEDURE ShowElement(Canvas:TCanvas;OneElement:TOneElement);
    PROCEDURE ShowElement1(Canvas:TCanvas;OneElement:TOneElement);
    PROCEDURE ShowElement2(Canvas:TCanvas;OneElement:TOneElement);
    PROCEDURE ShowElementOld(Canvas:TCanvas;OneElement:TOneElement);
    PROCEDURE ShowMaterialColoredElement(Canvas:TCanvas;OneElement:TOneElement);
    FUNCTION StressInElement(OneElement : TOneElement;VAR stress: ElStressArray):BOOLEAN;
    PROCEDURE ShowArrow(Canvas:TCanvas;x,y,long:INTEGER;Alfa:MyReal);
    PROCEDURE ShowBoundForce(Canvas:TCanvas);
    PROCEDURE ShowText(Canvas:TCanvas;x,y:INTEGER;S:STRING);
    PROCEDURE ChengeLegendLevel;
    FUNCTION GenerateColor(Value:word):TColor;
    FUNCTION GenerateColor1(Value:word):TColor;
    FUNCTION GenerateColorOld(Value:word):TColor;
    PROCEDURE ShowForm(ResFile:STRING);
    PROCEDURE SaveForm(Name:STRING);
    PROCEDURE LoadForm(Name:STRING);
    PROCEDURE ZoomAreaRect(x1,y1,x2,y2:MyReal);
    FUNCTION SolveInPoint : Boolean;
    FUNCTION StressInPoint(X,Y:MyReal;VAR st:TStressArray):BOOLEAN;
    FUNCTION StressInPointType(X,Y:MyReal;VAR st:TStressArray; Typ:Integer):BOOLEAN;
    PROCEDURE PaintBox1Click;
    function  MoveInPoint(X,Y:MyReal;var move_st:TStressArray):boolean;
    PROCEDURE UseTestElements(Canvas:TCanvas);    //  ��������� �������� �� ���������� ����������� ���������� � ��
    FUNCTION  HLStoRGB(H,L,S : INTEGER):TColor;
    PROCEDURE RGBtoHLS(Color:TColor;Var H,L,S:INTEGER);
    //��������� ������ ������� ���, �� ������� ���������� ���� ������� ��������
    procedure PaintZonesContour(Canvas:TCanvas);
  END;

VAR
  ShowMovingsForm : TShowMovingsForm;
  bmpPic : TBitMap;
     ZoneInfo     : TZoneInfo;
     ZoneCount    : integer;
     PrevDim      : integer;

IMPLEMENTATION
USES Math, MainInterface, Strfunc, IniFiles, Registry, PrnServ;

CONST
  paintdx = 10;
  paintdy = 10;
  Error_Text : array [1..10] of string=
     ('����������� ������', '�� ����������� ���������� ���������', '�� ��������� ��������� �������',
'�� ��������� �������� ����������� ���', '�� ������������ ������ ����� ����� �������������', '�� ��������� ����������� �����', '����������� ������',
'����������� ������', '����������� ������', '����������� ������');

VAR
  DownX,DownY             : INTEGER;
  CenterX,CenterY         : INTEGER;
  PaintWidth, PaintHeight : INTEGER;
  OffsetX,OffsetY         : MyReal;
  SOffsetX,SOffsetY       : MyReal;
  FigureX,FigureY         : MyReal;
  Scale                   : MyReal;
  MouseX, MouseY          : MyReal;
  Level                   : MyReal;
  Level_plus              : MyReal;  //��� ������� � +
  Level_minus             : MyReal;  //��� ������� � -
  Level_zero              : INTEGER;  //������� � 0
  NegativeLevels          : WORD;
  CM                      : MyReal;
  MoverK                  : MyReal;
  ForceK                  : MyReal;
  OnlyUpdate              : BOOLEAN;
  FloatFormat             : STRING;
  StressMethod            : INTEGER;
  //���������� ����� ������
  LinesShow               : BOOLEAN;
  //�������
  DataPath                : STRING;
  Prd                     : INTEGER;
  DopStress               : Real;
  //�����
  //CPlus,CMinus    : TColor;
  //LinesCPlus,LinesCMinus : TColor;
{$R *.DFM}

{************��������� ������ �� 2 ������ ����� ',' ***********}
{FUNCTION CutStr(x:STRING):STRING;
VAR
 i,j : INTEGER;
 y   : STRING;

BEGIN
  y:='';
  FOR i:=1 TO Length(x) DO BEGIN
    IF x[i]=',' THEN BEGIN
      j:=i+2;
      y:=copy(x,1,j);
      BREAK;
    END;
  END;
  Result:=y;
END;}


FUNCTION MyFloatToStr(X:MyReal):STRING;
BEGIN
  Result:=FormatFloat(FloatFormat,X);
{  ShowMessage(FloatFormat);}
END;


FUNCTION MyDiv(x,y:MyReal):MyReal;
BEGIN
  IF ABS(y)<0.1E-4900 THEN Result:=0.1E-4900
  ELSE Result:=x/y;
END;


FUNCTION Xreal2Xpaint(x:MyReal):INTEGER;
VAR
  xx : MyReal;

BEGIN
  xx:=(OffsetX+(x-FigureX))*Scale*CM;
  IF xx>32000 THEN xx:=32000;
  Result:=CenterX+ROUND(xx);
END;


FUNCTION Yreal2Ypaint(y:MyReal):INTEGER;
VAR
  yy : MyReal;

BEGIN
  yy:=(OffsetY+(y-FigureY))*Scale*CM;
  IF yy>32000 THEN yy:=32000;
  Result:=CenterY-ROUND(yy);
END;


FUNCTION Xpaint2Xreal(x:INTEGER):MyReal;
BEGIN
  IF ABS(Scale)<0.1E-15 THEN Scale:=0.1E-15;
  Result:=MyDiv((x-CenterX),Scale*CM)-OffsetX+FigureX;
END;


FUNCTION Yp2Yr(y:INTEGER):MyReal;
BEGIN
  IF ABS(Scale)<0.1E-15 THEN Scale:=0.1E-15;
  Result:=MyDiv((y-CenterY),Scale*CM)-OffsetY+FigureY;
END;


FUNCTION Ypaint2Yreal(y:INTEGER):MyReal;
BEGIN
  Result:=Yp2Yr(PaintHeight-y);
END;


// Load Save form
PROCEDURE TShowMovingsForm.LoadForm(Name:STRING);
VAR
  Registry:TRegistry;

  FUNCTION ReadSTRING(Name:STRING;Def:STRING):STRING;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadSTRING(Name) ELSE Result:=def;
  END;

  FUNCTION ReadInteger(Name:STRING;Def:INTEGER):INTEGER;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadInteger(Name) ELSE Result:=def;
  END;

  FUNCTION ReadFloat(Name:STRING;Def:MyReal):MyReal;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadFloat(Name) ELSE Result:=def;
  END;

  FUNCTION ReadBool(Name:STRING;Def:BOOLEAN):BOOLEAN;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadBool(Name) ELSE Result:=def;
  END;

BEGIN
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  IF Registry.OpenKeyReadOnly(STRINGReg+'\'+Name) THEN BEGIN
    WindowState:=wsNormal;
    Top:=ReadInteger('Top',Top);
    Left:=ReadInteger('Left',Left);
    Width:=ReadInteger('Width',Width);
    Height:=ReadInteger('Height',Height);
    IF ReadBool('Maximized',FALSE) THEN WindowState:=wsMaximized ELSE WindowState:=wsNormal;
    ColorZero.color:=StringToColor(ReadSTRING('ColorZero','clWhite'));
    ColorPlus.Color:=StringToColor(ReadSTRING('ColorPlus','clRed'));
    ColorMinus.Color:=StringToColor(ReadSTRING('ColorMinus','clGreen'));
    ColorPlus_0.Color:=StringToColor(ReadSTRING('ColorPlus_0','clRed'));
    ColorMinus_0.Color:=StringToColor(ReadSTRING('ColorMinus_0','clGreen'));
    Spin_0_max.Value:=ReadInteger('Spin_0_max',500);
    Spin_0_min.Value:=ReadInteger('Spin_0_min',-500);
    //
    //LinesCPlus:=StringToColor(ReadSTRING('LinesColorPlus','clRed'));
    //LinesCMinus:=StringToColor(ReadSTRING('LinesColorMinus','clGreen'));
    UseLines.Checked:=ReadBool('UseLines',FALSE);

    Force:=StringToColor(ReadSTRING('Force','clBlue'));
    BackGR:=StringToColor(ReadSTRING('BackGROUND','clWhite'));
    EditForce.Text:=IntToStr(ReadInteger('ForceK',5));
    ForceTrackBar.Position:=ReadInteger('ForcePos',ROUND(ForceTrackBar.Max/2));
    EditMover.Text:=FloatToStr(ReadFloat('MoverK',10));
    UseLegend.Checked:=ReadBool('UseLegend',TRUE);
    UseForce.Checked:=ReadBool('UseForce',FALSE);
    UseBound.Checked:=ReadBool('UseBound',FALSE);
    UseNumNode.Checked:=ReadBool('UseNumNode',FALSE);
    UseNumZone.Checked:=ReadBool('UseNumZone',FALSE);
    UseBuffer.Checked:=ReadBool('UseBuffer',FALSE);
  END;
  IF Registry.OpenKeyReadOnly(STRINGReg) THEN FloatFormat:=Registry.ReadSTRING('FloatFormat');
  LegendPanel.Color:=BackGR;
  Panel2.Color:=BackGR;
  Registry.Free;
  //
  //if UseLines.Checked = false then
  //begin
  //  ColorPlus.Color:=CPlus;
  //  ColorMinus.Color:=CMinus;
  //end;
END;

function LoadDopStress( var Error:Integer): TStress;
VAR
//  i         : INTEGER;
//  s         : string;
//  F         : Text;
//  DopStress : Real;
  MP        : TMainParams;
  MPM       : TMainParamsMaterial;
BEGIN

Form_Load(Project_GetFormFile);

MP:=GetMainParam;
MPM:=GetMainParamMaterial;

Error:=0;
Result[1]:=MP.SB;
Result[2]:=MPM.ORT10;
Result[3]:=MPM.ORT17;

end;

PROCEDURE TShowMovingsForm.SaveForm(Name:STRING);
VAR
  Registry:TRegistry;

BEGIN
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  IF Registry.OpenKey(STRINGReg+'\'+Name,TRUE) THEN BEGIN
    Registry.WriteBool('Maximized',WindowState=wsMaximized);
    IF WindowState=wsMaximized THEN WindowState:=wsNormal;
    Registry.WriteInteger('Top',Top);
    Registry.WriteInteger('Left',Left);
    Registry.WriteInteger('Width',Width);
    Registry.WriteInteger('Height',Height);
    Registry.WriteString('ColorZero',ColorToSTRING(ColorZero.color));
    Registry.WriteString('ColorPlus',ColorToSTRING(ColorPlus.Color));
    Registry.WriteString('ColorMinus',ColorToSTRING(ColorMinus.Color));
    Registry.WriteString('ColorPlus_0',ColorToSTRING(ColorPlus_0.Color));
    Registry.WriteString('ColorMinus_0',ColorToSTRING(ColorMinus_0.Color));
    Registry.WriteInteger('Spin_0_max',Spin_0_max.Value);
    Registry.WriteInteger('Spin_0_min',Spin_0_min.Value);
    //
    //Registry.WriteString('LinesColorPlus',ColorToSTRING(LinesCPlus));
    //Registry.WriteString('LinesColorMinus',ColorToSTRING(LinesCMinus));
    Registry.WriteBool('UseLines',UseLines.Checked);

    Registry.WriteString('Force',ColorToSTRING(Force));
    Registry.WriteString('BackGROUND',ColorToSTRING(BackGR));
    Registry.WriteFloat('MoverK',MoverK);
    Registry.WriteInteger('ForceK',strtoint(EditForce.Text));
    Registry.WriteInteger('ForcePos',ForceTrackBar.Position);
    Registry.WriteBool('UseLegend',UseLegend.Checked);
    Registry.WriteBool('UseForce',UseForce.Checked);
    Registry.WriteBool('UseBound',UseBound.Checked);
    Registry.WriteBool('UseNumNode',UseNumNode.Checked);
    Registry.WriteBool('UseNumZone',UseNumZone.Checked);
    Registry.WriteBool('UseBuffer',UseBuffer.Checked);
  END;
//  IF Registry.OpenKey(STRINGReg,TRUE) THEN Registry.WriteString('FloatFormat',FloatFormat);
  Registry.free;
END;


// Actions
PROCEDURE TShowMovingsForm.Scaling;
BEGIN
  IF Scale=0 THEN Scale:=0.1E-17;
  IF Scale>=1 THEN LabelScale.Caption:=MyFloatToStr(Scale)+' : 1'
  ELSE LabelScale.Caption:='1 : '+MyFloatToStr(1/Scale);
  ChangeDrawSize;
END;


PROCEDURE TShowMovingsForm.SetDiapazon;
VAR
  value : INTEGER;

BEGIN
  value:=1;
  IF CheckInt(EditScale.text,value) THEN BEGIN
    IF (Value<2) THEN BEGIN
      EditScale.text:='2';
      Value:=2;
    END;
    TrackBar1.Max:=(value-1)*2;
    SetScale;
  END;
END;


PROCEDURE TShowMovingsForm.SetScale;
VAR
  Half  : INTEGER;
  Value : MyReal;

BEGIN
  Half:=ROUND(TrackBar1.Max/2);
  IF Scale>=1 THEN Value:=Scale ELSE Value:=MyDiv(1,Scale);
  IF Half<Value THEN BEGIN
    Half:=ROUND(Value);
    TrackBar1.Max:=2*Half;
    EditScale.text:=inttostr(Half);
  END;
  IF Scale>=1 THEN TrackBar1.Position:=ROUND(Half+Value-1)
  ELSE TrackBar1.Position:=ROUND(Half-Value+1);
  Scaling;
END;


PROCEDURE TShowMovingsForm.ChangeDrawSize;
BEGIN
  Nodes_Result.UpDateWithMove(Mover.Position*MoverK);
END;


PROCEDURE TShowMovingsForm.MainRePaint;
BEGIN
  IF OnlyUpdate THEN exit;
  IF UseBuffer.Checked THEN PaintBox1Paint(Nil) ELSE PaintBox1.Repaint;
END;


PROCEDURE TShowMovingsForm.LegendRePaint;
BEGIN
  IF UseBuffer.Checked THEN LegendPaint(Nil) ELSE Legend.Repaint;
END;

// �������� �.�."����������� �����������"
procedure TShowMovingsForm.CheckBox2Click(Sender: TObject);
begin
if CheckBox2.checked = true then
    begin
      UseNumMater.Checked:=false;
      UseLines.Checked:=false;
      CheckBox1.Checked:=false;
      TestElements.Checked:=false;
      Checkbox2.Checked:=true;
      Colorminus.Caption:='1';
      Colorzero.Caption:='2';
      Colorplus.Caption:='3';
      mi.Visible := false;
      pl.Visible := false;
      Spin_0_max.Visible := false;
      Spin_0_min.Visible := false;
      ColorMinus_0.Visible := false;
      ColorPlus_0.Visible := false;


    end
else
    begin
    Colorzero.Caption:='0';
    Colorminus.Caption:='-';
    Colorplus.Caption:='+';
    end;
    MainRepaint;

end;

//������ "����", �������� �.�., 2011�.
procedure TShowMovingsForm.ZoneCheckBoxClick(Sender: TObject);
begin
  MainRepaint;

end;

procedure TShowMovingsForm.PaintZonesContour(Canvas:TCanvas);
var
    inrg          : Shortint;
    i,j           : Shortint;
    x1,x2,y1,y2   : Integer;
    ZonePoints    : Array[1..16] of Double;
    tempStyle     : TPenStyle;
    tempWidth     : Integer;
    tempColor     : TColor;
    tempMode      : TPenMode;
begin
    inrg := ZoneContour.GetNumberOfZones();
    //�������� ���������
    if ZoneCheckBox.checked = true then begin
    //�������� ���������� �������� �����
      tempStyle:=Canvas.Pen.Style;
      tempWidth:=Canvas.Pen.Width;
      tempColor:=Canvas.Pen.Color;
      tempMode:=Canvas.Pen.Mode;
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Width := 3;
      Canvas.Pen.Color := clBlack;
      Canvas.Pen.Mode := pmCopy;
      if inrg >= 0 then begin
        for i := 1 to inrg do begin
          ZoneContour.GetZonePoints(i,ZonePoints);
          for j := 1 to 7 do begin
            x1:=Xreal2Xpaint(ZonePoints[2*j-1]);
            y1:=Yreal2Ypaint(ZonePoints[2*j]);
            x2:=Xreal2Xpaint(ZonePoints[2*j+1]);
            y2:=Yreal2Ypaint(ZonePoints[2*j+2]);
        //�������� �� ���� ������
            Canvas.MoveTo(x1,y1); Canvas.LineTo(x2,y2);
          end;
          x1:=x2;
          y1:=y2;
          x2:=Xreal2Xpaint(ZonePoints[1]);
          y2:=Yreal2Ypaint(ZonePoints[2]);
          Canvas.MoveTo(x1,y1); Canvas.LineTo(x2,y2);
        end;
      end;
      //�������� ���������
      Canvas.Pen.Style := tempStyle;
      Canvas.Pen.Width := tempWidth;
      Canvas.Pen.Color := tempColor;
      Canvas.Pen.Mode := tempMode;
    end;
end;
//����� "����"

PROCEDURE TShowMovingsForm.ChengeLegendLevel;
var
  st: string;
  z : integer;
BEGIN
  z := ChangeLegend.Position;
  if (UseLines.Checked = true) and (CheckBox1.Checked = true) then z := 4;
  level:=(Elements_Result.max[StressType.ItemIndex+1]-Elements_Result.min[StressType.ItemIndex+1])/z;

  level_zero := trunc(z/2);
  level_plus := abs(Elements_Result.max[StressType.ItemIndex+1]/level_zero);
  level_minus := abs(Elements_Result.min[StressType.ItemIndex+1]/level_zero);
  //showmessage(inttostr(level_zero));
  if Elements_Result.min[StressType.ItemIndex+1]>=0 then
  begin
        level_zero := 0;
        if (CheckBox1.Checked = true) then level_zero := 2;
        level_plus := abs(Elements_Result.max[StressType.ItemIndex+1]/z-1);
        level_minus := 1;
  end;
  if Elements_Result.max[StressType.ItemIndex+1]<=0 then
  begin
        level_zero := z;
        if (CheckBox1.Checked = true) then level_zero := 2;
        level_plus := 1;
        level_minus := abs(Elements_Result.min[StressType.ItemIndex+1]/level_zero);
  end;

  IF Elements_Result.min[StressType.ItemIndex+1]>=0 THEN NegativeLevels:=0
  ELSE NegativeLevels:=trunc(MyDiv(-Elements_Result.min[StressType.ItemIndex+1],Level));

  END;

PROCEDURE TShowMovingsForm.LoadResults(Path:STRING);
VAR
  i         : INTEGER;
  Node      : TOneNode;
  SumX,SumY,Rez : MyReal;

BEGIN
  Error    := 1;
  FOR i:=Length(Path) DOWNTO 1 DO
  IF (Path[i]='\') Or (Path[i]=':') THEN BREAK;
  SetLength(Path,i);
  Nodes_Result.LoadNodes(Path+'RESULT1.BIN');
  IF Nodes_Result.Error<>0 THEN EXIT;
  Elements_Result.LoadElements(Path+'RESULT2.BIN');
  IF Elements_Result.Error<>0 THEN EXIT;
  ZoneContour.LoadZones(Path+'RESULT2.BIN');
  if ZoneContour.Error<>0 then EXIT;

  ChengeLegendLevel;
  WITH Nodes_Result, StringGrid1 DO BEGIN
    RowCount:=1;
    Cells[0,0]:='�';
    Cells[1,0]:='X';
    Cells[2,0]:='Y';
    Cells[3,0]:='Force X';
    Cells[4,0]:='Force Y';
    Cells[5,0]:='���. ����';
    ColWidths[1]:=45;
    ColWidths[2]:=45;
    ColWidths[0]:=30;
    ColWidths[5]:=60;
    SetFirstElement;
    i:=0;
    SumX:=0;
    SumY:=0;
    REPEAT
      Node:=GetNode(GetCurrentElement);
      IF (Node.ForceX<>0) or (Node.ForceY<>0) THEN BEGIN
        SumX:=SumX+Node.ForceX;
        SumY:=SumY+Node.ForceY;
        Rez:= Rez + sqrt(sqr(Node.ForceY)+sqr(Node.ForceX));
        inc(i);
        RowCount:=i+1;
        Cells[0,i]:=IntToStr(Node.RenumNum);
        Cells[1,i]:=MyFloatToStr(Node.x);
        Cells[2,i]:=MyFloatToStr(Node.y);
        Cells[3,i]:=MyFloatToStr(Node.ForceX);
        Cells[4,i]:=MyFloatToStr(Node.ForceY);
        Cells[5,i]:=MyFloatToStr(sqrt(sqr(Node.ForceY)+sqr(Node.ForceX)));
      END;
    UNTIL NOT SetNextElement;
    i:=RowCount;
    RowCount:=i+1;
    Cells[3,i]:=MyFloatToStr(SumX);
    Cells[4,i]:=MyFloatToStr(SumY);
    Cells[5,i]:=MyFloatToStr(Rez);
    Cells[0,i]:='�����';
    FixedRows:=1;
  END;
  Edit2.Text :=MyFloatToStr(SumX);
  Edit3.text :=MyFloatToStr(SumY);
  Edit7.text :=MyFloatToStr(Rez);
  Error    := 0;
END;

//�������������� ������ �� HLS � RGB
FUNCTION TShowMovingsForm.HLStoRGB;
const
  HLSMAX = 240;
  RGBMAX = 255;
  UNDEFINED = (HLSMAX*2) div 3;

var
  Magic1, Magic2: single;
  R, G, B: integer;

  function HueToRGB(n1, n2, hue: single): single;
  begin
    if (hue < 0) then
      hue := hue+HLSMAX;
    if (hue > HLSMAX) then
      hue:=hue - HLSMAX;
    if (hue < (HLSMAX/6)) then
      result:= ( n1 + (((n2-n1)*hue+(HLSMAX/12))/(HLSMAX/6)) )
    else
    if (hue < (HLSMAX/2)) then
      result:=n2
    else
    if (hue < ((HLSMAX*2)/3)) then
      result:= ( n1 + (((n2-n1)*(((HLSMAX*2)/3)-hue)+(HLSMAX/12))/(HLSMAX/6)))
    else
      result:= ( n1 );
  end;

begin
  if (S = 0) then
  begin
    B:=round( (L*RGBMAX)/HLSMAX );
    R:=B;
    G:=B;
  end
  else
  begin
    if (L <= (HLSMAX/2)) then
      Magic2 := (L*(HLSMAX + S) + (HLSMAX/2))/HLSMAX
    else
      Magic2 := L + S - ((L*S) + (HLSMAX/2))/HLSMAX;
    Magic1 := 2*L-Magic2;
    R := round( (HueToRGB(Magic1,Magic2,H+(HLSMAX/3))*RGBMAX + (HLSMAX/2))/HLSMAX );
    G := round( (HueToRGB(Magic1,Magic2,H)*RGBMAX + (HLSMAX/2)) / HLSMAX );
    B := round( (HueToRGB(Magic1,Magic2,H-(HLSMAX/3))*RGBMAX + (HLSMAX/2))/HLSMAX );
  end;
  if R<0 then
    R:=0;
  if R>RGBMAX then
    R:=RGBMAX;
  if G<0 then
    G:=0;
  if G>RGBMAX then
    G:=RGBMAX;
  if B<0 then
    B:=0;
  if B>RGBMAX then
    B:=RGBMAX;
  Result:=RGB(R,G,B);
end;

//�������������� ������ �� RGB � HLS
PROCEDURE TShowMovingsForm.RGBtoHLS;
const
  HLSMAX = 240;
  RGBMAX = 255;
  UNDEFINED = (HLSMAX*2) div 3;

var
  cMax, cMin: integer;
  Rdelta, Gdelta, Bdelta: single;
  R, G, B: integer;
begin
  r:=GetRValue(Color);
  g:=GetGValue(Color);
  b:=GetBValue(Color);
  cMax := max( max(R,G), B);
  cMin := min( min(R,G), B);
  L := round( ( ((cMax+cMin)*HLSMAX) + RGBMAX )/(2*RGBMAX) );

  if (cMax = cMin) then
  begin
    S := 0;
    H := UNDEFINED;
  end
  else
  begin
    if (L <= (HLSMAX/2)) then
      S := round( ( ((cMax-cMin)*HLSMAX) + ((cMax+cMin)/2) ) / (cMax+cMin) )
    else
      S := round( ( ((cMax-cMin)*HLSMAX) + ((2*RGBMAX-cMax-cMin)/2) ) 
      / (2*RGBMAX-cMax-cMin) );
    Rdelta := ( ((cMax-R)*(HLSMAX/6)) + ((cMax-cMin)/2) ) / (cMax-cMin);
    Gdelta := ( ((cMax-G)*(HLSMAX/6)) + ((cMax-cMin)/2) ) / (cMax-cMin);
    Bdelta := ( ((cMax-B)*(HLSMAX/6)) + ((cMax-cMin)/2) ) / (cMax-cMin);
    if (R = cMax) then
      H := round(Bdelta - Gdelta)
    else
    if (G = cMax) then
      H := round( (HLSMAX/3) + Rdelta - Bdelta)
    else
      H := round( ((2*HLSMAX)/3) + Gdelta - Rdelta );
    if (H < 0) then
      H:=H + HLSMAX;
    if (H > HLSMAX) then
      H:= H - HLSMAX;
  end;
  if S<0 then
    S:=0;
  if S>HLSMAX then
    S:=HLSMAX;
  if L<0 then
    L:=0;
  if L>HLSMAX then
    L:=HLSMAX;

end;

//��������� ����� ����������
FUNCTION TShowMovingsForm.GenerateColor(Value:word):TColor;
VAR
  HM,LM,SM :INTEGER;
  HP,LP,SP :INTEGER;
  st : string;
BEGIN
        //if (Value >= level_zero - 1 - abs(spin_0_min.Value)/level_minus) and
        //   (Value <= abs(spin_0_max.Value)/level_plus + level_zero) then
        //begin
        //        Result:=colorzero.Color;
        //        exit;
        //end;
        //showmessage(inttostr(level_zero));
        if (UseLines.Checked = true) and (CheckBox1.Checked = true) then begin
             if Value = 0 then Result:=colorminus.Color
             else if Value = 1 then Result:=colorminus_0.Color
             else if Value = 2 then Result:=colorplus_0.Color
             else if Value = 3 then Result:=colorplus.Color;
             exit;
        end;
        if Value >= level_zero then begin
                Value := Value - level_zero;
                RGBtoHLS(ColorPlus.Color,HP,LP,SP);
                RGBtoHLS(ColorPlus_0.Color,HM,LM,SM);
                if level_zero <> 0 then begin
                HM:=HM + Trunc((HP-HM)*Value/(level_zero));
                LM:=LM + Trunc((LP-LM)*Value/(level_zero));
                SM:=SM + Trunc((SP-SM)*Value/(level_zero));
                end
                else
                begin
                HM:=HM + Trunc((HP-HM)*Value/(ChangeLegend.Position-1));
                LM:=LM + Trunc((LP-LM)*Value/(ChangeLegend.Position-1));
                SM:=SM + Trunc((SP-SM)*Value/(ChangeLegend.Position-1));
                end;
                Result:=HLStoRGB(HM,LM,SM);
        end
        else
        begin
                RGBtoHLS(ColorMinus_0.Color,HP,LP,SP);
                RGBtoHLS(ColorMinus.Color,HM,LM,SM);
                HM:=HM + Trunc((HP-HM)*Value/(level_zero-1));
                LM:=LM + Trunc((LP-LM)*Value/(level_zero-1));
                SM:=SM + Trunc((SP-SM)*Value/(level_zero-1));
                Result:=HLStoRGB(HM,LM,SM);
        end;
END;

FUNCTION TShowMovingsForm.GenerateColor1(Value:word):TColor;
VAR
  HM,LM,SM :INTEGER;
  HP,LP,SP :INTEGER;
BEGIN
  RGBtoHLS(ColorPlus.Color,HP,LP,SP);
  RGBtoHLS(ColorMinus.Color,HM,LM,SM);
  HM:=HM + Trunc((HP-HM)*Value/(ChangeLegend.Position-1));
  LM:=LM + Trunc((LP-LM)*Value/(ChangeLegend.Position-1));
  SM:=SM + Trunc((SP-SM)*Value/(ChangeLegend.Position-1));
  Result:=HLStoRGB(HM,LM,SM);
END;

//��������� ����� ����������
FUNCTION TShowMovingsForm.GenerateColorOld(Value:word):TColor;
VAR
  Color : INTEGER;
  y     : MyReal;
  r1,r0,g1,g0,b1,b0 : BYTE;

  FUNCTION Gradient(color1,color2,pos:BYTE):BYTE;
  BEGIN
    Result:=ROUND(Color1+(Color2-Color1)*pos/255);
  END;

BEGIN
  r0:=GetRValue(ColorZero.Color);
  g0:=GetGValue(ColorZero.Color);
  b0:=GetBValue(ColorZero.Color);
  y:=Value*Level+Elements_Result.min[StressType.ItemIndex+1];
  IF y+Level<0 THEN
  BEGIN
    //������������� �������
    r1:=GetRValue(ColorMinus.Color);
    g1:=GetGValue(ColorMinus.Color);
    b1:=GetBValue(ColorMinus.Color);
    color:=ROUND(MyDiv((Value-NegativeLevels)*255,-NegativeLevels));
    r1:=Gradient(r0,r1,color);
    g1:=Gradient(g0,g1,color);
    b1:=Gradient(b0,b1,color);
    Result:=RGB(r1,g1,b1);
  END
  ELSE BEGIN
    //������������� ������� � ����
    r1:=GetRValue(ColorPlus.Color);
    g1:=GetGValue(ColorPlus.Color);
    b1:=GetBValue(ColorPlus.Color);
    color:=ROUND(MyDiv((Value-NegativeLevels)*255,ChangeLegend.Position-NegativeLevels));
    r1:=Gradient(r0,r1,color);
    g1:=Gradient(g0,g1,color);
    b1:=Gradient(b0,b1,color);
    Result:=RGB(r1,g1,b1);
  END;
END;

PROCEDURE TShowMovingsForm.ShowArrow;
CONST Coner=PI/12;
VAR
  xx, yy,k     : INTEGER;
  PointLong, A : MyReal;

BEGIN
  Canvas.Pen.Color:=Force;
  PointLong:=Long/7;
  k:=3;//ROUND(ForceK/2);
  Canvas.MoveTo(x,y);
  xx:=ROUND(x+long*cos(Alfa));
  yy:=ROUND(y-long*sin(Alfa));
  Canvas.LineTo(xx,yy);
  A:=pi+Alfa-coner;
  Canvas.LineTo(ROUND(xx+PointLong*cos(A)),ROUND(yy-PointLong*sin(A)));
  A:=pi+Alfa+coner;
  Canvas.MoveTo(xx,yy);
  Canvas.LineTo(ROUND(xx+PointLong*cos(A)),ROUND(yy-PointLong*sin(A)));
  Canvas.Brush.Color:=Force;
  Canvas.Ellipse(x-k,y-k,x+k,y+k);
END;


PROCEDURE TShowMovingsForm.ShowText;
VAR
  h,w:INTEGER;

BEGIN
  h:=ROUND(Canvas.TextHeight(s)/2);
  w:=ROUND(Canvas.TextWidth(s)/2);
  Canvas.TextOut(x-w,y-h,s);
END;


PROCEDURE TShowMovingsForm.ShowBoundForce;
  FUNCTION vector(x,y:MyReal):INTEGER;
  BEGIN
    Result:=ROUND((sqrt(sqr(x)+sqr(y)))*Scale*ForceK);
  END;

VAR
  OneNode : TOneNode;
  x, y    : INTEGER;
  Bitmap  : TBitMap;
  Long    : INTEGER;

BEGIN
  WITH Nodes_Result DO BEGIN
    IF Nodes_Result.SetFirstElement THEN BEGIN
      Bitmap := TBitmap.Create;
      REPEAT
        OneNode:=GetMovedNode(GetCurrentElement,Mover.Position*MoverK);
        x:=Xreal2Xpaint(OneNode.x);
        y:=Yreal2Ypaint(OneNode.y);
        IF UseForce.Checked THEN BEGIN
          Long:=vector(OneNode.ForceX,OneNode.ForceY);
          IF Long<>0 THEN ShowArrow(Canvas,x,y,long,ArcTan2(OneNode.ForceY,OneNode.ForceX));
        END;
        IF UseBound.Checked THEN BEGIN
          CASE OneNode.BondType OF
             1 : Bitmap.Handle:=LoadBitmap(HInstance,'BOUND01');
            10 : Bitmap.Handle:=LoadBitmap(HInstance,'BOUND10');
            11 : Bitmap.Handle:=LoadBitmap(HInstance,'BOUND11');
          END;
          IF OneNode.BondType<>0 THEN BEGIN
            Bitmap.Transparent := TRUE;
            Bitmap.TransparentMode := tmAuto;
            x:=ROUND(x-Bitmap.Width/2);
            y:=ROUND(y-Bitmap.Height/2);
            Canvas.Draw(x,y,Bitmap);
          END;
        END;
        IF UseNumNode.Checked THEN BEGIN
          Canvas.Brush.Color:=clWhite;
          ShowText(Canvas,x,y,IntToStr(OneNode.RenumNum));
        END;
      UNTIL NOT Nodes_Result.SetNextElement;
      Bitmap.Free;
    END;
  END;
END;

//���������� ���� �������
PROCEDURE TShowMovingsForm.ShowElement(Canvas:TCanvas;OneElement:TOneElement);
VAR
  OneNode : TOneNode;
  K_M     : MyReal;
  i,beg,off       : INTEGER;
  x, y    : ARRAY [1..360] OF INTEGER; //���������� �����
  LevNode : ARRAY [1..360] OF INTEGER; //����� ������ � �����
  ID      : ARRAY [1..360] OF INTEGER;
  stress  : ElStressArray; //������� ���������� � �����
  Kol     : INTEGER; //���������� �������
  ID_now,d :  INTEGER;
  x1,y1   : ARRAY [1..3] OF INTEGER;
  st : string;

BEGIN
  //��� ��������
  Canvas.Pen.Style:=psClear;

  //������� ���������� � ����� � ������� ��������
  StressInElement(OneElement,stress);
  //���������� ����� ��������
  K_M:=Mover.Position*MoverK;
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node1,K_M);
  x[1]:=Xreal2Xpaint(OneNode.x);
  y[1]:=Yreal2Ypaint(OneNode.y);
  x1[1]:=x[1]; y1[1]:=y[1];
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node2,K_M);
  x[2]:=Xreal2Xpaint(OneNode.x);
  y[2]:=Yreal2Ypaint(OneNode.y);
  x1[2]:=x[2]; y1[2]:=y[2];                 
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node3,K_M);
  x[3]:=Xreal2Xpaint(OneNode.x);
  y[3]:=Yreal2Ypaint(OneNode.y);
  x1[3]:=x[3]; y1[3]:=y[3];
  //���������� ������ ������� � �����
  //st := 'i ' + IntToStr(level_zero);
  //ShowMessage(st);
  FOR i:=1 TO 3 DO BEGIN
    if stress[i] >= 0 then
    begin
        LevNode[i]:= abs(Trunc(stress[i]/Level_plus)) + level_zero;
        if stress[i] >= abs(spin_0_max.Value) then LevNode[i] := 3
        else LevNode[i] := 2;
        //if LevNode[i] = 2 then begin
        //st := 'p ' + IntToStr(LevNode[i]) +' '+ CurrToStr(stress[i]);
        //ShowMessage(st);
        //end;
    end
    else
    begin
        LevNode[i]:= abs(Trunc((Elements_Result.min[StressType.ItemIndex+1]-stress[i])/Level_minus));
        if stress[i] <= -abs(spin_0_min.Value) then LevNode[i] := 0
        else LevNode[i] := 1;
        //if LevNode[i] = -1 then begin
        //st := 'm ' + IntToStr(LevNode[i]) +' '+ CurrToStr(stress[i]);
        //ShowMessage(st);
        //end;
    end;



  END;
  //���������� ��������� � ������� ������������� �����
  Kol:=3;
  ID[1]:=0;
  ID_now:=0;
  //1
  if LevNode[1] > LevNode[2] then
    begin beg:= 2; off:= 1; d:=-1; ID_now:=LevNode[1]-LevNode[2]+1; end
  else
    begin beg:= 1; off:= 2; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN

   //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        //K_M:=(i-level_zero)*Level_plus;
        if i = 2 then K_M:=0;
        if i = 3 then K_M:=abs(spin_0_max.Value);
        if K_M > stress[off] then K_M:=stress[off];
        //st := 'm3 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        //K_M:=Elements_Result.min[StressType.ItemIndex+1]+((i)*Level_minus);
        if i = 1 then K_M:=-abs(spin_0_min.Value);
        if i = 0 then K_M:=stress[off];
        //if K_M < stress[off] then K_M:=stress[off];
        //st := 'm3 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;

    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=LevNode[off]-LevNode[beg]+1;
  ID[2]:=ID_now;
  //2
  if LevNode[2] > LevNode[3] then
    begin beg:= 3; off:= 2; d:=-1; ID_now:=ID_now + LevNode[2]-LevNode[3]+1; end
  else
    begin beg:= 2; off:= 3; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        //K_M:=(i-level_zero)*Level_plus;
      if i = 2 then K_M:=0;
        if i = 3 then K_M:=abs(spin_0_max.Value);
        if K_M > stress[off] then K_M:=stress[off];
        //st := 'm4 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        //K_M:=Elements_Result.min[StressType.ItemIndex+1]+((i)*Level_minus);
        if i = 1 then K_M:=-abs(spin_0_min.Value);
        if i = 0 then K_M:=stress[off];
        //if K_M < stress[off] then K_M:=stress[off];
        //st := 'm4 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;

    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=ID[2] + LevNode[off]-LevNode[beg]+1;
  ID[3]:=ID_now;
  //3
  if LevNode[3] > LevNode[1] then
    begin beg:= 1; off:= 3; d:=-1; ID_now:=ID_now + LevNode[3]-LevNode[1]+1; end
  else
    begin beg:= 3; off:= 1; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
   //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        //K_M:=(i-level_zero)*Level_plus;
       if i = 2 then K_M:=0;
        if i = 3 then K_M:=abs(spin_0_max.Value);
        if K_M > stress[off] then K_M:=stress[off];
        //st := 'm5 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        //K_M:=Elements_Result.min[StressType.ItemIndex+1]+((i)*Level_minus);
        if i = 1 then K_M:=-abs(spin_0_min.Value);
        if i = 0 then K_M:=stress[off];
        //if K_M < stress[off] then K_M:=stress[off];
        //st := 'm5 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  //����������
  FOR beg:=1 TO Kol DO BEGIN
  FOR i:=1 TO Kol-1 DO BEGIN
    if LevNode[i] > LevNode[i+1] then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
    if (LevNode[i] = LevNode[i+1]) and (ID[i]>ID[i+1]) then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
  end;
  end;
  //��������� ���������
  LevNode[Kol+1]:=-1;
  off:=LevNode[1];
  beg:=0;
  for i:=1 to Kol+1 do begin
    inc(beg);
    //if LevNode[i] = 0 then begin
    //st := 'm1 ' + IntToStr(LevNode[i]);
    //ShowMessage(st);
    //end;
    if off<>LevNode[i] then begin
      Canvas.Brush.Color:=GenerateColor(LevNode[i-1]);
      if beg = 4 then
        Canvas.Polygon([point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      if beg = 5 then begin
        Canvas.Polygon([point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      if beg = 6 then begin
        Canvas.Polygon([point(x[i-5],y[i-5]),point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      off:=LevNode[i];
      beg:=1;
    end;
  end;
  Canvas.Pen.Style:=psSolid;
  Canvas.PolyLine([point(x1[1],y1[1]),point(x1[2],y1[2]),point(x1[3],y1[3]),point(x1[1],y1[1])]);
  IF UseNumZone.Checked THEN ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Number));

  IF UseNumMater.Checked THEN begin
   Canvas.Brush.Color:=clYellow;
   ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Material));
  END;
END;

PROCEDURE TShowMovingsForm.ShowElement1(Canvas:TCanvas;OneElement:TOneElement);
VAR
  OneNode : TOneNode;
  K_M     : MyReal;
  i,beg,off       : INTEGER;
  x, y    : ARRAY [1..360] OF INTEGER; //���������� �����
  LevNode : ARRAY [1..360] OF INTEGER; //����� ������ � �����
  ID      : ARRAY [1..360] OF INTEGER;
  stress  : ElStressArray; //������� ���������� � �����
  Kol     : INTEGER; //���������� �������
  ID_now,d :  INTEGER;
  x1,y1   : ARRAY [1..3] OF INTEGER;
  st : string;

BEGIN
  //��� ��������
  Canvas.Pen.Style:=psClear;

  //������� ���������� � ����� � ������� ��������
  StressInElement(OneElement,stress);
  //���������� ����� ��������
  K_M:=Mover.Position*MoverK;
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node1,K_M);
  x[1]:=Xreal2Xpaint(OneNode.x);
  y[1]:=Yreal2Ypaint(OneNode.y);
  x1[1]:=x[1]; y1[1]:=y[1];
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node2,K_M);
  x[2]:=Xreal2Xpaint(OneNode.x);
  y[2]:=Yreal2Ypaint(OneNode.y);
  x1[2]:=x[2]; y1[2]:=y[2];
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node3,K_M);
  x[3]:=Xreal2Xpaint(OneNode.x);
  y[3]:=Yreal2Ypaint(OneNode.y);
  x1[3]:=x[3]; y1[3]:=y[3];
  //���������� ������ ������� � �����
  FOR i:=1 TO 3 DO BEGIN
    if stress[i] >= 0 then
    begin
        LevNode[i]:= abs(Trunc(stress[i]/Level_plus)) + level_zero;
        //st := 'p ' + IntToStr(LevNode[i]) +' '+ CurrToStr(stress[i]);
        //ShowMessage(st);
    end
    else
    begin
        LevNode[i]:= abs(Trunc((Elements_Result.min[StressType.ItemIndex+1]-stress[i])/Level_minus));
        //st := 'm ' + IntToStr(LevNode[i]) +' '+ CurrToStr(stress[i]);
        //ShowMessage(st);
    end;
  END;
  //���������� ��������� � ������� ������������� �����
  Kol:=3;
  ID[1]:=0;
  ID_now:=0;
  //1
  if LevNode[1] > LevNode[2] then
    begin beg:= 2; off:= 1; d:=-1; ID_now:=LevNode[1]-LevNode[2]+1; end
  else
    begin beg:= 1; off:= 2; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        K_M:=(i-level_zero)*Level_plus;
        //st := 'm3 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        K_M:=Elements_Result.min[StressType.ItemIndex+1]+((i)*Level_minus);
        //st := 'm3 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=LevNode[off]-LevNode[beg]+1;
  ID[2]:=ID_now;
  //2
  if LevNode[2] > LevNode[3] then
    begin beg:= 3; off:= 2; d:=-1; ID_now:=ID_now + LevNode[2]-LevNode[3]+1; end
  else
    begin beg:= 2; off:= 3; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        K_M:=(i-level_zero)*Level_plus;
        //st := 'm4 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        K_M:=Elements_Result.min[StressType.ItemIndex+1]+(i*Level_minus);
        //st := 'm4 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;

    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=ID[2] + LevNode[off]-LevNode[beg]+1;
  ID[3]:=ID_now;
  //3
  if LevNode[3] > LevNode[1] then
    begin beg:= 1; off:= 3; d:=-1; ID_now:=ID_now + LevNode[3]-LevNode[1]+1; end
  else
    begin beg:= 3; off:= 1; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        K_M:=(i-level_zero)*Level_plus;
        //st := 'm5 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        K_M:=Elements_Result.min[StressType.ItemIndex+1]+(i*Level_minus);
        //st := 'm5 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  //����������
  FOR beg:=1 TO Kol DO BEGIN
  FOR i:=1 TO Kol-1 DO BEGIN
    if LevNode[i] > LevNode[i+1] then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
    if (LevNode[i] = LevNode[i+1]) and (ID[i]>ID[i+1]) then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
  end;
  end;
  //��������� ���������
  LevNode[Kol+1]:=-1;
  off:=LevNode[1];
  beg:=0;
  for i:=1 to Kol+1 do begin
    inc(beg);
    if off<>LevNode[i] then begin
      Canvas.Brush.Color:=GenerateColor(LevNode[i-1]);
      if beg = 4 then
        Canvas.Polygon([point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      if beg = 5 then begin
        Canvas.Polygon([point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      if beg = 6 then begin
        Canvas.Polygon([point(x[i-5],y[i-5]),point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      off:=LevNode[i];
      beg:=1;
    end;
  end;
  Canvas.Pen.Style:=psSolid;
  Canvas.PolyLine([point(x1[1],y1[1]),point(x1[2],y1[2]),point(x1[3],y1[3]),point(x1[1],y1[1])]);
  IF UseNumZone.Checked THEN ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Number));

  IF UseNumMater.Checked THEN begin
   Canvas.Brush.Color:=clYellow;
   ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Material));
  END;
END;

PROCEDURE TShowMovingsForm.ShowElement2(Canvas:TCanvas;OneElement:TOneElement);
VAR
  OneNode : TOneNode;
  K_M     : MyReal;
  i,beg,off       : INTEGER;
  x, y    : ARRAY [1..360] OF INTEGER; //���������� �����
  LevNode : ARRAY [1..360] OF INTEGER; //����� ������ � �����
  ID      : ARRAY [1..360] OF INTEGER;
  stress  : ElStressArray; //������� ���������� � �����
  Kol     : INTEGER; //���������� �������
  ID_now,d :  INTEGER;
  x1,y1   : ARRAY [1..3] OF INTEGER;
  st : string;

BEGIN
  //��� ��������
  Canvas.Pen.Style:=psClear;

  //������� ���������� � ����� � ������� ��������
  StressInElement(OneElement,stress);
  //���������� ����� ��������
  K_M:=Mover.Position*MoverK;
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node1,K_M);
  x[1]:=Xreal2Xpaint(OneNode.x);
  y[1]:=Yreal2Ypaint(OneNode.y);
  x1[1]:=x[1]; y1[1]:=y[1];
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node2,K_M);
  x[2]:=Xreal2Xpaint(OneNode.x);
  y[2]:=Yreal2Ypaint(OneNode.y);
  x1[2]:=x[2]; y1[2]:=y[2];
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node3,K_M);
  x[3]:=Xreal2Xpaint(OneNode.x);
  y[3]:=Yreal2Ypaint(OneNode.y);
  x1[3]:=x[3]; y1[3]:=y[3];
  //���������� ������ ������� � �����
  FOR i:=1 TO 3 DO BEGIN
        LevNode[i]:= Trunc((stress[i] - Elements_Result.min[StressType.ItemIndex+1])/Level);
  END;
  //���������� ��������� � ������� ������������� �����
  Kol:=3;
  ID[1]:=0;
  ID_now:=0;
  //1
  if LevNode[1] > LevNode[2] then
    begin beg:= 2; off:= 1; d:=-1; ID_now:=LevNode[1]-LevNode[2]+1; end
  else
    begin beg:= 1; off:= 2; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=LevNode[off]-LevNode[beg]+1;
  ID[2]:=ID_now;
  //2
  if LevNode[2] > LevNode[3] then
    begin beg:= 3; off:= 2; d:=-1; ID_now:=ID_now + LevNode[2]-LevNode[3]+1; end
  else
    begin beg:= 2; off:= 3; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=ID[2] + LevNode[off]-LevNode[beg]+1;
  ID[3]:=ID_now;
  //3
  if LevNode[3] > LevNode[1] then
    begin beg:= 1; off:= 3; d:=-1; ID_now:=ID_now + LevNode[3]-LevNode[1]+1; end
  else
    begin beg:= 3; off:= 1; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  //����������
  FOR beg:=1 TO Kol DO BEGIN
  FOR i:=1 TO Kol-1 DO BEGIN
    if LevNode[i] > LevNode[i+1] then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
    if (LevNode[i] = LevNode[i+1]) and (ID[i]>ID[i+1]) then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
  end;
  end;
  //��������� ���������
  LevNode[Kol+1]:=-1;
  off:=LevNode[1];
  beg:=0;
  for i:=1 to Kol+1 do begin
    inc(beg);
    if off<>LevNode[i] then begin
      Canvas.Brush.Color:=GenerateColor1(LevNode[i-1]);
      if beg = 4 then
        Canvas.Polygon([point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      if beg = 5 then begin
        Canvas.Polygon([point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      if beg = 6 then begin
        Canvas.Polygon([point(x[i-5],y[i-5]),point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      off:=LevNode[i];
      beg:=1;
    end;
  end;
  Canvas.Pen.Style:=psSolid;
  Canvas.PolyLine([point(x1[1],y1[1]),point(x1[2],y1[2]),point(x1[3],y1[3]),point(x1[1],y1[1])]);
  IF UseNumZone.Checked THEN ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Number));

  IF UseNumMater.Checked THEN begin
   Canvas.Brush.Color:=clYellow;
   ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Material));
  END;
END;

//�������� �.�.
PROCEDURE TShowMovingsForm.ShowMaterialColoredElement(Canvas:TCanvas;OneElement:TOneElement);
VAR
  x1,x2,x3,y1,y2,y3   : Integer;
  OneNode             : TOneNode;
  TempBrushColor      : TColor;
  TempPenColor        : TColor;
BEGIN

  OneNode:=Nodes_Result.GetNode(OneElement.Node1);
  x1:=Xreal2Xpaint(OneNode.x);
  y1:=Yreal2Ypaint(OneNode.y);
  OneNode:=Nodes_Result.GetNode(OneElement.Node2);
  x2:=Xreal2Xpaint(OneNode.x);
  y2:=Yreal2Ypaint(OneNode.y);
  OneNode:=Nodes_Result.GetNode(OneElement.Node3);
  x3:=Xreal2Xpaint(OneNode.x);
  y3:=Yreal2Ypaint(OneNode.y);
  TempBrushColor:=Canvas.Brush.Color;
  TempPenColor:=Canvas.Pen.Color;
  Canvas.Pen.Color := clBlack;
  case OneElement.Material of
    1: Canvas.Brush.Color :=  ColorMinus.Color;
    2: Canvas.Brush.Color :=  ColorZero.Color;
    3: Canvas.Brush.Color :=  ColorPlus.Color;
  end;
  Canvas.Polygon([point(x1,y1),point(x2,y2),point(x3,y3)]);
  Canvas.Brush.Color:=TempBrushColor;
  Canvas.Pen.Color:=TempPenColor;

END;

PROCEDURE TShowMovingsForm.ShowElementOld;
VAR
  OneNode : TOneNode;
  x1, y1  : INTEGER;
  x2, y2  : INTEGER;
  x3, y3  : INTEGER;
  K_M     : MyReal;

BEGIN
  K_M:=Mover.Position*MoverK;
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node1,K_M);
  x1:=Xreal2Xpaint(OneNode.x);
  y1:=Yreal2Ypaint(OneNode.y);
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node2,K_M);
  x2:=Xreal2Xpaint(OneNode.x);
  y2:=Yreal2Ypaint(OneNode.y);
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node3,K_M);
  x3:=Xreal2Xpaint(OneNode.x);
  y3:=Yreal2Ypaint(OneNode.y);
  Canvas.Polygon([point(x1,y1),point(x2,y2),point(x3,y3)]);
  IF UseNumZone.Checked THEN ShowText(Canvas,ROUND((x1+x2+x3)/3),ROUND((y1+y2+y3)/3),inttostr(OneElement.Number));

  IF UseNumMater.Checked THEN begin
   Canvas.Brush.Color:=clYellow;
   ShowText(Canvas,ROUND((x1+x2+x3)/3),ROUND((y1+y2+y3)/3),inttostr(OneElement.Material));
  END;
END;

//�������� �������� ���������� � ����� ��������
FUNCTION TShowMovingsForm.StressInElement(OneElement : TOneElement;VAR stress : ElStressArray):BOOLEAN;
VAR
  Count      : ARRAY [1..3] OF BYTE;
  K          : ARRAY [1..3] OF MyReal;
  Node       : ARRAY [1..3] OF TOneNode;
  Strain     : ARRAY [1..3] OF MyReal;
  X,Y,X_OPT,Y_OPT        : MyReal;
  RX,RY      : MyReal;
  i,j        : BYTE;
  z,Num      : INTEGER;

BEGIN
  // ���������� ���������� �����, ������� �������� ��.
  Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
  Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);

  j:= StressType.ItemIndex+1;

  FOR i:=1 TO 3 DO BEGIN
    Strain[i]:=0;
    Count[i]:=0;
  END;
  // ���������� ����� ���������� � ������ �� 3-� �����.
  Num := Elements_Result.GetNumElements;
  FOR z:=1 TO Num DO BEGIN
    OneElement:=Elements_Result.GetElement(z);
    FOR i:=1 TO 3 DO BEGIN
      IF (OneElement.Node1=Node[i].Number) OR (OneElement.Node2=Node[i].Number) OR (OneElement.Node3=Node[i].Number) THEN BEGIN
        Strain[i]:=Strain[i]+OneElement.Strain[j];
        INC(Count[i]);
      END;
    END;
  END;
  // ���������� ������� ���������� � ������ �� 3-� �����.
  FOR i:=1 TO 3 DO Strain[i]:=MyDiv(Strain[i], Count[i]);
  // ���������� ����� ���������������� ��������� � 3-� �����.
  RX:=MyDiv(Node[1].X*Strain[1]+Node[2].X*Strain[2]+Node[3].X*Strain[3], Strain[1]+Strain[2]+Strain[3]);
  RY:=MyDiv(Node[1].Y*Strain[1]+Node[2].Y*Strain[2]+Node[3].Y*Strain[3], Strain[1]+Strain[2]+Strain[3]);
  // ������� �����
  X_OPT:=(node[1].x+node[2].x+node[3].x)/3;
  Y_OPT:=(node[1].y+node[2].y+node[3].y)/3;
  FOR z:=1 to 3 do begin
    X:=node[z].x + (X_OPT-node[z].x)/10000;
    Y:=node[z].y + (Y_OPT-node[z].y)/10000;
    // ��� ������ �� 3-� ������ ���������� ����������� �� ������� �� ���������� � �����.
    FOR i:=1 TO 3 DO K[i]:=MyDiv(SQRT(SQR(RX-Node[i].X)+SQR(RY-Node[i].Y)), SQRT(SQR(X-Node[i].X)+SQR(Y-Node[i].Y)));
    // ���������� ���������� � �����.
    stress[z]:=MyDiv(Strain[1]*K[1]+Strain[2]*K[2]+Strain[3]*K[3], K[1]+K[2]+K[3]);
  end;
  Result:=TRUE;
END;


PROCEDURE TShowMovingsForm.ShowAxes;
BEGIN
  IF (UseAxes.Checked) THEN BEGIN
    WITH Canvas DO BEGIN
      Pen.Color:=clBlack;
      Brush.Style:=bsClear;
      Moveto(0,Yreal2Ypaint(0));
      LineTo(PaintWidth,Yreal2Ypaint(0));
      Moveto(Xreal2Xpaint(0),0);
      LineTo(Xreal2Xpaint(0),PaintHeight);
    END;
  END;
END;

PROCEDURE TShowMovingsForm.ShowSelectedPoint;
VAR Xi, Yi : Integer;
BEGIN
      IF ( NOT DrawSelectedPoint ) THEN
        exit;
      Xi := Xreal2Xpaint(X);
      Yi := Yreal2Ypaint(Y);
      WITH Canvas DO BEGIN
        Canvas.Brush.Color := clRed;
        //Brush.Color := clRed;
        //Brush.Style := bsClear;
        Ellipse(Xi - 3, Yi - 3, Xi + 3, Yi + 3);
      END;
END;

//���������� ��� ��������
PROCEDURE TShowMovingsForm.ShowElements(Canvas:TCanvas);
VAR
  OneElement : TOneElement;
  my : integer;
  findlevel : integer;

BEGIN
  WITH Canvas DO BEGIN
    Brush.Color:=BackGR;
    FillRect(ClipRect);
    //for my:=63 to 64 do begin
    if LinesShow = true then
    begin
        if CheckBox1.Checked = true then
        begin
                for my:=1 to Elements_Result.GetNumElements do
                begin
                        OneElement:=Elements_Result.GetElement(my);
                        ShowElement(Canvas,OneElement);
                end
        end
        else
        begin
                for my:=1 to Elements_Result.GetNumElements do
                begin
                        OneElement:=Elements_Result.GetElement(my);
                        ShowElement1(Canvas,OneElement);
                end
        end
    end else begin
      if not(CheckBox2.Checked=True) then begin
        for my:=1 to Elements_Result.GetNumElements do begin
          OneElement:=Elements_Result.GetElement(my);
          //�������� ���������� �.�. 30.05.2009
          //���� ���������: - ������� ������ ������ ������. � ������: ���������� � ���� ������� ������������� �����.
          //�� �������� ���������� � ������� ����������� ���������� ������� ����, ����� ������� ����������� ��������
          //���������� ����������� �������� ������ �����.
          IF OneElement.strain[StressType.ItemIndex+1]=Elements_Result.max[StressType.ItemIndex+1] THEN findlevel:=ChangeLegend.Position
          ELSE findlevel:=Trunc(MyDiv((OneElement.strain[StressType.ItemIndex+1]-(Elements_Result.min[StressType.ItemIndex+1])),Level))+1;
          Brush.Color:=GenerateColorOld(findlevel-1);
          ShowElementOld(Canvas,OneElement);
        end;
      end else begin
        //��������� ��������� �.�.
        for my := 1 to Elements_Result.GetNumElements do begin
          OneElement:=Elements_Result.GetElement(my);
          ShowMaterialColoredElement(Canvas,OneElement);
        end;
      end;
    end;
  END;
  If Prd=1 Then UseTestElements(Canvas);

  PaintZonesContour(Canvas);
  ShowBoundForce(Canvas);
  ShowAxes(Canvas);         
  ShowSelectedPoint(Canvas);
END;

// ������� ��������� ����� ����� � ������������
function getDimFileName(f:string):string;
var
     i : integer;
     s, s1 : string;
begin
     i := 0;
     s1 := f;
     while pos('.',s1) > 0 do
     begin
          i := i + pos('.',s1);
          delete(s1,1,pos('.',s1));
     end;
     s := copy(f,1,i-1);
     Result := s;
end;

{
������� ��� ���������
����� ������� ��
������� ���� � ����� �������
������� ����� � �������
}
function GetProjectName:String;
var
  projName:String;
  tempStr:String;
  slashPos:Integer;
  Registry:TRegistry;
begin
      projName := '';
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg, true) then
     begin
          if Registry.ValueExists('InputFileName') then
          begin
          // �������� ������ ���� �� ����� �������
            tempStr:=Registry.ReadString('InputFileName');

            // �������� ������ ��� ����� �������
            while(Pos('\',tempStr) <> 0) do
            begin
              slashPos:= Pos('\',tempStr);
              Delete(tempStr,1,slashPos);
            end;
            Delete(tempStr,Pos('.',tempStr),Length(tempStr));
            // ������� ���������� � �������� ��� �������
            projName:= tempStr;
          end;
     end;
     Result := projName;
End;

PROCEDURE TShowMovingsForm.FormCreate(Sender:TObject);
var
     MainParams,MP    : TMainParams;
     MPM              : TMainParamsMaterial;
BEGIN
Caption:=Caption + ' ' +GetProjectName;
//--------------------------------------//
  with TZonesClass.Create do
  begin
    Load(Project_GetFormFile);
    Edit4.Text:=IntToStr(MainParamsClass.MainParams.NRC);
    Edit5.Text:=GetSilaName(GetSila);
    Edit6.Text:=GetDimensionName(GetCurDim);
    Free;
  end;
//--------------------------------------//
  bmpPic:=Tbitmap.Create;
  Updating:=FALSE;
  Force:=clBlue;
  BackGR:=clWhite;
  OnlyUpdate:=TRUE;
  MousePushed:=FALSE;
  CM:=Screen.PixelsPerInch/CM_Inch;
  Nodes_Result:=TNodes.Create;
  Elements_Result:=TElements.Create;
  ZoneContour:=ZoneContourPoints.Create;
  Left:=0;
  Top:=60;
  OffsetX:=0;
  OffsetY:=0;
  ActiveToolButton:=DefaultAction;
  Scale:=1;
  OnlyUpdate:=FALSE;
  StressMethod := StressMethodLoad(1);
  DrawSelectedPoint := False;  
  //��������� �����
  //CPlus:=RGB(255,0,0);
  //CMinus:=RGB(0,255,0);
  //LinesCPlus:=RGB(255,0,0);
  //LinesCMinus:=RGB(255,0,255);

  case StressMethod of
  1: StressMethod1.Checked :=True;
  2: StressMethod2.Checked :=True;
  3: StressMethod3.Checked :=True;
  end;
END;

PROCEDURE TShowMovingsForm.FormDestroy(Sender:TObject);
BEGIN
  Nodes_Result.Free;
  Elements_Result.Free;
END;


PROCEDURE TShowMovingsForm.FormResize(Sender:TObject);
VAR
  dop : INTEGER;
  cfF : TIniFile;
  SigmaLocation:string;
  i:integer;
BEGIN
  // ���������� ��������� �����
  dop:=0;
  top:=0;
       //����������� ����� ������������ �����
     SigmaLocation   :=LowerCase(ExtractFilePath(ParamStr(0)));
     i:=pos('\bin',SigmaLocation);
     if i>0 then SetLength(SigmaLocation,i);
     cfF:=TIniFile.Create(SigmaLocation+'bin\sforms.ini');

//  cfF:=TIniFile.Create('sforms.ini');
  TRY
    dop:=CfF.ReadInteger('�������','������',top);
    top:=dop-StatusBar1.Height-8;
    left:=0;
    Height:=Screen.Height-dop;
    cfF.Free;
  EXCEPT
    MessageDlg('�� ���� ��������� ���� sforms.ini!',mtError,[mbOk],0);
  END;
  Constraints.MaxHeight:=Screen.Height-dop;
  top:=dop-StatusBar1.Height-8;
  ChangeDrawSize;
END;


PROCEDURE TShowMovingsForm.PaintBox1Paint(Sender: TObject);
VAR
  Bitmap : TBitMap;

BEGIN
  IF OnlyUpdate THEN EXIT;
  PaintWidth:=PaintBox1.Width;
  PaintHeight:=PaintBox1.Height;
  CenterX:=Trunc(PaintWidth/2);
  CenterY:=Trunc(PaintHeight/2);
  PaintBox1.Canvas.Lock;
  TRY
    IF UseBuffer.Checked THEN BEGIN
      Bitmap := TBitmap.Create;
      Bitmap.Width:=PaintBox1.Width;
      Bitmap.Height:=PaintBox1.Height;
    END;
    IF UseBuffer.Checked THEN BEGIN
      ShowElements(BitMap.Canvas);
      paintbox1.Canvas.Draw(0,0,BitMap);
    END
    ELSE ShowElements(PaintBox1.Canvas);
  FINALLY
    IF UseBuffer.Checked THEN BEGIN
      // ��������� ����������� � ����� � ����������
      bmpPic.Width:=Bitmap.Width;
      bmpPic.Height:=Bitmap.Height;
      bmpPic.Canvas.Draw(0,0,BitMap);
      Bitmap.Free;
    END;
  END;
  PaintBox1.Canvas.Unlock;
END;


PROCEDURE TShowMovingsForm.UseLegendClick(Sender: TObject);
BEGIN
  IF UseLegend.Checked THEN BEGIN
    Splitter2.Visible:=TRUE;
    LegendPanel.Visible:=TRUE;
  END
  ELSE BEGIN
    Splitter2.Visible:=FALSE;
    LegendPanel.Visible:=FALSE;
  END;
  ChangeDrawSize;
END;

PROCEDURE TShowMovingsForm.UseLinesClick(Sender: TObject);
VAR
  z : integer;
BEGIN

if (UseLines.Checked) then TestElements.Checked:=false;
if checkbox1.Checked then checkbox2.Checked:=false; //�������� �.�.

if useLines.Checked then checkbox2.Checked:=false; //�������� �.�.

  if (Sender = UseLines) and (UseLines.Checked = false) then
        CheckBox1.Checked := false;
  if (Sender = CheckBox1) and (CheckBox1.Checked = true) then begin
        CheckBox1.Checked := true;
        UseLines.Checked := true;
  end;

    IF CheckBox1.Checked = false THEN BEGIN
        Spin_0_max.Visible := false;
        Spin_0_min.Visible := false;
        mi.Visible := false;
        pl.Visible := false;
  end
  else begin
        Spin_0_max.Visible := true;
        Spin_0_min.Visible := true;
        mi.Visible := true;
        pl.Visible := true;
  end;

  IF UseLines.Checked = true THEN BEGIN
      LinesShow:=true;
      ChangeLegend.Max := 60;
      if ChangeLegend.Position > 60 then
        ChangeLegend.Position:=60;
      ColorMinus_0.Visible := true;
      ColorPlus_0.Visible := true;
      ColorZero.Visible := false;
      //ColorPlus.Color:=LinesCPlus;
      //ColorMinus.Color:=LinesCMinus;
      //ColorZero.Enabled:=false;
  END
  ELSE BEGIN
      LinesShow:=false;
      ChangeLegend.Max := 255;
      ColorZero.Visible := true;
      ColorPlus_0.Visible := false;
      ColorMinus_0.Visible := false;
      Spin_0_max.Visible := false;
      Spin_0_min.Visible := false;

      //ColorPlus.Color:=CPlus;
      //ColorMinus.Color:=CMinus;
      //ColorZero.Enabled:=true;
  END;



  z := ChangeLegend.Position;
  if (UseLines.Checked = true) and (CheckBox1.Checked = true) then z := 4;
  ChangeLegend.Hint:=inttostr(z);
  LevelNumber.Caption:= ChangeLegend.Hint;
  ChengeLegendLevel;
  LegendRePaint;
  MainRePaint;
END;

PROCEDURE TShowMovingsForm.RePaintPlate(Sender: TObject);
BEGIN
  if UseBuffer.Checked then DoubleBuffered:=true else DoubleBuffered:=false;
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.EditScaleChange(Sender: TObject);
BEGIN
  SetDiapazon;
END;


PROCEDURE TShowMovingsForm.TrackBar1Change(Sender: TObject);
VAR
  Half,Value : MyReal;

BEGIN
  Half:=ROUND((TrackBar1.Max)/2);
  Value:=ABS(TrackBar1.Position-Half);
  IF TrackBar1.Position>=Half THEN Scale:=1+Value ELSE Scale:=1/(1+Value);
  Scaling;
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.ChangeLegendChange(Sender: TObject);
VAR
   z:integer;
BEGIN
if (Spin_0_max.text = '') then exit;
if (Spin_0_min.text = '') then exit;
  z := ChangeLegend.Position;
  if (UseLines.Checked = true) and (CheckBox1.Checked = true) then z := 4;

  ChangeLegend.Hint:=inttostr(z);
  LevelNumber.Caption:= ChangeLegend.Hint;
  ChengeLegendLevel;
  MainRePaint;
  LegendRePaint;
END;


PROCEDURE TShowMovingsForm.StressTypeClick(Sender: TObject);
BEGIN
  ChengeLegendLevel;
  MainRePaint;
  LegendRePaint;
END;


// ����� �������
PROCEDURE TShowMovingsForm.LegendPaint(Sender: TObject);

  PROCEDURE ShowLegendHints(Canvas:TCanvas;Left,Top:INTEGER);
  VAR
    long,k              : MyReal;
    pos                 : INTEGER;
    dop,dop1,dop2       : INTEGER; //dop - ��� ��������, 1dop - ����� max � dop, 2dop - ����� dop � min
    dopp,dopp1,dopp2    : MyReal;
    dopSt,dopSt1,dopSt2 : STRING;
    len,dlevel          : MyReal;
    koef                : INTEGER;
    text                : STRING;
  BEGIN
    len:=(Legend.Height- 2*Top)/ChangeLegend.Position;
    dlevel:= (Elements_Result.Max[StressType.ItemIndex+1] - Elements_Result.Min[StressType.ItemIndex+1])/ChangeLegend.Position;
    pos:=0;
    koef:=1 + trunc(30/len);
    while pos < ChangeLegend.Position + 1 - trunc(1/koef) do
    begin
      text:= MyFloatToStr(Elements_Result.Min[StressType.ItemIndex+1]+dlevel*pos);
      Canvas.TextOut(left,Legend.Height - 2*Top + 5 - trunc(len*pos),text);
      pos := pos + koef;
    end;
    text:= MyFloatToStr(Elements_Result.Max[StressType.ItemIndex+1]);
    Canvas.TextOut(left,Legend.Height - 2*Top + 5 - trunc(len*ChangeLegend.Position),text);

    exit;
    IF Elements_Result.Max[StressType.ItemIndex+1]>0 THEN BEGIN
      IF Elements_Result.Min[StressType.ItemIndex+1]>0 THEN BEGIN
        Long:=Elements_Result.Max[StressType.ItemIndex+1];
        k:=MyDiv((Legend.Height-2*Top),Long);
        pos:=ROUND((Elements_Result.Max[StressType.ItemIndex+1]-Elements_Result.Min[StressType.ItemIndex+1])*k);
        Canvas.TextOut(Left,Top-5,MyFloatToStr(Elements_Result.Max[StressType.ItemIndex+1]));
        Canvas.TextOut(Left,Legend.Height-Top-5,'0');
        Canvas.TextOut(Left,Top+pos-5,MyFloatToStr(Elements_Result.Min[StressType.ItemIndex+1]));
        dop:=(Legend.Height-10) div 2; //��������� �������� ��� ������
        dopp:=(Elements_Result.Max[StressType.ItemIndex+1]+Elements_Result.Min[StressType.ItemIndex+1])/2;//������� ��������
        dopSt:=MyFloatToStr(dopp);// ����������� � ������
        {dopSt:=CutStr(dopSt);}
        Canvas.TextOut(Left,dop,dopSt);// ����� �� �����
        dop1:=dop-(dop div 2);
        dop2:= dop+(dop div 2);
        dopp1:=dopp+dopp/2;
        dopp2:=dopp-dopp/2;
        dopSt1:=MyFloatToStr(dopp1);
        {dopSt1:=CutStr(dopSt1);}
        dopSt2:=MyFloatToStr(dopp2);
        {dopSt2:=CutStr(dopSt2);}
        Canvas.TextOut(Left,dop1,dopSt1);
        Canvas.TextOut(Left,dop2,dopSt2);
      END
      ELSE BEGIN
        Long:=Elements_Result.Max[StressType.ItemIndex+1]-Elements_Result.Min[StressType.ItemIndex+1];
        k:=MyDiv((Legend.Height-2*Top),Long);
        pos:=ROUND((Elements_Result.Max[StressType.ItemIndex+1])*k);
        Canvas.TextOut(Left,Top-5,MyFloatToStr(Elements_Result.Max[StressType.ItemIndex+1]));
        Canvas.TextOut(Left,Legend.Height-Top-5,MyFloatToStr(Elements_Result.Min[StressType.ItemIndex+1]));
        dop:=(Legend.Height-10) div 2; //��������� �������� ��� ������
        dopp:=(Elements_Result.Max[StressType.ItemIndex+1]+Elements_Result.Min[StressType.ItemIndex+1])/2;//������� ��������
        dopSt:=MyFloatToStr(dopp);// ����������� � ������
        {dopSt:=CutStr(dopSt);}
        Canvas.TextOut(Left,dop,dopSt);// ����� �� �����
        dop1:= dop-(dop div 2);
        dop2:= dop+(dop div 2);
        dopp1:=dopp+dopp/2;
        dopp2:=dopp-dopp/2;
        dopSt1:=MyFloatToStr(dopp1);
        {dopSt1:=CutStr(dopSt1);}
        dopSt2:=MyFloatToStr(dopp2);
        {dopSt2:=CutStr(dopSt2);}
        Canvas.TextOut(Left,dop1,dopSt1);
        Canvas.TextOut(Left,dop2,dopSt2);
      END;
    END
    ELSE BEGIN
      Long:=-Elements_Result.Min[StressType.ItemIndex+1];
      k:=MyDiv((Legend.Height-2*Top),Long);
      pos:=ROUND((-Elements_Result.Max[StressType.ItemIndex+1])*k);
      Canvas.TextOut(Left,Top-5,'0');
      Canvas.TextOut(Left,Legend.Height-Top-5,MyFloatToStr(Elements_Result.Min[StressType.ItemIndex+1]));
      Canvas.TextOut(Left,Top+pos-5,MyFloatToStr(Elements_Result.Max[StressType.ItemIndex+1]));
      dop:=(Legend.Height-10) div 2; //��������� �������� ��� ������
      dopp:=(Elements_Result.Max[StressType.ItemIndex+1]+Elements_Result.Min[StressType.ItemIndex+1])/2;//������� ��������
      dopSt:=MyFloatToStr(dopp);// ����������� � ������
      {dopSt:=CutStr(dopSt);}
      Canvas.TextOut(Left,dop,dopSt);// ����� �� �����
      dop1:=dop-(dop div 2);
      dop2:=dop+(dop div 2);
      dopp1:=dopp+dopp/2;
      dopp2:=dopp-dopp/2;
      dopSt1:=MyFloatToStr(dopp1);
      dopSt2:=MyFloatToStr(dopp2);
      {dopSt1:=CutStr(dopSt1);}
      {dopSt2:=CutStr(dopSt2);}
      Canvas.TextOut(Left,dop1,dopSt1);
      Canvas.TextOut(Left,dop2,dopSt2);
    END;
  END;

  PROCEDURE ShowLegendHintsNew(Canvas:TCanvas;Left,Top:INTEGER);
  VAR
    long,k              : MyReal;
    pos                 : INTEGER;
    dop,dop1,dop2       : INTEGER; //dop - ��� ��������, 1dop - ����� max � dop, 2dop - ����� dop � min
    dopp,dopp1,dopp2    : MyReal;
    dopSt,dopSt1,dopSt2 : STRING;
    len,dlevel          : MyReal;
    koef                : INTEGER;
    text,st             : STRING;
    z : integer;
  BEGIN
    z := ChangeLegend.Position;
    if (UseLines.Checked = true) and (CheckBox1.Checked = true) then z := 4;
    len:=(Legend.Height- 2*Top)/z;
    for pos := 0 to z do
    begin
    //st := 'L ' + IntToStr(pos);
    //ShowMessage(st);
    if pos >= level_zero then
    begin
        text:= MyFloatToStr((pos-level_zero) * level_plus);
    end
    else
    begin
        text:= MyFloatToStr(Elements_Result.Min[StressType.ItemIndex+1]+(pos * level_minus));
    end;
        if (UseLines.Checked = true) and (CheckBox1.Checked = true) then
        begin
                if (pos = 0) then begin
                text := MyFloatToStr(Elements_Result.Min[StressType.ItemIndex+1]);
                if -abs(Spin_0_min.Value) <= Elements_Result.min[StressType.ItemIndex+1] then
                text:= MyFloatToStr(-abs(Spin_0_min.Value) - 100);
                end;
                if (pos = 1) then text := '-' + MyFloatToStr(abs(Spin_0_min.Value));
                if (pos = 2) then text := '0';
                if (pos = 3) then text := MyFloatToStr(abs(Spin_0_max.Value));
        end;
    Canvas.TextOut(left,Legend.Height - 2*Top + 5 - trunc(len*pos),text);

    end;
    if Elements_Result.Max[StressType.ItemIndex+1] >= 0 then
    text:= MyFloatToStr(Elements_Result.Max[StressType.ItemIndex+1])
    else
    text:= '0,00';
    if (UseLines.Checked = true) and (CheckBox1.Checked = true) and
     (abs(Spin_0_max.Value) >= Elements_Result.Max[StressType.ItemIndex+1]) then
        text:= MyFloatToStr(abs(Spin_0_max.Value) + 100);
    Canvas.TextOut(left,Legend.Height - 2*Top + 5 - trunc(len*z),text);
  END;

  PROCEDURE ShowLegend(Canvas:TCanvas;Left,Top,Width:INTEGER;Step:MyReal);
  VAR
    i,k  : WORD;
    Rect : TRect;
    z : integer;
  BEGIN
    Canvas.Brush.Color:=BackGR;
    Canvas.FillRect(Canvas.ClipRect);
    Rect.Left:=Left;
    Rect.Right:=Left+Width;
    Canvas.Pen.Color:=clBlack;
    z := ChangeLegend.Position;
    if (UseLines.Checked = true) and (CheckBox1.Checked = true) then z := 4;
    FOR i:=0 TO z-1 DO BEGIN
      k:=z-1-i;
      if LinesShow = true then
        //if CheckBox1.Checked = false then
        Canvas.Brush.Color:=GenerateColor(i)
        //else
        //Canvas.Brush.Color:=GenerateColor1(i)
      else
        Canvas.Brush.Color:=GenerateColorOld(i);
      Rect.Top:=Top+trunc(Step*k);
      Rect.Bottom:=1+Top+trunc(Step*(k+1));
      Canvas.FillRect(Rect);
      Canvas.Brush.Color:=clBlack;
      Canvas.FrameRect(Rect);
    END;
    Canvas.Brush.Color:=BackGR;
        if UseLines.Checked = true then
                ShowLegendHintsNew(Canvas,Rect.Right,Top)
        else
                ShowLegendHints(Canvas,Rect.Right,Top);
  END;

VAR
  Bitmap : TBitMap;
  z : integer;
BEGIN
  TRY
    IF UseBuffer.Checked THEN BEGIN
      Bitmap:=TBitmap.Create;
      Bitmap.Width:=Legend.Width;
      Bitmap.Height:=Legend.Height;
    END;
    z := ChangeLegend.Position;
    if (UseLines.Checked = true) and (CheckBox1.Checked = true) then z := 4;

    IF UseBuffer.Checked THEN BEGIN
      ShowLegend(BitMap.Canvas,paintdx,paintdy,20,(Legend.Height-paintdy*2)/z);
      Legend.Canvas.Draw(0,0,BitMap);
    END
    ELSE ShowLegend(Legend.Canvas,paintdx,paintdy,20,(Legend.Height-paintdy*2)/z);
  FINALLY
    IF UseBuffer.Checked THEN Bitmap.Free;
  END;
END;


PROCEDURE TShowMovingsForm.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: INTEGER);
BEGIN
  IF MousePushed THEN BEGIN
    IF ActiveToolButton=MoveAction THEN BEGIN
      OffsetX:=SOffsetX+(Xpaint2Xreal(X)-Xpaint2Xreal(DownX));
      OffsetY:=SOffsetY+(Ypaint2Yreal(Y)-Ypaint2Yreal(DownY));
      MainRePaint;
    END
    ELSE IF ActiveToolButton=ZoomAreaAction THEN BEGIN
      MainRePaint;
      PaintBox1.Canvas.Brush.Style:=bsClear;
      PaintBox1.Canvas.Pen.Style:=psDash;
      PaintBox1.Canvas.Rectangle(X+cursorcrosdx,Y+cursorcrosdx,DownX+cursorcrosdx,DownY+cursorcrosdx);
    END;
  END;
  IF ActiveToolButton=DefaultAction THEN BEGIN
    MouseX:=Xpaint2Xreal(x);
    MouseY:=Ypaint2Yreal(y);
    StatusBar1.Panels[0].Text:=MyFloatToStr(MouseX);
    StatusBar1.Panels[1].Text:=MyFloatToStr(MouseY);
    IF MousePushed THEN PaintBox1Click;
  END;
END;


PROCEDURE TShowMovingsForm.MoverChange(Sender: TObject);
BEGIN
  ChangeDrawSize;
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.ShowForm;
BEGIN
  LoadResults(ResFile);
  FigureX:=(Nodes_Result.Area.maxx-Nodes_Result.Area.minx)/2;
  FigureY:=(Nodes_Result.Area.maxy-Nodes_Result.Area.miny)/2;
  IF Error<>0 THEN BEGIN
    ShowMessage('���� ��������� �������� ������: '+ Error_Text[Error]); //imametdinov
    exit;
  END
  ELSE BEGIN
    SetDiapazon;
    Show;
    ChangeLegend.Position:=50;
    //BestFitActionClick(nil);
  END;
END;


PROCEDURE TShowMovingsForm.FormClose(Sender: TObject; VAR Action: TCloseAction);
BEGIN
  SaveForm('ShowGrafical');
  Action:=caFree;
  ShowMovingsForm:=nil;
  // ����������� ���������� ��� ���������� � ������
  bmpPic.Free;
  CheckState;
END;


PROCEDURE TShowMovingsForm.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
BEGIN
  DownX:=X;
  DownY:=Y;
  IF MoveAction.Down THEN BEGIN
    SOffsetX:=OffsetX;
    SOffsetY:=OffsetY;
    Screen.Cursor:= HandAct;
  END;
  IF ActiveToolButton=DefaultAction THEN PaintBox1Click;
  MousePushed:=TRUE;
END;


PROCEDURE TShowMovingsForm.ZoomAreaRect(x1,y1,x2,y2:MyReal);
VAR
  x,y : MyReal;

BEGIN
  IF x1>x2 THEN BEGIN
    x:=x2;
    x2:=x1;
    x1:=x;
  END;
  IF y1>y2 THEN BEGIN
    y:=y2;
    y2:=y1;
    y1:=y;
  END;
  OffsetX:=FigureX-x1-(x2-x1)/2;
  OffsetY:=FigureY-y1-(y2-y1)/2;
  x:=MyDiv((CenterX*2-2*paintdx),(x2-x1)*CM);
  y:=MyDiv((CenterY*2-2*paintdy),(y2-y1)*CM);
  IF x>y THEN Scale:=y ELSE Scale:=x;
  SetScale;
END;


// ��������� ������ ����� ��� ��������
PROCEDURE TShowMovingsForm.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
BEGIN
  IF ActiveToolButton=MoveAction THEN BEGIN
    OffsetX:=SOffsetX+(Xpaint2Xreal(X)-Xpaint2Xreal(DownX));
    OffsetY:=SOffsetY+(Ypaint2Yreal(Y)-Ypaint2Yreal(DownY));
    Screen.Cursor:= crDefault;
  END
  ELSE IF ActiveToolButton=ZoomAreaAction THEN BEGIN
    IF (ABS(X-DownX)>5) AND (ABS(Y-DownY)>5) THEN ZoomAreaRect(Xpaint2Xreal(X+cursorcrosdx), Ypaint2Yreal(Y+cursorcrosdx), Xpaint2Xreal(DownX+cursorcrosdx), Ypaint2Yreal(DownY+cursorcrosdx));
  END
  ELSE IF (ActiveToolButton=ZoomInAction) OR (ActiveToolButton=ZoomOutAction) THEN BEGIN
    OffsetX:=OffsetX+(Xpaint2Xreal(CenterX)-Xpaint2Xreal(X+11));
    OffsetY:=OffsetY+(Ypaint2Yreal(CenterY)-Ypaint2Yreal(Y+11));
    IF (ActiveToolButton=ZoomInAction) THEN TrackBar1.Position:=TrackBar1.Position+1
    ELSE TrackBar1.Position:=TrackBar1.Position-1;
  END;
  IF ActiveToolButton<>DefaultAction THEN MainRePaint;
  MousePushed:=FALSE;
END;


// ���������� �������� ��� ��������
PROCEDURE TShowMovingsForm.ChangeActionClick(Sender: TObject);

  PROCEDURE ChangeAction(Sender: TToolButton);
  BEGIN
    ActiveToolButton.Down:=FALSE;
    Sender.Down:=TRUE;
    ActiveToolButton:=Sender;
  END;

BEGIN
  ChangeAction(Sender as TToolButton);
  // ����������� �������(���������)
  IF ActiveToolButton=MoveAction THEN PaintBox1.Cursor:= HandPas
  // �����������
  ELSE IF ActiveToolButton=ZoomInAction THEN PaintBox1.Cursor:=ZoomIn
  // ���������
  ELSE IF ActiveToolButton=ZoomOutAction THEN PaintBox1.Cursor:=ZoomOut
  // ����������� �����������
  ELSE IF ActiveToolButton=ZoomAreaAction THEN PaintBox1.Cursor:=ZoomArea
  // ���������� ������
  ELSE IF ActiveToolButton=DefaultAction THEN PaintBox1.Cursor:= crDefault;
END;


// ���������� ������� ���������
PROCEDURE TShowMovingsForm.BestFitActionClick(Sender: TObject);
BEGIN
  ZoomAreaRect(Nodes_Result.Area.minx,Nodes_Result.Area.miny,Nodes_Result.Area.maxx,Nodes_Result.Area.maxy);
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.ChangeColorClick(Sender: TObject);
BEGIN
  ColorDialog1.Color:=(Sender as TPanel).Color;
  IF ColorDialog1.Execute THEN BEGIN
    (Sender as TPanel).Color := ColorDialog1.Color;
    MainRePaint;
    LegendPaint(nil);
  END;
END;

//plus
{PROCEDURE TShowMovingsForm.ChangeColorPlus(Sender: TObject);
BEGIN
  ColorDialog1.Color:=ColorPlus.Color;
  IF ColorDialog1.Execute THEN BEGIN
    ColorPlus.Color := ColorDialog1.Color;
    if LinesShow = true then
      LinesCPlus:=ColorPlus.Color
    else
      CPlus:=ColorPlus.Color;
    MainRePaint;
    LegendPaint(nil);
  END;
END;

//minus
PROCEDURE TShowMovingsForm.ChangeColorMinus(Sender: TObject);
BEGIN
  ColorDialog1.Color:=(Sender as TPanel).Color;
  IF ColorDialog1.Execute THEN BEGIN
    (Sender as TPanel).Color := ColorDialog1.Color;
    if LinesShow = true then
      LinesCMinus:=ColorMinus.Color
    else
      CMinus:=ColorMinus.Color;
    MainRePaint;
    LegendPaint(nil);
  END;

END; }

PROCEDURE TShowMovingsForm.EditMoverChange(Sender: TObject);
VAR
  value : MyReal;

BEGIN
  value:=1;
  IF CheckReal(EditMover.text,value) THEN BEGIN
    IF (Value<=0) THEN BEGIN
      EditMover.text:='1';
      Value:=1;
    END;
    MoverK:=Value;
    MoverChange(nil);
  END;
END;


PROCEDURE TShowMovingsForm.EditForceChange(Sender: TObject);
VAR
  value : WORD;
  x     : MyReal;

BEGIN
  value:=1;
  IF CheckWord(EditForce.text,value) THEN BEGIN
    IF value>0 THEN BEGIN
      x:=ForceTrackBar.Position/ForceTrackBar.Max;
      ForceTrackBar.Max:=2*value+1;
      ForceTrackBar.Position:=ROUND(x*ForceTrackBar.Max);
    END
    ELSE EditForce.Text:='1';
  END;
END;


PROCEDURE TShowMovingsForm.PlusMClick(Sender: TObject);
BEGIN
  ChangeColorClick(ColorPlus);
END;


PROCEDURE TShowMovingsForm.MinusMClick(Sender: TObject);
BEGIN
  ChangeColorClick(ColorMinus);
END;


PROCEDURE TShowMovingsForm.ZeroMClick(Sender: TObject);
BEGIN
  ChangeColorClick(ColorZero);
END;


PROCEDURE TShowMovingsForm.BkgrMClick(Sender: TObject);
BEGIN
  ColorDialog1.Color:=BackGR;
  IF ColorDialog1.Execute THEN BEGIN
    BackGR := ColorDialog1.Color;
    LegendPanel.Color:=BackGR;
    Panel2.Color:=BackGR;
    MainRePaint;
    LegendPaint(nil);
  END;
END;


PROCEDURE TShowMovingsForm.ForceMClick(Sender: TObject);
BEGIN
  ColorDialog1.Color:=Force;
  IF ColorDialog1.Execute THEN BEGIN
    Force := ColorDialog1.Color;
    MainRePaint;
  END;
END;


PROCEDURE TShowMovingsForm.UpDown1ChangingEx(Sender: TObject; VAR AllowChange:BOOLEAN; NewValue:SMALLINT; Direction:TUpDownDirection);
CONST
  Step=0.1;

BEGIN
  IF Direction=updDown THEN ForceK:=ForceK-Step;
  IF Direction=updUP THEN ForceK:=ForceK+Step;
  EditForce.Text:=MyFloatToStr(ForceK);
  AllowChange:=FALSE;
END;


PROCEDURE TShowMovingsForm.EditXChange(Sender: TObject);
VAR
  value : MyReal;

BEGIN
  IF Updating THEN EXIT;
  value:=1;
  IF CheckReal((Sender as TEdit).text,value) THEN BEGIN
    IF Sender = EditX THEN X:=Value;
    IF Sender = EditY THEN Y:=Value;
    SolveInPoint;
    PaintBox1.Repaint;
  END;
END;

function MyFloatToStr_2(X:MyReal):String;
begin
     Result:=FormatFloat('0.0000E+00',X);
end;

// ����� ��������� � ������
FUNCTION TShowMovingsForm.SolveInPoint : Boolean;
VAR
  st,move_st:TStressArray;
  Element : Integer;
  OneElement : TOneElement;
BEGIN
//------
  IF StressInPointType(X,Y,st,StressMethod) and MoveInPoint(X,Y, move_st) THEN BEGIN
{    InfoX.text:=cutStr(MyFloatToStr(st[1]));
    InfoY.text:=cutStr(MyFloatToStr(st[2]));
    InfoXY.text:=cutStr(MyFloatToStr(st[3]));
    InfoMax.text:=cutStr(MyFloatToStr(st[4]));
    InfoMin.text:=cutStr(MyFloatToStr(st[5]));
    InfoConer.text:=cutStr(MyFloatToStr(st[6]));}

    Element := 1 + Elements_Result.FindElementByPoint(X,Y,Mover.Position*MoverK);
    InfoFiniteElementNumber.text:= IntToStr(Element);
    InfoX.text:=MyFloatToStr(st[1]);
    InfoY.text:=MyFloatToStr(st[2]);
    InfoXY.text:=MyFloatToStr(st[3]);
    InfoMax.text:=MyFloatToStr(st[4]);
    InfoMin.text:=MyFloatToStr(st[5]);
    InfoConer.text:=MyFloatToStr(st[7]);
    InfoEcv.text:=MyFloatToStr(st[6]);

    InfoMoveX.text:=MyFloatToStr_2(move_st[1]);
    InfoMoveY.text:=MyFloatToStr_2(move_st[2]);
    // ���������� ��-�� ��
    OneElement:=Elements_Result.GetElement(Element);
    KENumber.Text  := IntToStr(Element);
    MUprug.Text    := MyFloatToStr(Materials[OneElement.Material].E);
    KoefPuas.Text  := MyFloatToStr(Materials[OneElement.Material].Mu);
    DopNapr.Text   := MyFloatToStr(Materials[OneElement.Material].Sg);
    Thickness.Text := MyFloatToStr(Materials[OneElement.Material].Thickness);

    DrawSelectedPoint := True;
    Result := True;
    ShowSelectedPoint(Canvas);
  END
  ELSE BEGIN
    DrawSelectedPoint := False;
    InfoFiniteElementNumber.text:='';
    InfoX.text:='';
    InfoY.text:='';
    InfoXY.text:='';
    InfoMax.text:='';
    InfoMin.text:='';
    InfoConer.text:='';
    InfoEcv.text:='';
    // ���������� ��-�� ��
    KENumber.Text  := '';
    MUprug.Text    := '';
    KoefPuas.Text  := '';
    DopNapr.Text   := '';
    Thickness.Text := '';
    Result := False;
  END;
END;

//��������� ���������� � �����
FUNCTION TShowMovingsForm.StressInPoint(X,Y:MyReal;VAR st:TStressArray):BOOLEAN;
VAR
  Element    : INTEGER;
  OneElement : TOneElement;
  Count      : ARRAY [1..3] OF BYTE;
  K          : ARRAY [1..3] OF MyReal;
  Node       : ARRAY [1..3] OF TOneNode;
  Strain     : ARRAY [1..3,1..6] OF MyReal;
  RX,RY      : MyReal;
  i,j        : BYTE;

BEGIN
  Result:=FALSE;
  // ����������, ������ �� ����������� �����.
  Element:=Elements_Result.FindElementByPoint(X,Y,Mover.Position*MoverK);
  IF Element=-1 THEN EXIT;
  // ���������� ���������� �����, ������� �������� ��.
  OneElement:=Elements_Result.GetElement(Element+1);
  Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
  Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);
  FOR i:=1 TO 3 DO BEGIN
    FOR j:=1 TO 6 DO Strain[i,j]:=0;
    Count[i]:=0;
  END;
  IF NOT Elements_Result.SetFirstElement THEN EXIT;
  // ���������� ����� ���������� � ������ �� 3-� �����.
  REPEAT
    OneElement:=Elements_Result.GetCurrentElement;
    FOR i:=1 TO 3 DO BEGIN
      IF (OneElement.Node1=Node[i].Number) OR (OneElement.Node2=Node[i].Number) OR (OneElement.Node3=Node[i].Number) THEN BEGIN
        FOR j:=1 TO 6 DO Strain[i,j]:=Strain[i,j]+OneElement.Strain[j];
        INC(Count[i]);
      END;
    END;
  UNTIL NOT Elements_Result.SetNextElement;
  // ��� ������� �� 6-� ����� ����������
  FOR j:=1 TO 6 DO BEGIN
    // ���������� ������� ���������� � ������ �� 3-� �����.
    FOR i:=1 TO 3 DO Strain[i,j]:=MyDiv(Strain[i,j], Count[i]);
    // ���������� ����� ���������������� ��������� � 3-� �����.
    RX:=MyDiv(Node[1].X*Strain[1,j]+Node[2].X*Strain[2,j]+Node[3].X*Strain[3,j], Strain[1,j]+Strain[2,j]+Strain[3,j]);
    RY:=MyDiv(Node[1].Y*Strain[1,j]+Node[2].Y*Strain[2,j]+Node[3].Y*Strain[3,j], Strain[1,j]+Strain[2,j]+Strain[3,j]);
    // ��� ������ �� 3-� ������ ���������� ����������� �� ������� �� ���������� � �����.
    FOR i:=1 TO 3 DO K[i]:=MyDiv(SQRT(SQR(RX-Node[i].X)+SQR(RY-Node[i].Y)), SQRT(SQR(X-Node[i].X)+SQR(Y-Node[i].Y)));
    // ���������� ���������� � �����.
    st[j]:=MyDiv(Strain[1,j]*K[1]+Strain[2,j]*K[2]+Strain[3,j]*K[3], K[1]+K[2]+K[3]);
  END;
  Result:=TRUE;
END;

// ����� ����������� ���������� - ����������
//��� 1 ���
//    2 ��
//    3 ��
FUNCTION TShowMovingsForm.StressInPointType(X,Y:MyReal;VAR st:TStressArray; Typ:Integer):BOOLEAN;
VAR
  Element    : INTEGER;
  OneElement : TOneElement;
  Count      : ARRAY [1..3] OF BYTE;
  K          : ARRAY [1..3] OF MyReal;
  Node       : ARRAY [1..3] OF TOneNode;
  Strain     : ARRAY [1..3,1..7] OF MyReal;
  RX,RY      : MyReal;
  i,j        : BYTE;

BEGIN
CASE Typ of
//���
1:Begin
  Result:=FALSE;
  // ����������, ������ �� ����������� �����.
  Element:=Elements_Result.FindElementByPoint(X,Y,Mover.Position*MoverK);
  IF Element=-1 THEN EXIT;
  // ���������� ���������� �����, ������� �������� ��.
  OneElement:=Elements_Result.GetElement(Element+1);
  Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
  Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);
  FOR i:=1 TO 3 DO BEGIN
    FOR j:=1 TO 7 DO Strain[i,j]:=0;
    Count[i]:=0;
  END;
  IF NOT Elements_Result.SetFirstElement THEN EXIT;
  // ���������� ����� ���������� � ������ �� 3-� �����.
  REPEAT
    OneElement:=Elements_Result.GetCurrentElement;
    FOR i:=1 TO 3 DO BEGIN
      IF (OneElement.Node1=Node[i].Number) OR (OneElement.Node2=Node[i].Number) OR (OneElement.Node3=Node[i].Number) THEN BEGIN
        FOR j:=1 TO 7 DO Strain[i,j]:=Strain[i,j]+OneElement.Strain[j];
        INC(Count[i]);
      END;
    END;
  UNTIL NOT Elements_Result.SetNextElement;
  // ��� ������� �� 6-� ����� ����������
  FOR j:=1 TO 7 DO BEGIN
    // ���������� ������� ���������� � ������ �� 3-� �����.
    FOR i:=1 TO 3 DO Strain[i,j]:=MyDiv(Strain[i,j], Count[i]);
    // ���������� ����� ���������������� ��������� � 3-� �����.
    RX:=MyDiv(Node[1].X*Strain[1,j]+Node[2].X*Strain[2,j]+Node[3].X*Strain[3,j], Strain[1,j]+Strain[2,j]+Strain[3,j]);
    RY:=MyDiv(Node[1].Y*Strain[1,j]+Node[2].Y*Strain[2,j]+Node[3].Y*Strain[3,j], Strain[1,j]+Strain[2,j]+Strain[3,j]);
    // ��� ������ �� 3-� ������ ���������� ����������� �� ������� �� ���������� � �����.
    FOR i:=1 TO 3 DO K[i]:=MyDiv(SQRT(SQR(RX-Node[i].X)+SQR(RY-Node[i].Y)), SQRT(SQR(X-Node[i].X)+SQR(Y-Node[i].Y)));
    // ���������� ���������� � �����.
    st[j]:=MyDiv(Strain[1,j]*K[1]+Strain[2,j]*K[2]+Strain[3,j]*K[3], K[1]+K[2]+K[3]);
  END;
  Result:=TRUE;
  End;
2:Begin
  Result:=FALSE;
  // ����������, ������ �� ����������� �����.
  Element:=Elements_Result.FindElementByPoint(X,Y,Mover.Position*MoverK);
  IF Element=-1 THEN EXIT;
  // ���������� ���������� �����, ������� �������� ��.
  OneElement:=Elements_Result.GetElement(Element+1);
  Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
  Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);
  FOR i:=1 TO 3 DO BEGIN
    FOR j:=1 TO 7 DO Strain[i,j]:=0;
    Count[i]:=0;
  END;
  IF NOT Elements_Result.SetFirstElement THEN EXIT;
  // ���������� ����� ���������� � ������ �� 3-� �����.
  REPEAT
    OneElement:=Elements_Result.GetCurrentElement;
    FOR i:=1 TO 3 DO BEGIN
      IF (OneElement.Node1=Node[i].Number) OR (OneElement.Node2=Node[i].Number) OR (OneElement.Node3=Node[i].Number) THEN BEGIN
        FOR j:=1 TO 7 DO Strain[i,j]:=Strain[i,j]+OneElement.Strain[j];
        INC(Count[i]);
      END;
    END;
  UNTIL NOT Elements_Result.SetNextElement;
  // ���������� ����� ���� ��.
  RX:=(Node[1].X+Node[2].X+Node[3].X)/3;
  RY:=(Node[1].Y+Node[2].Y+Node[3].Y)/3;
  // ��� ������� �� 7-� ����� ����������
  FOR j:=1 TO 7 DO BEGIN
    // ���������� ������� ���������� � ������ �� 3-� �����.
    FOR i:=1 TO 3 DO Strain[i,j]:=MyDiv(Strain[i,j], Count[i]);
    // ��� ������ �� 3-� ������ ���������� ����������� �� ������� �� ���������� � �����.
    FOR i:=1 TO 3 DO K[i]:=MyDiv(SQRT(SQR(RX-Node[i].X)+SQR(RY-Node[i].Y)), SQRT(SQR(X-Node[i].X)+SQR(Y-Node[i].Y)));
    // ���������� ���������� � �����.
    st[j]:=MyDiv(Strain[1,j]*K[1]+Strain[2,j]*K[2]+Strain[3,j]*K[3], K[1]+K[2]+K[3]);
  END;
  Result:=TRUE;
  End;
3:Begin
  Result:=FALSE;
  Element:=Elements_Result.FindElementByPoint(X,Y,Mover.Position*MoverK);
  IF Element=-1 THEN EXIT;
  OneElement:=Elements_Result.GetElement(Element+1);
  FOR i:=1 TO 7 DO st[i]:=OneElement.Strain[i];
  Result:=TRUE;
  End;

END;
END;


PROCEDURE TShowMovingsForm.PaintBox1Click;
BEGIN
  Updating:=TRUE;
  X:=MouseX;
  Y:=MouseY;
{  EditX.Text:=cutStr(MyFloatToStr(X));
  EditY.Text:=cutStr(MyFloatToStr(Y));}
  EditX.Text:=MyFloatToStr(X);
  EditY.Text:=MyFloatToStr(Y);
  EditMoveX.Text:=MyFloatToStr(X);
  EditMoveY.Text:=MyFloatToStr(Y);
  // Repaint to show the selected point on the canvas
  IF( SolveInPoint ) then
    PaintBox1.Repaint;
  Updating:=FALSE;
END;


PROCEDURE TShowMovingsForm.ForceTrackBarChange(Sender: TObject);
VAR
  pos,Half : MyReal;

BEGIN
  Half:=(ForceTrackBar.Max-1)/2;
  pos:=ForceTrackBar.Position-Half;
  IF pos>=1 THEN ForceK:=pos ELSE ForceK:=1/(2-pos);
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.UseAxesClick(Sender: TObject);
BEGIN
  if (TestElements.Checked)then UseLines.Checked:=false;
  if (TestElements.Checked)then Checkbox2.Checked:=false;
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.GroupBox6DblClick(Sender: TObject);
VAR
  i,j       : INTEGER;
  x,y       : MyReal;
  w,h       : INTEGER;
  st        : TStressArray;
  stind     : INTEGER;
  findlevel : INTEGER;

BEGIN
  w:=PaintBox1.Width;
  h:=PaintBox1.Height;
  if useaxes.Checked then checkbox2.Checked:=false; //�������� �.�.
  FOR j:=0 TO h-1 DO BEGIN
    FOR i:=0 TO w-1 DO BEGIN
      x:=Xpaint2Xreal(i);
      y:=Ypaint2Yreal(j);
      IF StressInPoint(X,Y,st) THEN BEGIN
        stind:=StressType.ItemIndex+1;
        IF st[stind]=Elements_Result.max[stind] THEN findlevel:=ChangeLegend.Position
        ELSE findlevel:=Trunc(MyDiv(st[stind]+ABS(Elements_Result.min[stind]),Level))+1;
        PaintBox1.Canvas.Pixels[Xreal2Xpaint(X),Yreal2Ypaint(Y)]:=GenerateColor(findlevel);
      END;
    END;
  END;
END;


// ���������� ����������� ������ �����������
PROCEDURE TShowMovingsForm.SpeedButton2Click(Sender: TObject);
BEGIN
  IF SavePicDlg.Execute THEN bmpPic.SaveToFile(SavePicDlg.FileName);
END;


// ���������� ����������� ����� ����
PROCEDURE TShowMovingsForm.SpeedButton3Click(Sender: TObject);
BEGIN
  IF SavePicDlg.Execute THEN GetFormImage.SaveToFile(SavePicDlg.FileName);
END;


PROCEDURE TShowMovingsForm.SpeedButton4Click(Sender: TObject);
BEGIN
  print;
END;

Procedure TShowMovingsForm.StressMethodSave(Method: Integer);
VAR
  Registry:TRegistry;
Begin
     Registry:=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg+'\ShowGrafical\',true) then
        begin
             Registry.WriteInteger('StressMethod',Method);
        end;
     Registry.CloseKey;
     Registry.Free;
End;

Function TShowMovingsForm.StressMethodLoad(Method: Integer):Integer;
VAR
  Registry:TRegistry;
  Ret:     Integer;
Begin
     Registry:=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg+'\ShowGrafical\',true) then
        begin
             Ret:=Registry.ReadInteger('StressMethod');
             Registry.CloseKey;
             Registry.Free;
        end
     else
        begin
             Ret:=Method;
        end;
     Result:=Ret;
End;

procedure TShowMovingsForm.StressMethod1Click(Sender: TObject);
begin
  StressMethod := 1;
  StressMethodSave(1);
  SolveInPoint;
end;

procedure TShowMovingsForm.StressMethod2Click(Sender: TObject);
begin
  StressMethod := 2;
  StressMethodSave(2);
  SolveInPoint;
end;

procedure TShowMovingsForm.StressMethod3Click(Sender: TObject);
begin
  StressMethod := 3;
  StressMethodSave(3);
  SolveInPoint;
end;

function TShowMovingsForm.MoveInPoint(X,Y:MyReal;var move_st:TStressArray):boolean;
//  2003  ����������� � �����.
Var
     Element    : integer;
     OneElement : TOneElement;
     Node       : array [1..3] of TOneNode;
      x1,  x2,  x3,
      y1,  y2,  y3,
     dx1, dy1, dx2,       
     dy2, dx3, dy3,
      d1,  d2,  d3,
    p12x,p23x,p31x,
    p12y,p23y,p31y,
          TX,TY        : MyReal;
     XX,YY,DXx,DYy,dd,stri : string;
begin
     Element:=Elements_Result.FindElementByPoint(X,Y,Mover.Position*MoverK);
     If Element<>-1 Then
       Begin
          OneElement:=Elements_Result.GetElement(Element+1);     //������ �������
          Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
          Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
          Node[3]:=Nodes_Result.GetNode(OneElement.Node3);
          x1:=Node[1].x;     // ���������� �����, ���������� �������
          dx1:=Node[1].dx;        // ����������� �����, ���������� �������
          y1:=Node[1].y;
          dy1:=Node[1].dy;
          x2:=Node[2].x;
          dx2:=Node[2].dx;
          y2:=Node[2].y;
          dy2:=Node[2].dy;
          x3:=Node[3].x;
          dx3:=Node[3].dx;
          y3:=Node[3].y;
          dy3:=Node[3].dy;

          IF (abs(X-x1)<0.01) and (abs(Y-y1)<0.01) then
            begin
                TX:=dx1;
                TY:=dy1;
            end
          ELSE IF (abs(X-x2)<0.01) and (abs(Y-y2)<0.01) then
            begin
                TX:=dx2;
                TY:=dy2;
            end
          ELSE IF (abs(X-x3)<0.01) and (abs(Y-y3)<0.01) then
            begin
                TX:=dx3;
                TY:=dy3;
            end
          ELSE
            begin
              d1:=sqrt(sqr(x-x1)+ sqr(y-y1)) ;        //���������� �� ����� �� ����
              d2:=sqrt(sqr(x-x2)+ sqr(y-y2)) ;
              d3:=sqrt(sqr(x-x3)+ sqr(y-y3)) ;
              p12x:=dx1+d1*(dx1-dx2)/(d1+d2);
              p23x:=dx2+d2*(dx2-dx3)/(d2+d3);
              p31x:=dx3+d3*(dx3-dx1)/(d3+d1);
              p12y:=dy1+d1*(dy1-dy2)/(d1+d2);
              p23y:=dy2+d2*(dy2-dy3)/(d2+d3);
              p31y:=dy3+d3*(dy3-dy1)/(d3+d1);
              TX:=(p12x+p23x+p31x)/3;
              TY:=(p12y+p23y+p31y)/3;
            end;

          move_st[1]:=TX;
          move_st[2]:=TY;

          Result:=true;
     end;
end;

procedure TShowMovingsForm.FormShow(Sender: TObject);
VAR
  Registry:TRegistry;

  FUNCTION ReadSTRING(Name:STRING;Def:STRING):STRING;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadSTRING(Name) ELSE Result:=def;
  END;

BEGIN
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  // Group2.SetFocus;
 IF Registry.OpenKeyReadOnly(STRINGReg) THEN FloatFormat:=Registry.ReadSTRING('FloatFormat');
end;

procedure TShowMovingsForm.ToolButton1Click(Sender: TObject);
begin
  //Group1.SetFocus;

end;

procedure TShowMovingsForm.SpeedButton1Click(Sender: TObject);
begin
  if ScrollBox1.Visible = true then ScrollBox1.Visible:=false
  else ScrollBox1.Visible:=true;
end;

procedure TShowMovingsForm.SpeedButton7Click(Sender: TObject);
begin
  // Group1.SetFocus;
end;

procedure TShowMovingsForm.SpeedButton6Click(Sender: TObject);
begin
  //Group2.SetFocus;
end;

procedure TShowMovingsForm.SpeedButton5Click(Sender: TObject);
   var ttt:TPrintService;
begin
             ttt.PrinterSetupDialog;
end;

procedure TShowMovingsForm.Timer1Timer(Sender: TObject);
begin
// ���� ��������� ����� ����������� ���� ������� �����
// "��������� ���������� � ��"
  IF TestElements.Checked THEN   BEGIN
// ������ �������� ����������� ���������� Prd (����  Prd �� ����� 0, ��
// ��������� �� �������� 0, � ���� ����� 0, �� ��������� �������� 1
  If Prd<>0 then Prd:=0
    else Prd:=1 ;
// ������������ ��������
   MainRePaint;
   end;
end;

//  ��������� �������� �� ���������� ����������� ���������� � ��
PROCEDURE TShowMovingsForm.UseTestElements(Canvas:TCanvas);
 VAR
  OneElement   : TOneElement;
  DopStress    : TStress;
  Error        : Integer;
  OneNode      : TOneNode;
  findlevel    : INTEGER;

function GetMaxStress(OneElement   : TOneElement):real;
var
  i:word;
begin
  result:=OneElement.Strain[1];
  for i:=1 to 7 do if Result<OneElement.Strain[i] then Result:=OneElement.Strain[i];
end;

BEGIN
  IF TestElements.Checked THEN   BEGIN
// ��������� ���������� ���������� �� ����� "Data"
   DopStress:=LoadDopStress(Error);
   If Error<>0 Then Showmessage('������ ��� ���������� ����������� ����������');
 WITH Canvas DO BEGIN
    Pen.Color:=clBlack;
    Pen.Style:=psSolid;
    Brush.Color:=BackGR;
    FillRect(ClipRect);
    IF Elements_Result.SetFirstElement THEN BEGIN
 // ���������� ��� ��������
      REPEAT
        OneElement:=Elements_Result.GetCurrentElement;
         IF OneElement.strain[StressType.ItemIndex+1]=Elements_Result.max[StressType.ItemIndex+1] THEN findlevel:=ChangeLegend.Position
             ELSE findlevel:=Trunc(MyDiv((OneElement.strain[StressType.ItemIndex+1]+ABS(Elements_Result.min[StressType.ItemIndex+1])),Level))+1;
        IF Abs(GetMaxStress(OneElement))>DopStress[OneElement.Material] THEN
  // ���� �� ���������� ���������� ������ ����������� ����������, �� �������� �����
          Begin
            Brush.Style:=bsDiagcross;
            if LinesShow then
            begin
              ShowElement(Canvas,OneElement);    //kotov
            end
            else
            begin
                ShowElementOld(Canvas,OneElement);    //kotov
            end
          end
         else begin
  // ����� �������� ����������� �� � �������� ����
             Brush.Style:=bsSolid;
             if LinesShow then begin
                Brush.Color:=GenerateColor(findlevel-1);  //kotov
                ShowElement(Canvas,OneElement);           //kotov
             end
             else
             begin
                Brush.Color:=GenerateColorOld(findlevel-1);  //kotov
                ShowElementOld(Canvas,OneElement);           //kotov
             end
          end;
      UNTIL NOT Elements_Result.SetNextElement;
    END;
  END;
END;
  ShowBoundForce(Canvas);
  ShowAxes(Canvas);
END;

procedure TShowMovingsForm.EditMoveXChange(Sender: TObject);
VAR
  value : MyReal;
begin
IF Updating THEN EXIT;
  value:=1;
  IF CheckReal((Sender as TEdit).text,value) THEN BEGIN
    IF Sender = EditMoveX THEN X:=Value;
    IF Sender = EditMoveY THEN Y:=Value;
    SolveInPoint;
    PaintBox1.Repaint;
  END;
end;

procedure TShowMovingsForm.Spin_0_Exit(Sender: TObject);
begin
        if (Spin_0_max.text = '') then Spin_0_max.Value := 1;
        if (Spin_0_min.text = '') then Spin_0_min.Value := 1;;
end;

procedure TShowMovingsForm.UseNumZoneClick(Sender: TObject);
begin

  if UseNumZone.Checked then UseNumMater.Checked:=false;     //Imametdinov

  MainRePaint;
  
 end;
procedure TShowMovingsForm.UseNumMaterClick(Sender: TObject);
begin

  if UseNumMater.Checked then UseNumZone.Checked:=false;     //Imametdinov
  if UseNumMater.Checked then Checkbox2.Checked:=false;
  MainRePaint;
end;
                         
End.
