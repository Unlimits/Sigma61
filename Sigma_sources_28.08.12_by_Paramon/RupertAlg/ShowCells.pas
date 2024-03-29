{*********************************************************************}
{                                                                     }
{                    ���������� ����������� ��������                  }
{                                                                     }
{                               ������� 609                           }
{                                                                     }
{                         ����� ���� ������� 2008                     }
{                                                                     }
{		                       (����������� ����������� �������)		      }
{*********************************************************************}

UNIT ShowCells;

INTERFACE

USES
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, ResultsArrays, ImgList, ToolWin, Menus,
  Grids, Buttons, printers, ExtDlgs, TSigmaForm, Main;
  {*****  IdGlobal; ******}

CONST
  IniFileName='Sigma32.ini';
  HandAct = 1;
  HandPas = 2;
  ZoomIn = 3;
  Zoomout = 4;
  ZoomArea = 5;
  CM_Inch=2.5428571428571428571428571428571;
  cursorcrosdx=3;

TYPE
  TStressArray = ARRAY [1..7] OF MyReal;
  ElStressArray = ARRAY [1..3] OF MyReal;
  TShowCellsForm = Class(TForm)
    ScrollBox1     : TScrollBox;
    Splitter1      : TSplitter;
    StatusBar1     : TStatusBar;
    LegendPanel    : TPanel;
    Splitter2      : TSplitter;
    Legend         : TPaintBox;
    Panel2         : TPanel;
    ImageList1     : TImageList;
    PaintBox1      : TPaintBox;
    ColorDialog1   : TColorDialog;
    CheckColor     : TPopupMenu;
    PlusM          : TMenuItem;
    MinusM         : TMenuItem;
    ZeroM          : TMenuItem;
    BkgrM          : TMenuItem;
    ForceM         : TMenuItem;
    SavePicDlg     : TSavePictureDialog;
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
    Panel11: TPanel;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    DefaultAction: TToolButton;
    ZoomInAction: TToolButton;
    ZoomOutAction: TToolButton;
    ZoomAreaAction: TToolButton;
    MoveAction: TToolButton;
    BestFitAction: TToolButton;
    Panel3: TPanel;
    RadioCM: TRadioButton;
    RadioMM: TRadioButton;
    RadioDM: TRadioButton;
    RadioM: TRadioButton;
    Panel4: TPanel;
    ColorMinus: TPanel;
    ColorPlus: TPanel;
    ColorZero: TPanel;
    Panel8: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Panel10: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton5: TSpeedButton;
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
    PROCEDURE RadioCMClick(Sender: TObject);
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
    PROCEDURE SpeedButton5Click(Sender: TObject);
    procedure StressMethod1Click(Sender: TObject);
    procedure StressMethod2Click(Sender: TObject);
    procedure StressMethod3Click(Sender: TObject);
    Procedure StressMethodSave(Method: Integer);
    Function  StressMethodLoad(Method: Integer):Integer;
    procedure FormShow(Sender: TObject);
    Procedure LoadDim;
    procedure ToolButton1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

    private
               { Private declarations }
    public
               { Public declarations }
    DrawSelectedPoint: Boolean;
    dx, dy           : MyReal;
    x, y             : MyReal;
    Updating         : BOOLEAN;
    ActiveToolButton : TToolButton;
    ActiveRadio      : TRadioButton;
    MousePushed      : BOOLEAN;
    Force, BackGR    : TColor;
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
    PROCEDURE ShowElementOld(Canvas:TCanvas;OneElement:TOneElement);
    FUNCTION StressInElement(OneElement : TOneElement;VAR stress: ElStressArray):BOOLEAN;
    PROCEDURE ShowArrow(Canvas:TCanvas;x,y,long:INTEGER;Alfa:MyReal);
    PROCEDURE ShowBoundForce(Canvas:TCanvas);
    PROCEDURE ShowText(Canvas:TCanvas;x,y:INTEGER;S:STRING);
    PROCEDURE ChengeLegendLevel;
    FUNCTION GenerateColor(Value:word):TColor;
    FUNCTION GenerateColorOld(Value:word):TColor;
    PROCEDURE ShowForm(ResFile:STRING);
    PROCEDURE SaveForm(Name:STRING);
    PROCEDURE LoadForm(Name:STRING);
    PROCEDURE ZoomAreaRect(x1,y1,x2,y2:MyReal);
    PROCEDURE PaintBox1Click;
    FUNCTION SolveInPoint : Boolean;
    FUNCTION StressInPoint(X,Y:MyReal;VAR st:TStressArray):BOOLEAN;
    FUNCTION StressInPointType(X,Y:MyReal;VAR st:TStressArray; Typ:Integer):BOOLEAN;
    function  MoveInPoint(X,Y:MyReal;var move_st:TStressArray):boolean;
    PROCEDURE UseTestElements(Canvas:TCanvas);    //  ��������� �������� �� ���������� ����������� ���������� � ��
    FUNCTION  HLStoRGB(H,L,S : INTEGER):TColor;
    PROCEDURE RGBtoHLS(Color:TColor;Var H,L,S:INTEGER);
  {*****>}
    function Start:boolean;stdcall;
    Procedure SetDefaultReg(Name : String);
    procedure CheckRegForShowCells;
    function getDimFileName(f:string):string;
   {<*****}
  END;

VAR
  ShowCellsForm : TShowCellsForm;
  bmpPic : TBitMap;
  IMPLEMENTATION
