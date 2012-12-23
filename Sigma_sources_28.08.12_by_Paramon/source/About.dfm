object FAbout: TFAbout
  Left = 575
  Top = 143
  Width = 473
  Height = 531
  Caption = 'О программе...'
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
    Caption = 'Версия от 20.09.2003'
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
    Caption = 'КАФЕДРА 609'
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
    Caption = 'МАИ'
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
    Caption = 'Учебная система '
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
    Caption = 'конечноэлементного анализа'
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
      'Исходный расчетный модуль разработан Русецким В.А. (каф. 603).'
      'Модифицирован Столярчуком В.А. (каф. 609)'
      'Разработчики системы – студенты кафедры 609. '
      
        'Хвесюк А. В. – выпускник 1997 года (перевод системы с ЕС ЭВМ на ' +
        'РС под '
      'управлением  DOS)'
      
        'Шубин С. А. – выпускник 1998 года (первый вариант системы Sigma3' +
        '2 под '
      'Windows).'
      
        'Разаренов Ф.С. – выпускник 2001 года (новый интерфейс, графическ' +
        'ий '
      'редактор и конвертор входных данных в формат Msc NASTRAN 70)'
      
        'Копылов А.А. – выпускник 2002 года (изменил концепцию интерфейса' +
        ' '
      'системы, разработал новый графический редактор)  '
      'Коровушкин Д.В., Хасаев А.Н., Соловьев М.С., Гельман В.Г. – '
      'выпускники 2000 года, '
      'Захаров В.Р., Соловьев В.С, Блинов Д.В. – выпускники 2001 года '
      
        'Богомольный А.М., Селянова И.А., Сергеев А.С. – выпускники 2002 ' +
        'года'
      '2003 год'
      'студенты групп 06-421, 06-422:'
      'Петроченков М.А. - методы расчета напряжения в точке'
      'Болкисев А.В. - модуль построения графиков сходимости'
      'Пак Г.О. - модифицирован модуль редактирования пластины'
      'Чубрик А.А. - определение перемещений в точке'
      'Коропец А.О. - новый редактор фортрановских модулей'
      'Носова О.В. - руководство пользователя'
      '2004 год'
      'студенты групп 06-421, 06-422:'
      'Алаев Д.С. - доработка экспорта в Nastran, экспорт в XML'
      'Хадиев И.Г. - изменение обратного упорядочения Катхилла-Макки'
      'Стекольников С.В. - линии уровня напряжений'
      'Мизов Р.А. - отображение напряжений, превышающих допускаемые'
      '2003-2005 год'
      'студент групп 06-422,06-522,06-622 Цветаев Б.М.:'
      'Большие системные доработки, внесения изменений в интерфейс и '
      
        'отдельные подсистемы, создание версий комплекса 4.2, 4.5, 4.7, 4' +
        '.8.'
      'отдельную директорию, доработка интерфейса просмотра '
      'графиков сходимости, доработка основного меню приложения, '
      'экспорт информации в MS Word, создание версии комплекса 4.5,'
      'реализация расчета эквивалентного напряжения, изменение панели'
      'просмотра графических результатов, создание версии 4.7.'
      '2006 год'
      'студенты групы 06-622:'
      'Шевченко Т.Л. - создание экспорта в AnSys, нового редактора, '
      'подсистемы сходимости и версии 4.9.'
      'студенты групп 06-421,06-422: '
      'Серебряков Д.С., Дибров Р.А.,Имаметдинов Р.И.Боков П.Ю.:'
      'Исправления и доработка подсистемы построения '
      'графиков сходимости, графического модуля обработки результатов'
      'расчета, экспорта в Nastran, модуля редактирования форм'
      'и системы в целом.'
      'дипломник Котов Д.Д.:'
      'Создание версии 5.0 - с гибким формированием расчётного блока.'
      '2007 год'
      'студенты группы 06-521: '
      'Имаметдинов Р.И., Боков П.Ю. '
      'Перенос основных изменений в версию 5.0'
      '2008 год'
      'дипломник Боков П.Ю.:'
      'Реализация алгоритма Раперта'
      'дипломник Имаметдинов Р.И.:'
      'Реализация метода статистических испытаний.'
      '2009 год'
      'дипломник Плотников Д.В.:'
      'Реализация алгоритма минимальной степени.'
      'дипломник Сазонов А.В.:'
      'Исправления и доработка интерфейса.'
      '2010 год'
      'студент Молоков А.О.:'
      'Глубокая переработка системы. Создание версии Sigma 6.0h.'
      '2011 год'
      'студентка Давыдова Ю.А.:'
      'Модификация модуля графического вывода результатов расчета.'
      'Отображение границ зон и цветовая индикация свойств КЭ.'
      'студент Луняков А.В.:'
      'Доработка модуля построения графиков сходимости, вывод профиля '
      'матрицы.'
      'студент Ярыгин А.Ю.:'
      'Модификация подсистемы Рапперта.'
      'студент Мясоутов Р.И.:'
      'Доработка экспорта в Nastran.'
      'студент Насибуллин Т.Р.:'
      
        'Создание модуля вывода образа матрицы, глубокая переработка сист' +
        'емы, '
      'создание версии 6.1a.'
      
        '============================ 2012 ==============================' +
        '==='
      
      
        'Студент Маркин Н.Н. - полная преработка модуля подстчета значени' +
        'й '
      'перемещений в точке.'
      'Студентка Кормакова В.В. - модификация блока просмотра вывода '
      'текстового результата.'
      
        'Дипломник Парамонов М.В. - разработка подсистемы упорядочения ма' +
        'триц с'
      
        '     тестированием  и исправлением  существующих методов, реализ' +
        'ация и'
      
        '     включение в систему алгоритмов Кинга и Розена, оптимизация ' +
        'вывода'
      
        '     результатов исследования характеристик матриц и схем их хра' +
        'нения.'
      '     Выпуск объединенной версии 6.1b.')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = RichEdit1Change
  end
end
