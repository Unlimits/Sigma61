{*********************************************************************}
{                                                                     }
{                    ���������� ����������� ��������                  }
{                                                                     }
{                               ������� 609                           }
{                                                                     }
{                    ������� ����� ����������� 2001                   }
{                                                                     }
{*********************************************************************}
unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, ExtCtrls, ComCtrls;

type
  TFAbout = class(TForm)
    Button1: TButton;
    RichEdit1: TRichEdit;
    ver: TLabel;
    Label2: TLabel;
    Version: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAbout: TFAbout;

implementation

uses Splash;

{$R *.DFM}

procedure TFAbout.Button1Click(Sender: TObject);
begin
     close;
end;

procedure TFAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
end;

procedure TFAbout.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (Key=VK_ESCAPE) then close;
end;

procedure TFAbout.FormCreate(Sender: TObject);
begin
  Ver.Caption:=App_Version;
  Version.Caption:='������ �� ' + App_Version_date;
end;

procedure TFAbout.RichEdit1Change(Sender: TObject);
begin

end;

end.
