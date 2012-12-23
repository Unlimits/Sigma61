unit test_generator_conf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TStatistics_methods_test_genrator_conf = class(TForm)
    Label1: TLabel;
    K_vo_isp: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    max_time: TEdit;
    Label5: TLabel;
    Dispersia: TEdit;
    Button1: TButton;
    average: TEdit;
    Label6: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Pogr: TEdit;
    Chisl_type: TEdit;
    Rasch_statistick: TEdit;
    Label7: TLabel;
    Rasch_Div: TEdit;
    Label8: TLabel;
    Rasch_kv_Div: TEdit;
    Label9: TLabel;
    Kolichestvo_tochek_graf: TEdit;
    Label10: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Statistics_methods_test_genrator_conf: TStatistics_methods_test_genrator_conf;

implementation

uses test_generator_result, Main, Unit3, strfunc;

{$R *.dfm}


  {�����������}
  { | }
  {\ /}
procedure TStatistics_methods_test_genrator_conf.Button1Click(Sender: TObject);
  const
    messeges: array[1..9] of
      string = ('��������� �-�� ��������� (N),��� ������ ���� ����� � ������ 0.',
      '��������� ���� ����� ������ ����������� (���),��� ������ ���� ����� � ������ 0.',
      '��������� ��� ��������,��� ������ ���� ������������.',
      '��������� �������� ���������,��� ������ ���� ������������ � ������ 0.',
      '��������� ��������� �������� ��������������� ������,��� ������ ���� ������������.',
      '��������� ��������� �������� ����� U � N,��� ������ ���� ������������.',
      '��������� ��������� �������� ���� ��������� U � N,��� ������ ���� ������������.',
      '��������� ���������� �����������,��� ������ ���� ������������ � ������ 0.',
      '��������� ����������� ����� ��� ���������� ��������,��� ������ ���� ����� � ������ 0.'
      );
  var
    Test_int, Error, Kolichestvo_iteraciy, I, J, Vremya_vipolnen,
    M_v_interv, Kolichestvo_tochek_graf: Integer;
    Test_real, Diverg_Summ, Diverg_kv_Summ, Rasch_statistick,
    Rasch_Div, Rasch_kv_Div, Pogr, shag: Real;
    Random_chislo_tek: array [0..100000] of Real;
    tochek_na_shage: array [0..10000] of Integer;
    Time_Nach, Time_Tek: TDateTime;
  label
    zaversh_test;
  begin
    ///// �������� ���� �������� ������ //////
    Error := 0;
    if (not CheckInt(K_vo_isp.Text, Test_int)) then
      Error := 1;
    K_vo_isp.Text := IntToStr(Test_int);
    if Test_int < 1 then
      Error := 1;
    if (not CheckInt(max_time.Text, Test_int)) then
      Error := 2;
    max_time.Text := IntToStr(Test_int);
    if Test_int < 1 then
      Error := 2;

    if (not CheckReal(average.Text, Test_Real)) then
      Error := 3;
    average.Text := FloatToStr(Test_Real);
    if (not CheckReal(Dispersia.Text, Test_Real)) then
      Error := 4;
    Dispersia.Text := FloatToStr(Test_Real);
    if Test_Real < 0 then
      Error := 4;
    if (not CheckReal(Statistics_methods_test_genrator_conf.Rasch_statistick.Text,
        Test_Real)) then
      Error := 5;
    Statistics_methods_test_genrator_conf.Rasch_statistick.Text :=
        FloatToStr(Test_Real);
    if (not CheckReal(Statistics_methods_test_genrator_conf.Rasch_Div.Text,
        Test_Real)) then
      Error := 6;
    Statistics_methods_test_genrator_conf.Rasch_Div.Text :=
        FloatToStr(Test_Real);
    if (not CheckReal(Statistics_methods_test_genrator_conf.Rasch_kv_Div.Text,
        Test_Real)) then
      Error := 7;
    Statistics_methods_test_genrator_conf.Rasch_kv_Div.Text :=
        FloatToStr(Test_Real);
    if (not CheckReal(Statistics_methods_test_genrator_conf.Pogr.Text, Test_Real)) then
      Error := 8;
    Statistics_methods_test_genrator_conf.Pogr.Text := FloatToStr(Test_Real);
    if Test_Real < 0 then
      Error := 8;

    if (not CheckInt(Statistics_methods_test_genrator_conf.Kolichestvo_tochek_graf.Text,
        Test_int)) then
      Error := 9;
    Statistics_methods_test_genrator_conf.Kolichestvo_tochek_graf.Text :=
        IntToStr(Test_int);
    if Test_int < 1 then
      Error := 9;

    if Error <> 0 then
      begin
        ShowMessage('������: ' + messeges[Error]);
        Exit;
      end;
    ///// �������� ���� �������� ������ //////



    /// ���� �� ��� ����������� ���������
    Kolichestvo_iteraciy := StrToInt(K_vo_isp.Text);    // �-�� ��������
    Vremya_vipolnen := StrToInt(max_time.Text);    // ���� ����� ������
    Rasch_statistick := StrToFloat(Statistics_methods_test_genrator_conf.
        Rasch_statistick.Text);
    Rasch_Div := StrToFloat(Statistics_methods_test_genrator_conf.Rasch_Div.Text);
    Rasch_kv_Div := StrToFloat(Statistics_methods_test_genrator_conf.Rasch_kv_Div.Text);
    Pogr := StrToFloat(Statistics_methods_test_genrator_conf.Pogr.Text);
    /// ���� �� ��� ����������� ���������

    M_v_interv := 0;
    Diverg_Summ := 0;
    Diverg_kv_Summ := 0;

    //{->��������� ����� ������ ������
    Time_Nach := Time;
    Time_Tek := Time;
    //{<-��������� ����� ������ ������

    for  I := 1 to Kolichestvo_iteraciy do
      begin
        if Statistics_methods_test_genrator_conf.Chisl_type.Text = '����������� ��������' then
          Random_chislo_tek[I] := Statistics_methods_Main.poluchenie_ravnomern_sluch_chisla()
        else
          Random_chislo_tek[I] := Statistics_methods_Main.poluchenie_normaln_sluch_chisla();


        // ������������� ������
        if ((Random_chislo_tek[I] > StrToFloat(average.Text) - StrToFloat(Dispersia.Text))
            and (Random_chislo_tek[I] < StrToFloat(average.Text) + StrToFloat(Dispersia.Text))) then
          M_v_interv := M_v_interv + 1;
        // ������������� ������


        // ��������� ��������
        //Diverg_Summ := Diverg_Summ + abs(Random_chislo_tek - strtofloat(average.Text)); // ��� ���������� �� ��� ��������
        Diverg_Summ := Diverg_Summ + Random_chislo_tek[I];
        // ��� ������� ����� ��������� �����
        // ��������� ��������

        //  ����� ��������� ��������
        //Diverg_kv_Summ := Diverg_kv_Summ + (abs(Random_chislo_tek - strtofloat(average.Text)))*(abs(Random_chislo_tek - strtofloat(average.Text)));
        Diverg_kv_Summ := Diverg_kv_Summ + Random_chislo_tek[I] * Random_chislo_tek[I];
        // ��� ������� ����� ��������� ��������� �����
        //  ����� ���������  ��������



        //{�������� ������� ������ � ����� �� �����, ���� ������ ��� ������� � ���
        Time_Tek := Time;
        if ((Time_Tek - Time_Nach) * 100000) > Vremya_vipolnen then

          begin
            ShowMessage('�����  = ' + IntToStr(Vremya_vipolnen) +
                ' ������ �������');
            Statistics_methods_test_genrator_result.Vrem.Text :=
                TimeToStr((Time_Tek - Time_Nach));
            //���������� �������� ����� ����������
            Statistics_methods_test_genrator_result.Iter.Text := IntToStr(I);
            Kolichestvo_iteraciy := I;
            //���������� �������� ����������� ��������
            goto zaversh_test;
          end;
        //{�������� ������� ������ � ����� �� �����, ���� ������ ��� ������� � ���
      end;

    ShowMessage('��������� ���  = ' + IntToStr(Kolichestvo_iteraciy) + ' ��������');
    Statistics_methods_test_genrator_result.Vrem.Text :=
        TimeToStr((Time_Tek - Time_Nach));
    //���������� �������� ����� ����������
    Statistics_methods_test_genrator_result.Iter.Text :=
        IntToStr(Kolichestvo_iteraciy);
    //���������� �������� ����������� ��������

    zaversh_test:

    // ���������� ���������� �������������� �������
    Statistics_methods_test_genrator_result.GUI_M_v_interv.Text :=
        FloatToStr(M_v_interv);
    Statistics_methods_test_genrator_result.Otnoshenie_M_k_N.Text :=
        FloatToStr(M_v_interv / Kolichestvo_iteraciy);
    if (((M_v_interv / Kolichestvo_iteraciy) > (Rasch_statistick - Pogr)) and
        ((M_v_interv / Kolichestvo_iteraciy) < (Rasch_statistick + Pogr))) then
      Statistics_methods_test_genrator_result.Itog_Statstick.Text :=
          '�������� ������ � ���������� = ' + FloatToStr(Rasch_statistick)
    else
      Statistics_methods_test_genrator_result.Itog_Statstick.Text :=
          '�������� ������� �� ���������� = ' + FloatToStr(Rasch_statistick);
    // ���������� ���������� �������������� �������

    // ���������� ���������� ����������  ��������
    Statistics_methods_test_genrator_result.GUI_Diverg_Summ.Text :=
        FloatToStr(Diverg_Summ);
    Statistics_methods_test_genrator_result.GUI_Diverg_Summ__k_N.Text :=
        FloatToStr(Diverg_Summ / Kolichestvo_iteraciy);
    if (((Diverg_Summ / Kolichestvo_iteraciy) > (Rasch_Div - Pogr)) and
        ((Diverg_Summ / Kolichestvo_iteraciy) < (Rasch_Div + Pogr))) then
      Statistics_methods_test_genrator_result.Itog_Div.Text :=
          '�������� ������ � ���������� = ' + FloatToStr(Rasch_Div)
    else
      Statistics_methods_test_genrator_result.Itog_Div.Text :=
          '�������� ������� �� ���������� = ' + FloatToStr(Rasch_Div);
    // ���������� ���������� ����������  ��������


    // ���������� ���������� ����� ���������  ��������
    Statistics_methods_test_genrator_result.GUI_Diverg_kv_Summ.Text :=
        FloatToStr(Diverg_kv_Summ);
    Statistics_methods_test_genrator_result.GUI_Diverg_kv_Summ__k_N.Text :=
        FloatToStr(Diverg_kv_Summ / Kolichestvo_iteraciy);
    if (((Diverg_kv_Summ / Kolichestvo_iteraciy) > (Rasch_kv_Div - Pogr)) and
        ((Diverg_kv_Summ / Kolichestvo_iteraciy) < (Rasch_kv_Div + Pogr))) then
      Statistics_methods_test_genrator_result.Itog_kv_Div.Text :=
          '�������� ������ � ���������� = ' + FloatToStr(Rasch_kv_Div)
    else
      Statistics_methods_test_genrator_result.Itog_kv_Div.Text :=
          '�������� ������� �� ���������� = ' + FloatToStr(Rasch_kv_Div);
    // ���������� ���������� ����� ���������  ��������


    //Kolichestvo_tochek_graf:= 10;
    Kolichestvo_tochek_graf := StrToInt(Statistics_methods_test_genrator_conf.
        Kolichestvo_tochek_graf.Text);

    // ���������� �������� �������������� ��������� �����
    shag := 1 / Kolichestvo_tochek_graf;
    for  J := 1 to Kolichestvo_tochek_graf do
      begin
        for  I := 1 to Kolichestvo_iteraciy do
          begin
            if (Random_chislo_tek[I] > (J * shag - shag / 2)) and
                (Random_chislo_tek[I] < (J * shag + shag / 2)) then
              tochek_na_shage[J] := tochek_na_shage[J] + 1;
          end;
      end;
    /// ������� ������� ����
    Statistics_methods_test_genrator_result.Series1.Clear;
    Statistics_methods_test_genrator_result.Series2.Clear;
    Statistics_methods_test_genrator_result.Series3.Clear;
    /// ������ �����
    Statistics_methods_test_genrator_result.Series2.AddXY(0,0);
    Statistics_methods_test_genrator_result.Series3.AddXY(1,0);
    for  J := 1 to Kolichestvo_tochek_graf - 1 do
      begin
        Statistics_methods_test_genrator_result.Series1.AddXY(J * shag,
            tochek_na_shage[J]);
      end;

    // ���������� �������� �������������� ��������� �����



    Statistics_methods_test_genrator_result.Show;
  end;


  { / \}
  {  | }
  {�����������}
end.