USES Math, MainInterface, Strfunc, IniFiles, Registry, PrnServ, SysSettings;
CONST
  paintdx = 10;
  paintdy = 10;

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

  {*****>}
  StartupInfo  : TStartupInfo;
  Errors       : boolean;
  OldNode      : TOneNode;
  {<*****}
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
PROCEDURE TShowCellsForm.LoadForm(Name:STRING);
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
  IF Registry.OpenKeyReadOnly(Name) THEN BEGIN
    WindowState:=wsNormal;
    Top:=ReadInteger('Top',Top);
    Left:=ReadInteger('Left',Left);
    Width:=ReadInteger('Width',Width);
    Height:=ReadInteger('Height',Height);
    IF ReadBool('Maximized',FALSE) THEN WindowState:=wsMaximized ELSE WindowState:=wsNormal;
    ColorZero.color:=StringToColor(ReadSTRING('ColorZero','clWhite'));
    ColorPlus.Color:=StringToColor(ReadSTRING('ColorPlus','clWhite'));
    ColorMinus.Color:=StringToColor(ReadSTRING('ColorMinus','clWhite'));
    //
    UseLines.Checked:=ReadBool('UseLines',FALSE);

    Force:=StringToColor(ReadSTRING('Force','clBlue'));
    BackGR:=StringToColor(ReadSTRING('BackGROUND','clWhite'));
    EditForce.Text:=IntToStr(ReadInteger('ForceK',5));
    ForceTrackBar.Position:=ReadInteger('ForcePos',ROUND(ForceTrackBar.Max/2));
    EditMover.Text:=FloatToStr(ReadFloat('MoverK',10));
    UseLines.Checked:=ReadBool('UseLines',FALSE);
    UseLegend.Checked:=ReadBool('UseLegend',FALSE);
    UseForce.Checked:=ReadBool('UseForce',FALSE);
    UseBound.Checked:=ReadBool('UseBound',FALSE);
    UseNumNode.Checked:=ReadBool('UseNumNode',FALSE);
    UseNumZone.Checked:=ReadBool('UseNumZone',FALSE);
    UseBuffer.Checked:=ReadBool('UseBuffer',FALSE);
  END;
  IF Registry.OpenKeyReadOnly(PluginReg.SigmaReg) THEN FloatFormat:=Registry.ReadSTRING('FloatFormat');
  IF Registry.OpenKeyReadOnly(PluginReg.ShowFormReg.FullPath) THEN begin
    IF not(ReadBool('ShowMenuRes',False)) then ScrollBox1.Visible:=ReadBool('ShowMenuRes',False);//  ������ ������������ Stress;
  end;
  LegendPanel.Color:=BackGR;
  Panel2.Color:=BackGR;
  Registry.free;
  //
  //if UseLines.Checked = false then
  //begin
  //  ColorPlus.Color:=CPlus;
  //  ColorMinus.Color:=CMinus;
  //end;
END;

function LoadDopStress( var Error:Integer):real;
VAR
  i   : INTEGER;
  s   : string;
  F   : Text;
  DopStress: Real;
  MP  : TMainParams;

BEGIN

Form_Load(Project_GetFormFile);

MP:=GetMainParam;
Error:=0;
Result:=MP.SB;

end;

PROCEDURE TShowCellsForm.SaveForm(Name:STRING);
VAR
  Registry:TRegistry;

BEGIN
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  IF Registry.OpenKey(Name,TRUE) THEN BEGIN
    Registry.WriteBool('Maximized',WindowState=wsMaximized);
    IF WindowState=wsMaximized THEN WindowState:=wsNormal;
    Registry.WriteInteger('Top',Top);
    Registry.WriteInteger('Left',Left);
    Registry.WriteInteger('Width',Width);
    Registry.WriteInteger('Height',Height);
    Registry.WriteString('ColorZero',ColorToSTRING(ColorZero.color));
    Registry.WriteString('ColorPlus',ColorToSTRING(ColorPlus.Color));
    Registry.WriteString('ColorMinus',ColorToSTRING(ColorMinus.Color));
    //
    //Registry.WriteString('LinesColorPlus',ColorToSTRING(LinesCPlus));
    //Registry.WriteString('LinesColorMinus',ColorToSTRING(LinesCMinus));
    Registry.WriteBool('UseLines',UseLines.Checked);

    Registry.WriteString('Force',ColorToSTRING(Force));
    Registry.WriteString('BackGround',ColorToSTRING(BackGR));
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
  IF Registry.OpenKey(PluginReg.SigmaReg,TRUE) THEN Registry.WriteString('FloatFormat',FloatFormat);
  Registry.free;
END;


// Actions
PROCEDURE TShowCellsForm.Scaling;
BEGIN
  IF Scale=0 THEN Scale:=0.1E-17;
  IF Scale>=1 THEN LabelScale.Caption:=MyFloatToStr(Scale)+' : 1'
  ELSE LabelScale.Caption:='1 : '+MyFloatToStr(1/Scale);
  ChangeDrawSize;
END;


PROCEDURE TShowCellsForm.SetDiapazon;
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


PROCEDURE TShowCellsForm.SetScale;
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


PROCEDURE TShowCellsForm.ChangeDrawSize;
BEGIN
  Nodes_Result.UpDateWithMove(Mover.Position*MoverK);
END;


PROCEDURE TShowCellsForm.MainRePaint;
BEGIN
  IF OnlyUpdate THEN exit;
  IF UseBuffer.Checked THEN PaintBox1Paint(Nil) ELSE PaintBox1.Repaint;
END;


PROCEDURE TShowCellsForm.LegendRePaint;
BEGIN
  IF UseBuffer.Checked THEN LegendPaint(Nil) ELSE Legend.Repaint;
END;


PROCEDURE TShowCellsForm.ChengeLegendLevel;
BEGIN
  level:=(Elements_Result.max[StressType.ItemIndex+1]-Elements_Result.min[StressType.ItemIndex+1])/ChangeLegend.Position;
  IF Elements_Result.min[StressType.ItemIndex+1]>=0 THEN NegativeLevels:=0
  ELSE NegativeLevels:=trunc(MyDiv(-Elements_Result.min[StressType.ItemIndex+1],Level));
END;

{*****>}
procedure loadn(path:string);
begin
  Nodes_Result.LoadNodes(Path+'RESULT1.BIN');
  IF Nodes_Result.Error<>0 THEN EXIT;
end;
procedure loade(path:string);
begin
  Elements_Result.LoadElements(Path+'RESULT2.BIN');
  IF Elements_Result.Error<>0 THEN EXIT;
