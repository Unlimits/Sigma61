object FAbout: TFAbout
  Left = 575
  Top = 143
  Width = 473
  Height = 531
  Caption = '� ���������...'
  Color = clBtnFace
  Constraints.MinHeight = 506
  Constraints.MinWidth = 473
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    465
    497)
  PixelsPerInch = 96
  TextHeight = 13
  object ver: TLabel
    Left = 236
    Top = -2
    Width = 157
    Height = 48
    AutoSize = False
    Caption = '6.1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -37
    Font.Name = 'Georgia'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 107
    Top = -3
    Width = 121
    Height = 44
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Sigma'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clRed
    Font.Height = -37
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Transparent = True
  end
  object Version: TLabel
    Left = 2
    Top = 50
    Width = 430
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = '������ �� 20.09.2003'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 182
    Top = 467
    Width = 250
    Height = 12
    Alignment = taRightJustify
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'mai6@cosmos.com.ru ; sva2008@cosmos.com.ru'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 16
    Top = 56
    Width = 88
    Height = 13
    Caption = '������� 609'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 40
    Top = 32
    Width = 39
    Height = 20
    Caption = '���'
    Color = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 152
    Top = 80
    Width = 131
    Height = 16
    Caption = '������� ������� '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel
    Left = 112
    Top = 96
    Width = 225
    Height = 16
    Caption = '������������������ �������'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Transparent = True
  end
  object Button1: TButton
    Left = 16
    Top = 460
    Width = 81
    Height = 24
    Anchors = [akLeft, akBottom]
    BiDiMode = bdLeftToRight
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
    OnKeyDown = FormKeyDown
  end
  object RichEdit1: TRichEdit
    Left = 17
    Top = 125
    Width = 428
    Height = 330
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '�������� ��������� ������ ���������� �������� �.�. (���. 603).'
      '������������� ����������� �.�. (���. 609)'
      '������������ ������� � �������� ������� 609. '
      
        '������ �. �. � ��������� 1997 ���� (������� ������� � �� ��� �� ' +
        '�� ��� '
      '�����������  DOS)'
      
        '����� �. �. � ��������� 1998 ���� (������ ������� ������� Sigma3' +
        '2 ��� '
      'Windows).'
      
        '��������� �.�. � ��������� 2001 ���� (����� ���������, ���������' +
        '�� '
      '�������� � ��������� ������� ������ � ������ Msc NASTRAN 70)'
      
        '������� �.�. � ��������� 2002 ���� (������� ��������� ����������' +
        ' '
      '�������, ���������� ����� ����������� ��������)  '
      '���������� �.�., ������ �.�., �������� �.�., ������� �.�. � '
      '���������� 2000 ����, '
      '������� �.�., �������� �.�, ������ �.�. � ���������� 2001 ���� '
      
        '����������� �.�., �������� �.�., ������� �.�. � ���������� 2002 ' +
        '����'
      '2003 ���'
      '�������� ����� 06-421, 06-422:'
      '����������� �.�. - ������ ������� ���������� � �����'
      '�������� �.�. - ������ ���������� �������� ����������'
      '��� �.�. - ������������� ������ �������������� ��������'
      '������ �.�. - ����������� ����������� � �����'
      '������� �.�. - ����� �������� ������������� �������'
      '������ �.�. - ����������� ������������'
      '2004 ���'
      '�������� ����� 06-421, 06-422:'
      '����� �.�. - ��������� �������� � Nastran, ������� � XML'
      '������ �.�. - ��������� ��������� ������������ ��������-�����'
      '������������ �.�. - ����� ������ ����������'
      '����� �.�. - ����������� ����������, ����������� �����������'
      '2003-2005 ���'
      '������� ����� 06-422,06-522,06-622 ������� �.�.:'
      '������� ��������� ���������, �������� ��������� � ��������� � '
      
        '��������� ����������, �������� ������ ��������� 4.2, 4.5, 4.7, 4' +
        '.8.'
      '��������� ����������, ��������� ���������� ��������� '
      '�������� ����������, ��������� ��������� ���� ����������, '
      '������� ���������� � MS Word, �������� ������ ��������� 4.5,'
      '���������� ������� �������������� ����������, ��������� ������'
      '��������� ����������� �����������, �������� ������ 4.7.'
      '2006 ���'
      '�������� ����� 06-622:'
      '�������� �.�. - �������� �������� � AnSys, ������ ���������, '
      '���������� ���������� � ������ 4.9.'
      '�������� ����� 06-421,06-422: '
      '���������� �.�., ������ �.�.,����������� �.�.����� �.�.:'
      '����������� � ��������� ���������� ���������� '
      '�������� ����������, ������������ ������ ��������� �����������'
      '�������, �������� � Nastran, ������ �������������� ����'
      '� ������� � �����.'
      '��������� ����� �.�.:'
      '�������� ������ 5.0 - � ������ ������������� ���������� �����.'
      '2007 ���'
      '�������� ������ 06-521: '
      '����������� �.�., ����� �.�. '
      '������� �������� ��������� � ������ 5.0'
      '2008 ���'
      '��������� ����� �.�.:'
      '���������� ��������� �������'
      '��������� ����������� �.�.:'
      '���������� ������ �������������� ���������.'
      '2009 ���'
      '��������� ��������� �.�.:'
      '���������� ��������� ����������� �������.'
      '��������� ������� �.�.:'
      '����������� � ��������� ����������.'
      '2010 ���'
      '������� ������� �.�.:'
      '�������� ����������� �������. �������� ������ Sigma 6.0h.'
      '2011 ���'
      '��������� �������� �.�.:'
      '����������� ������ ������������ ������ ����������� �������.'
      '����������� ������ ��� � �������� ��������� ������� ��.'
      '������� ������� �.�.:'
      '��������� ������ ���������� �������� ����������, ����� ������� '
      '�������.'
      '������� ������ �.�.:'
      '����������� ���������� ��������.'
      '������� �������� �.�.:'
      '��������� �������� � Nastran.'
      '������� ���������� �.�.:'
      
        '�������� ������ ������ ������ �������, �������� ����������� ����' +
        '���, '
      '�������� ������ 6.1a.'
      
        '============================ 2012 ==============================' +
        '==='
      
      
        '������� ������ �.�. - ������ ���������� ������ ��������� �������' +
        '� '
      '����������� � �����.'
      '��������� ��������� �.�. - ����������� ����� ��������� ������ '
      '���������� ����������.'
      
        '��������� ��������� �.�. - ���������� ���������� ������������ ��' +
        '���� �'
      
        '     �������������  � ������������  ������������ �������, ������' +
        '���� �'
      
        '     ��������� � ������� ���������� ����� � ������, ����������� ' +
        '������'
      
        '     ����������� ������������ ������������� ������ � ���� �� ���' +
        '�����.'
      '     ������ ������������ ������ 6.1b.')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = RichEdit1Change
  end
end