end;
{<*****}

PROCEDURE TShowCellsForm.LoadResults(Path:STRING);
VAR
  i,n       : INTEGER;
  Node      : TOneNode;
  SumX,SumY : MyReal;
BEGIN
  FOR i:=Length(Path) DOWNTO 1 DO
  IF (Path[i]='\') Or (Path[i]=':') THEN BREAK;
  SetLength(Path,i);
{*****>}
    loadn(path); // ���������� ����
    loade(path); // ���������� ��������
// ����:
//  Nodes_Result.LoadNodes(Path+'RESULT1.BIN');
//  IF Nodes_Result.Error<>0 THEN EXIT;
//  Elements_Result.LoadElements(Path+'RESULT2.BIN');
//  IF Elements_Result.Error<>0 THEN EXIT;
{<*****}
  ChengeLegendLevel;
  WITH Nodes_Result, StringGrid1 DO BEGIN
    RowCount:=1;
    Cells[0,0]:='�';
    Cells[1,0]:='X';
    Cells[2,0]:='Y';
    Cells[3,0]:='Force X';
    Cells[4,0]:='Force Y';
    SetFirstElement;
    i:=0;
    SumX:=0;
    SumY:=0;
    REPEAT
      Node:=GetNode(GetCurrentElement);
      IF (Node.ForceX<>0) or (Node.ForceY<>0) THEN BEGIN
        SumX:=SumX+Node.ForceX;
        SumY:=SumY+Node.ForceY;
        inc(i);
        RowCount:=i+1;
        Cells[0,i]:=IntToStr(Node.RenumNum);
        Cells[1,i]:=MyFloatToStr(Node.x);
        Cells[2,i]:=MyFloatToStr(Node.y);
        Cells[3,i]:=MyFloatToStr(Node.ForceX);
        Cells[4,i]:=MyFloatToStr(Node.ForceY);
      END;
    UNTIL NOT SetNextElement;
    i:=RowCount;
    RowCount:=i+1;
    Cells[3,i]:=MyFloatToStr(SumX);
    Cells[4,i]:=MyFloatToStr(SumY);
    Cells[0,i]:='�����';
    FixedRows:=1;
  END;
  Edit2.Text :=MyFloatToStr(SumX);
  Edit3.text :=MyFloatToStr(SumY);
END;

//�������������� ������ �� HLS � RGB
FUNCTION TShowCellsForm.HLStoRGB;
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
PROCEDURE TShowCellsForm.RGBtoHLS;
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
FUNCTION TShowCellsForm.GenerateColor(Value:word):TColor;
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
FUNCTION TShowCellsForm.GenerateColorOld(Value:word):TColor;
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

PROCEDURE TShowCellsForm.ShowArrow;
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


PROCEDURE TShowCellsForm.ShowText;
VAR
  h,w:INTEGER;

BEGIN
  h:=ROUND(Canvas.TextHeight(s)/2);
  w:=ROUND(Canvas.TextWidth(s)/2);
  Canvas.TextOut(x-w,y-h,s);
END;


PROCEDURE TShowCellsForm.ShowBoundForce;
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
PROCEDURE TShowCellsForm.ShowElement(Canvas:TCanvas;OneElement:TOneElement);
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
END;

PROCEDURE TShowCellsForm.ShowElementOld;
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
END;

//�������� �������� ���������� � ����� ��������
FUNCTION TShowCellsForm.StressInElement(OneElement : TOneElement;VAR stress : ElStressArray):BOOLEAN;
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


PROCEDURE TShowCellsForm.ShowAxes;
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

PROCEDURE TShowCellsForm.ShowSelectedPoint;
VAR Xi, Yi : Integer;
BEGIN
      IF ( NOT DrawSelectedPoint ) THEN
        exit;
      Xi := Xreal2Xpaint(X);
      Yi := Yreal2Ypaint(Y);
      WITH Canvas DO BEGIN
{*****}{ ���������� ����������       Canvas.Brush.Color := clPurple;
        //Brush.Style := bsClear;
        Ellipse(Xi - 3, Yi - 3, Xi + 3, Yi + 3);}
{*****} // �� ���������� ��������� ������ ����� �� ��������
       Canvas.Brush.Color := clPurple;
       If ScrollBox1.Visible = false then Brush.Style := bsClear
       else Ellipse(Xi - 3, Yi - 3, Xi + 3, Yi + 3);
{*****}
      END;
END;

//���������� ��� ��������
PROCEDURE TShowCellsForm.ShowElements(Canvas:TCanvas);
VAR
  OneElement : TOneElement;
  my : integer;
  findlevel : integer;

BEGIN
  WITH Canvas DO BEGIN
    Brush.Color:=BackGR;
    FillRect(ClipRect);
    //for my:=63 to 64 do begin
    if LinesShow = true then begin
    for my:=1 to Elements_Result.GetNumElements do begin
        OneElement:=Elements_Result.GetElement(my);
        ShowElement(Canvas,OneElement);
    end;
    end
    else begin
    for my:=1 to Elements_Result.GetNumElements do begin
        OneElement:=Elements_Result.GetElement(my);
        IF OneElement.strain[StressType.ItemIndex+1]=Elements_Result.max[StressType.ItemIndex+1] THEN findlevel:=ChangeLegend.Position
        ELSE findlevel:=Trunc(MyDiv((OneElement.strain[StressType.ItemIndex+1]+ABS(Elements_Result.min[StressType.ItemIndex+1])),Level))+1;
        Brush.Color:=GenerateColorOld(findlevel-1);
        ShowElementOld(Canvas,OneElement);
    end;
    end;
  END;
  If Prd=1 Then UseTestElements(Canvas);
  ShowBoundForce(Canvas);
  ShowAxes(Canvas);
  ShowSelectedPoint(Canvas);
END;

// ������� ��������� ����� ����� � ������������
function TShowCellsForm.getDimFileName(f:string):string;
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

PROCEDURE TShowCellsForm.FormCreate(Sender:TObject);
BEGIN
  bmpPic:=Tbitmap.Create;
  Updating:=FALSE;
  Force:=clBlue;
  BackGR:=clWhite;
  OnlyUpdate:=TRUE;
  MousePushed:=FALSE;
  CM:=Screen.PixelsPerInch/CM_Inch;
  Nodes_Result:=TNodes.Create;
  Elements_Result:=TElements.Create;
  Left:=0;
  Top:=60;
  OffsetX:=0;
  OffsetY:=0;
  ActiveToolButton:=DefaultAction;
  ActiveRadio:=RadioCM;
  Scale:=1;
  OnlyUpdate:=FALSE;
{*****>}
  CheckRegForShowCells;
{<*****}
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

Procedure TShowCellsForm.LoadDim;
VAR
fhname     : TextFile;
Dimension  : string;
dim        : Integer;
f          : String;
Begin
     f := getDimFileName(Project_GetFormFile) + '.sdm';
     if FileExists(f) then
     begin
          AssignFile(fhname,f);
          Reset(fhname);
          ReadLn(fhname,Dimension);
          CloseFile(fhname);
     end
     else
     begin
          Dimension := '1';
     end;
     dim := StrToInt(Dimension);
     case dim of
          0 : RadioMM.Checked := True;
          1 : RadioCM.Checked := True;
          2 : RadioDM.Checked := True;
          3 : RadioM.Checked := True;
     end;
End;

PROCEDURE TShowCellsForm.FormDestroy(Sender:TObject);
BEGIN
  Nodes_Result.Free;
  Elements_Result.Free;
END;


PROCEDURE TShowCellsForm.FormResize(Sender:TObject);
VAR
  dop : INTEGER;
  cfF : TIniFile;
  ppp : real;
  SigmaLocation: string;
  i: integer;
BEGIN
  // ���������� ��������� �����
  dop:=0;
  top:=0;
       //����������� ����� ������������ �����
     SigmaLocation   :=LowerCase(ExtractFilePath(ParamStr(0)));
     i:=pos('\bin',SigmaLocation);
     if i>0 then SetLength(SigmaLocation,i);
     cfF:=TIniFile.Create(SigmaLocation+'bin\sforms.ini');

  //cfF:=TIniFile.Create('sforms.ini');
  TRY
    dop:=CfF.ReadInteger('�������','������',top);
    top:=dop-StatusBar1.Height-8;
    left:=0;
    Height:=Screen.Height-dop;
    cfF.Free;
  EXCEPT
    MessageDlg('�� ���� ��������� ���� sforms.ini!',mtError,[mbOk],0);
  END;
{*****>}
// Constraints.MaxHeight:=Screen.Height-dop;
  ppp:=dop*1.7;
{<*****}
  Constraints.MaxHeight:=Screen.Height;//-StrTOint(FloatToStr(ppp));
{*****>}
  //  Constraints.MinWidth:=Screen.Width;
  Constraints.MaxWidth:=Screen.Width-200;
  Constraints.MinWidth:=Screen.Width-200;
{<*****}
  top:=dop-StatusBar1.Height-8;
  ChangeDrawSize;
{*****>}
  IF ReLoadRegShowForm then CheckRegForShowCells;
{<*****}
END;


PROCEDURE TShowCellsForm.PaintBox1Paint(Sender: TObject);
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


PROCEDURE TShowCellsForm.UseLegendClick(Sender: TObject);
BEGIN
  IF UseLegend.Checked THEN BEGIN
    Splitter2.Visible:=TRUE;
    LegendPanel.Visible:=TRUE;
{<*****}
  END
  ELSE begin
      Panel3.Visible:=true;      // ������� ���������
      Panel4.Visible:=true;      // ����� ��������
      Splitter2.Visible:=FAlse;
      LegendPanel.Visible:=False;
  END;
{*****>}
  Legend.Repaint;
{<*****}
  ChangeDrawSize;
END;

PROCEDURE TShowCellsForm.UseLinesClick(Sender: TObject);
BEGIN
  IF UseLines.Checked THEN BEGIN
      LinesShow:=true;
      ChangeLegend.Max := 60;
      if ChangeLegend.Position > 60 then
        ChangeLegend.Position:=60;
      //ColorPlus.Color:=LinesCPlus;
      //ColorMinus.Color:=LinesCMinus;
      //ColorZero.Enabled:=false;
  END
  ELSE BEGIN
      LinesShow:=false;
      ChangeLegend.Max := 255;
      //ColorPlus.Color:=CPlus;
      //ColorMinus.Color:=CMinus;
      //ColorZero.Enabled:=true;
  END;
  LegendRePaint;
  MainRePaint;
END;

PROCEDURE TShowCellsForm.RePaintPlate(Sender: TObject);
BEGIN
  MainRePaint;
END;


PROCEDURE TShowCellsForm.EditScaleChange(Sender: TObject);
BEGIN
  SetDiapazon;
END;


PROCEDURE TShowCellsForm.TrackBar1Change(Sender: TObject);
VAR
  Half,Value : MyReal;

BEGIN
  Half:=ROUND((TrackBar1.Max)/2);
  Value:=ABS(TrackBar1.Position-Half);
  IF TrackBar1.Position>=Half THEN Scale:=1+Value ELSE Scale:=1/(1+Value);
  Scaling;
  MainRePaint;
END;


PROCEDURE TShowCellsForm.ChangeLegendChange(Sender: TObject);
BEGIN
  ChangeLegend.Hint:=inttostr(ChangeLegend.Position);
  LevelNumber.Caption:=ChangeLegend.Hint;
  ChengeLegendLevel;
  MainRePaint;
  LegendRePaint;
END;


PROCEDURE TShowCellsForm.StressTypeClick(Sender: TObject);
BEGIN
  ChengeLegendLevel;
  MainRePaint;
  LegendRePaint;
END;


// ����� �������
PROCEDURE TShowCellsForm.LegendPaint(Sender: TObject);

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
    dlevel:= (Elements_Result.Max[StressType.ItemIndex+1] -
              Elements_Result.Min[StressType.ItemIndex+1])/ChangeLegend.Position;
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
        pos:=ROUND( (Elements_Result.Max[StressType.ItemIndex+1]
                      - Elements_Result.Min[StressType.ItemIndex+1])  *k);
        Canvas.TextOut(Left,Top-5,MyFloatToStr(Elements_Result.Max[StressType.ItemIndex+1]));
        Canvas.TextOut(Left,Legend.Height-Top-5,'0');
        Canvas.TextOut(Left,Top+pos-5,MyFloatToStr(Elements_Result.Min[StressType.ItemIndex+1]));
        dop:=(Legend.Height-10) div 2; //��������� �������� ��� ������
        dopp:=(Elements_Result.Max[StressType.ItemIndex+1]
                + Elements_Result.Min[StressType.ItemIndex+1])/2;//������� ��������
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
        Long:=Elements_Result.Max[StressType.ItemIndex+1]
              - Elements_Result.Min[StressType.ItemIndex+1];
        k:=MyDiv((Legend.Height-2*Top),Long);
        pos:=ROUND((Elements_Result.Max[StressType.ItemIndex+1])*k);
        Canvas.TextOut(Left,Top-5,MyFloatToStr(Elements_Result.Max[StressType.ItemIndex+1]));
        Canvas.TextOut(Left,Legend.Height-Top-5,
                        MyFloatToStr(Elements_Result.Min[StressType.ItemIndex+1]));
        dop:=(Legend.Height-10) div 2; //��������� �������� ��� ������
        dopp:=(Elements_Result.Max[StressType.ItemIndex+1]
                + Elements_Result.Min[StressType.ItemIndex+1])/2;//������� ��������
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
      Long:= - Elements_Result.Min[StressType.ItemIndex+1];
      k:=MyDiv((Legend.Height-2*Top),Long);
      pos:=ROUND((-Elements_Result.Max[StressType.ItemIndex+1])*k);
      Canvas.TextOut(Left,Top-5,'0');
      Canvas.TextOut(Left,Legend.Height-Top-5,MyFloatToStr(Elements_Result.Min[StressType.ItemIndex+1]));
      Canvas.TextOut(Left,Top+pos-5,MyFloatToStr(Elements_Result.Max[StressType.ItemIndex+1]));
      dop:=(Legend.Height-10) div 2; //��������� �������� ��� ������
      dopp:=(Elements_Result.Max[StressType.ItemIndex+1]
             + Elements_Result.Min[StressType.ItemIndex+1])/2;//������� ��������
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

  PROCEDURE ShowLegend(Canvas:TCanvas;Left,Top,Width:INTEGER;Step:MyReal);
  VAR
    i,k  : WORD;
    Rect : TRect;

  BEGIN
    Canvas.Brush.Color:=BackGR;
    Canvas.FillRect(Canvas.ClipRect);
    Rect.Left:=Left;
    Rect.Right:=Left+Width;
    Canvas.Pen.Color:=clBlack;
    FOR i:=0 TO ChangeLegend.Position-1 DO BEGIN
      k:=ChangeLegend.Position-1-i;
      if LinesShow = true then
        Canvas.Brush.Color:=GenerateColor(i)
      else
        Canvas.Brush.Color:=GenerateColorOld(i);
      Rect.Top:=Top+trunc(Step*k);
      Rect.Bottom:=1+Top+trunc(Step*(k+1));
      Canvas.FillRect(Rect);
      Canvas.Brush.Color:=clBlack;
      Canvas.FrameRect(Rect);
    END;
    Canvas.Brush.Color:=BackGR;
    ShowLegendHints(Canvas,Rect.Right,Top);
  END;

VAR
  Bitmap : TBitMap;
BEGIN
  TRY
    IF UseBuffer.Checked THEN BEGIN
      Bitmap:=TBitmap.Create;
      Bitmap.Width:=Legend.Width;
      Bitmap.Height:=Legend.Height;
    END;
    IF UseBuffer.Checked THEN BEGIN
      ShowLegend(BitMap.Canvas,paintdx,paintdy,20,(Legend.Height-paintdy*2)/ChangeLegend.Position);
      Legend.Canvas.Draw(0,0,BitMap);
    END
    ELSE ShowLegend(Legend.Canvas,paintdx,paintdy,20,(Legend.Height-paintdy*2)/ChangeLegend.Position);
  FINALLY
    IF UseBuffer.Checked THEN Bitmap.Free;
  END;
END;


PROCEDURE TShowCellsForm.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: INTEGER);
{*****>}
Var
Renum   : Integer;
OneNode : TOneNode;
{<*****}
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
{*****>}
      PaintBox1.Canvas.Pen.Mode:=pmMask;
{<*****}
      PaintBox1.Canvas.Pen.Color:=clBlue;
      PaintBox1.Canvas.Rectangle(X+cursorcrosdx,Y+cursorcrosdx,DownX+cursorcrosdx,DownY+cursorcrosdx);
{*****>}
      PaintBox1.Canvas.Pen.Style:=psSolid;
      MainRePaint;
{<*****}
    END;
  END;
  IF ActiveToolButton=DefaultAction THEN BEGIN
    MouseX:=Xpaint2Xreal(x);
    MouseY:=Ypaint2Yreal(y);
    StatusBar1.Panels[0].Text:=MyFloatToStr(MouseX);
    StatusBar1.Panels[1].Text:=MyFloatToStr(MouseY);
{*****>}
    StatusBar1.Panels[2].Text:=getDimFileName(Project_GetFormFile) + '||'
                               + Project_GetFormFile;
// ��������� ��������� ���� (���� ��� ������ �� ����� ����� ��������)
{**   if (changedonow.Checked=true) then begin
      alg_node_new_x.Text:=Format('%-7f',[X]);
      alg_node_new_y.Text:=Format('%-7f',[Y]);
      Renum:=StrToInt(alg_node.Text);
      OneNode:=  Nodes_result.GetCopyNode(Renum);
      OneNode.x:=StrToFloat(alg_node_new_x.text);
      OneNode.y:=StrToFloat(alg_node_new_y.text);
      Nodes_result.SetCopyNode(OneNode.RenumNum,OneNode);
      PaintBox1.Repaint;
    end;}
{<*****}
    IF MousePushed THEN PaintBox1Click;
  END;
END;


PROCEDURE TShowCellsForm.MoverChange(Sender: TObject);
BEGIN
  ChangeDrawSize;
  MainRePaint;
END;


PROCEDURE TShowCellsForm.ShowForm;
BEGIN
  LoadResults(ResFile);
  FigureX:=(Nodes_Result.Area.maxx-Nodes_Result.Area.minx)/2;
  FigureY:=(Nodes_Result.Area.maxy-Nodes_Result.Area.miny)/2;
  IF Nodes_Result.Error<>0 THEN BEGIN
    ShowMessage('���� ��������� �������� ������ ��� ������ � ������������ �������');
    Close;
  END
  ELSE BEGIN
    SetDiapazon;
    Show;
    //BestFitActionClick(nil);
  END;
END;


PROCEDURE TShowCellsForm.FormClose(Sender: TObject; VAR Action: TCloseAction);
Var
  Registry: TRegistry;
BEGIN
// ��������� ���� ����
  IF SaveShowForm = True then SaveForm(Pluginreg.ShowFormReg.Current);
// SaveForm(PluginRegName);
{<*****}
  Action:=caFree;
  if ShowCellsForm<>nil then begin
    MainR.ActiveWindow.Items.Delete(MainR.ActiveWindow.items.IndexOf('����������� �����������'));
    MainR.ActiveForm[1]:=-1;MainR.RefreshIndexes;
    ShowCellsForm:=nil;
  end;
  // ����������� ���������� ��� ���������� � ������
  bmpPic.Free;
END;


PROCEDURE TShowCellsForm.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
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


PROCEDURE TShowCellsForm.ZoomAreaRect(x1,y1,x2,y2:MyReal);
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
PROCEDURE TShowCellsForm.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
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
PROCEDURE TShowCellsForm.ChangeActionClick(Sender: TObject);

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
PROCEDURE TShowCellsForm.RadioCMClick(Sender: TObject);

  PROCEDURE Change(Sender: TRadioButton);
  BEGIN
    ActiveRadio.Checked:=FALSE;
    ActiveRadio:=Sender
  END;

BEGIN
  IF ActiveRadio=RadioCM THEN CM:=Screen.PixelsPerInch/CM_Inch
  ELSE IF ActiveRadio=RadioMM THEN CM:=Screen.PixelsPerInch/CM_Inch/10
  ELSE IF ActiveRadio=RadioDM THEN CM:=Screen.PixelsPerInch/CM_Inch*10
  ELSE IF ActiveRadio=RadioM THEN CM:=Screen.PixelsPerInch/CM_Inch*100;
  MainRePaint;
END;


PROCEDURE TShowCellsForm.BestFitActionClick(Sender: TObject);
BEGIN
  ZoomAreaRect(Nodes_Result.Area.minx,Nodes_Result.Area.miny,Nodes_Result.Area.maxx,Nodes_Result.Area.maxy);
  TrackBar1.Position:=TrackBar1.Position-1;
  MainRePaint;
END;


PROCEDURE TShowCellsForm.ChangeColorClick(Sender: TObject);
BEGIN
  ColorDialog1.Color:=(Sender as TPanel).Color;
  IF ColorDialog1.Execute THEN BEGIN
    (Sender as TPanel).Color := ColorDialog1.Color;
    MainRePaint;
    LegendPaint(nil);
  END;
END;

//plus
{PROCEDURE TShowCellsForm.ChangeColorPlus(Sender: TObject);
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
PROCEDURE TShowCellsForm.ChangeColorMinus(Sender: TObject);
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

PROCEDURE TShowCellsForm.EditMoverChange(Sender: TObject);
VAR
  value : MyReal;

BEGIN
  value:=1;
  IF CheckReal(EditMover.text,value) THEN BEGIN
    IF (Value<=0) THEN BEGIN
      EditMover.text:='0';
      Value:=0;
    END;
    MoverK:=Value;
    MoverChange(nil);
  END;
END;


PROCEDURE TShowCellsForm.EditForceChange(Sender: TObject);
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


PROCEDURE TShowCellsForm.PlusMClick(Sender: TObject);
BEGIN
  ChangeColorClick(ColorPlus);
END;


PROCEDURE TShowCellsForm.MinusMClick(Sender: TObject);
BEGIN
  ChangeColorClick(ColorMinus);
END;


PROCEDURE TShowCellsForm.ZeroMClick(Sender: TObject);
BEGIN
  ChangeColorClick(ColorZero);
END;


PROCEDURE TShowCellsForm.BkgrMClick(Sender: TObject);
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


PROCEDURE TShowCellsForm.ForceMClick(Sender: TObject);
BEGIN
  ColorDialog1.Color:=Force;
  IF ColorDialog1.Execute THEN BEGIN
    Force := ColorDialog1.Color;
    MainRePaint;
  END;
END;


PROCEDURE TShowCellsForm.UpDown1ChangingEx(Sender: TObject; VAR AllowChange:BOOLEAN; NewValue:SMALLINT; Direction:TUpDownDirection);
CONST
  Step=0.1;

BEGIN
  IF Direction=updDown THEN ForceK:=ForceK-Step;
  IF Direction=updUP THEN ForceK:=ForceK+Step;
  EditForce.Text:=MyFloatToStr(ForceK);
  AllowChange:=FALSE;
END;


PROCEDURE TShowCellsForm.EditXChange(Sender: TObject);
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
FUNCTION TShowCellsForm.SolveInPoint : Boolean;
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
FUNCTION TShowCellsForm.StressInPoint(X,Y:MyReal;VAR st:TStressArray):BOOLEAN;
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
FUNCTION TShowCellsForm.StressInPointType(X,Y:MyReal;VAR st:TStressArray; Typ:Integer):BOOLEAN;
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
  Result:=TRUE;
END;


PROCEDURE TShowCellsForm.PaintBox1Click;
BEGIN
  Updating:=TRUE;
  X:=MouseX;
  Y:=MouseY;
{  EditX.Text:=cutStr(MyFloatToStr(X));
  EditY.Text:=cutStr(MyFloatToStr(Y));}
  EditX.Text:=MyFloatToStr(X);
  EditY.Text:=MyFloatToStr(Y);
  // Repaint to show the selected point on the canvas
  IF( SolveInPoint ) then
    PaintBox1.Repaint;
  Updating:=FALSE;
END;


PROCEDURE TShowCellsForm.ForceTrackBarChange(Sender: TObject);
VAR
  pos,Half : MyReal;

BEGIN
  Half:=(ForceTrackBar.Max-1)/2;
  pos:=ForceTrackBar.Position-Half;
  IF pos>=1 THEN ForceK:=pos ELSE ForceK:=1/(2-pos);
  MainRePaint;
END;


PROCEDURE TShowCellsForm.UseAxesClick(Sender: TObject);
BEGIN
  MainRePaint;
END;


PROCEDURE TShowCellsForm.GroupBox6DblClick(Sender: TObject);
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
PROCEDURE TShowCellsForm.SpeedButton2Click(Sender: TObject);
BEGIN
  IF SavePicDlg.Execute THEN bmpPic.SaveToFile(SavePicDlg.FileName);
END;


// ���������� ����������� ����� ����
PROCEDURE TShowCellsForm.SpeedButton3Click(Sender: TObject);
BEGIN
  IF SavePicDlg.Execute THEN GetFormImage.SaveToFile(SavePicDlg.FileName);
END;


PROCEDURE TShowCellsForm.SpeedButton4Click(Sender: TObject);
BEGIN
  print;
END;

Procedure TShowCellsForm.StressMethodSave(Method: Integer);
VAR
  Registry:TRegistry;
Begin
     Registry:=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(PluginReg.PluginRegPath,true) then
        begin
             Registry.WriteInteger('StressMethod',Method);
        end;
     Registry.CloseKey;
     Registry.Free;
End;

Function TShowCellsForm.StressMethodLoad(Method: Integer):Integer;
VAR
  Registry:TRegistry;
  Ret:     Integer;
Begin
     Registry:=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(PluginReg.PluginRegPath,true) then
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

procedure TShowCellsForm.StressMethod1Click(Sender: TObject);
begin
  StressMethod := 1;
  StressMethodSave(1);
  SolveInPoint;
end;

procedure TShowCellsForm.StressMethod2Click(Sender: TObject);
begin
  StressMethod := 2;
  StressMethodSave(2);
  SolveInPoint;
end;

procedure TShowCellsForm.StressMethod3Click(Sender: TObject);
begin
  StressMethod := 3;
  StressMethodSave(3);
  SolveInPoint;
end;

function TShowCellsForm.MoveInPoint(X,Y:MyReal;var move_st:TStressArray):boolean;
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
     Result:=true;
end;

procedure TShowCellsForm.FormShow(Sender: TObject);
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
  LoadDim;
end;

procedure TShowCellsForm.ToolButton1Click(Sender: TObject);
begin
  //Group1.SetFocus;

end;

procedure TShowCellsForm.SpeedButton1Click(Sender: TObject);
begin
  if ScrollBox1.Visible = true then
  Begin
      ScrollBox1.Visible:=false;
{*****>}
{      Legend.Visible        :=  false;
      LegendPanel.Visible   :=  false;
      UseLegend.Checked     :=  false;}
      Splitter2.Visible     :=  false;
//      DefaultAction.Visible :=  false;
{<*****}
  end
  else Begin
      ScrollBox1.Visible    :=  true;
{*****>}
//      DefaultAction.Visible :=  true;
{<*****}
   end;
   Legend.Repaint; 
end;


procedure TShowCellsForm.SpeedButton5Click(Sender: TObject);
var prnt:TPrintService;
begin
{*****>}
prnt.PrinterSetupDialog;
{<*****}
end;

procedure TShowCellsForm.Timer1Timer(Sender: TObject);
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
PROCEDURE TShowCellsForm.UseTestElements(Canvas:TCanvas);
 VAR
  OneElement   : TOneElement;
  DopStress    :  real;
  Error        : Integer;
  OneNode      : TOneNode;
  findlevel    : INTEGER;
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
        IF Abs(OneElement.strain[StressType.ItemIndex+1])>DopStress THEN
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

function TShowCellsForm.Start:boolean;stdcall;
    begin
// ��������� �� ShowMovings
      UseBuffer.Checked:=True;  //  ������������ �����
      UseNumNode.Checked:=False; //  ������ �����
      UseNumZone.Checked:=False; //  ������ ���������
      UseLegend.Checked:=False; //  �����
      UseForce.Checked:=False;  //  ��������
      UseBound.Checked:=False;  //  ��������� �������
      UseLines.Checked:=True;  //  ����� ������
      TestElements.Checked:=False; // �������� �� ���������
//    Panel3.Visible:=False;      //  ������� ���������
//    Panel4.Visible:=False;      //  ����� ��������
//    ShowCellsForm.SpeedButton1Click(nil);   // -- ��������� ���� ���� event � ����� ���� ���������
//      Legend.Visible        :=  false;
//      LegendPanel.Visible   :=  false;
      UseLegend.Checked     :=  false;
      Splitter2.Visible     :=  false;
//      ShowCellsForm.DefaultAction.Visible :=  false;
// �������
        Width:=960;
        Height:=760;
        PageControl1.Height:=380;
        PageControl1.Width:=340;
// �����
    // ���� �����
        LegendPanel.Color:=StringToColor('clWhite');
    // ���� �������� ������
        Panel2.Color:=StringToColor('clWhite');
    // ����� �����
        ColorMinus.Color:=StringToColor('clLime');
        ColorZero.Color :=StringToColor('clWhite');
        ColorPlus.Color :=StringToColor('clRed');
    //���� ������ ������ � � ���������
        Color               :=$00DEDBCB;
          ScrollBox1.Color  :=$00DEDBCB;
          Group4.Color      :=$00DEDBCB;
            GroupBox2.Color :=$00DEDBCB;
            GroupBox3.Color :=$00DEDBCB;
        TabSheet1.Font.Color:=$00DEDBCB;
          GroupBox4.Color   :=$00DEDBCB;
            Panel5.Color    :=$00DEDBCB;
          GroupBox9.Color   :=$00DEDBCB;
        TabSheet2.Font.Color:=$00DEDBCB;
          GroupBox8.Color   :=$00DEDBCB;
            Panel1.Color    :=$00DEDBCB;
            Panel6.Color    :=$00DEDBCB;
            Panel7.Color    :=$00DEDBCB;
        TabSheet3.Font.Color:=$00DEDBCB;
          GroupBox5.Color   :=$00DEDBCB;
          GroupBox7.Color   :=$00DEDBCB;
        TabSheet4.Font.Color:=$00DEDBCB;
          GroupBox1.Color   :=$00DEDBCB;
    //���� ������� ������ � � ���������
        ControlBar1.Color   :=StringToColor('$00CEC1CA');
          Panel10.Color     :=StringToColor('$00CEC1CA');
          Panel3.Color      :=StringToColor('$00CEC1CA');
            RadioCM.Color   :=StringToColor('$00CEC1CA');
            RadioDM.Color   :=StringToColor('$00CEC1CA');
            RadioM.Color    :=StringToColor('$00CEC1CA');
            RadioMM.Color   :=StringToColor('$00CEC1CA');
          Panel4.Color      :=StringToColor('$00CEC1CA');
          Panel8.Color      :=StringToColor('$00CEC1CA');
          ToolBar1.Color    :=StringToColor('$00CEC1CA');
    // ������������
        MainRePaint;
        Legend.Repaint;
        LegendPanel.Repaint;
// ������� ��������, ���� �������� ������ � �����������������
        TrackBar1.Position:=ShowCellsForm.TrackBar1.Position-1;
// ������
 //       ShowCellsForm.Icon.LoadFromFile('D:\Bokov\5.0\RupertAlg\RupertAlg.ico');
// Exit
        result:=True;
end;

Procedure TShowCellsForm.SetDefaultReg(Name : String);
Var
  Registry:TRegistry;
Begin
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  Registry.OpenKey(Name,True);
  Registry.WriteInteger('Maximized',$0);
  Registry.WriteInteger('Top',$5d);
  Registry.WriteInteger('Left',$0);
  Registry.WriteInteger('Width',$438);
  Registry.WriteInteger('Height',$334);
  Registry.WriteString('ColorZero',ColorToString(clWhite));
  Registry.WriteString('ColorPlus',ColorToString(clRed));
  Registry.WriteString('ColorMinus',ColorToString(clLime));
//Registry.WriteString('LinesColorPlus',ColorToSTRING(LinesCPlus));
//Registry.WriteString('LinesColorMinus',ColorToSTRING(LinesCMinus));
  Registry.WriteInteger('UseLines',$0);
  Registry.WriteString('Force',ColorToSTRING(clBlue));
  Registry.WriteString('BackGround',ColorToSTRING(clWhite));
  Registry.WriteFloat('MoverK',$0);
  Registry.WriteInteger('ForceK',$5);
  Registry.WriteInteger('ForcePos',$6);
  Registry.WriteBool('UseLegend',True);
  Registry.WriteBool('UseForce',False);
  Registry.WriteBool('UseBound',False);
  Registry.WriteBool('UseNumNode',False);
  Registry.WriteBool('UseNumZone',False);
  Registry.WriteBool('UseBuffer',True);
  Registry.free;
end;

procedure TShowCellsForm.CheckRegForShowCells;
var
Registry:TRegistry;
Begin
// ������������� � �������� �� ���������
  LoadShowForm:=False;
  SaveShowForm:=False;
  LegendTieColorBar:=True;
// �������� � ��������
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  IF Registry.KeyExists(PluginReg.ShowFormReg.FullPath) then begin // ���� �� ����� ��� ShowRes
    IF not(Registry.KeyExists(PluginReg.ShowFormReg.Default)) then // �� ��������� (ShowRes)
      Registry.CreateKey(PluginReg.ShowFormReg.Default);
    IF not(Registry.KeyExists(PluginReg.ShowFormReg.Current)) then // ������� (ShowRes)
      Registry.CreateKey(PluginReg.ShowFormReg.Current);
    if Registry.OpenKeyReadOnly(PluginReg.ShowFormReg.FullPath) then begin // ��� ����� ���� - ������ ���������
      LoadShowForm:=Registry.ReadBool('LoadShowForm');
      SaveShowForm:=Registry.ReadBool('SaveShowForm');
      ReLoadRegShowForm:=Registry.ReadBool('ReLoadRegShowForm');
      LegendTieColorBar:=Registry.ReadBool('LegendTieColorBar');
    end
  end
  else begin
    Registry.CreateKey(PluginReg.ShowFormReg.FullPath);
    Registry.CreateKey(PluginReg.ShowFormReg.Default);
    Registry.CreateKey(PluginReg.ShowFormReg.Current);
    Registry.OpenKey(PluginReg.ShowFormReg.FullPath,True);
      Registry.WriteBool('LoadShowForm',False);
      Registry.WriteBool('SaveShowForm',False);
      Registry.WriteBool('ReLoadRegShowForm',False);
      Registry.WriteBool('LegendTieColorBar',True);
      Registry.WriteBool('ShowMenuRes',True);
      Registry.WriteBool('ShowMenuRupert',False);
    SetDefaultReg(PluginReg.ShowFormReg.Current);
  end;
  Registry.Free;
// ��������� ����� �� ���������
  SetDefaultReg(PluginReg.ShowFormReg.Default);
end;

END.
