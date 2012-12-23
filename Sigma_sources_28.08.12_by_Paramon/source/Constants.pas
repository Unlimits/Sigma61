{*********************************************************************}
{                                                                     }
{                    ���������� ����������� ��������                  }
{                                                                     }
{                               ������� 609                           }
{                                                                     }
{                    ������� ����� ����������� 2001                   }
{                                                                     }
{*********************************************************************}
Unit Constants;

Interface
uses Windows,Registry;
function GetProjectName:String;
Const
     //project file constants
     InitSigmaProject= '#Sigma Project File';
     { dll version ... kotov}
     InitSigmaProjectDll= '#Sigma Project File(dll version)';
     AdditionalFiles = '##Form';
     //registry
     ExecuteType     = SW_SHOWMINIMIZED;
     //ExecuteType     = sw_hide;
     //ExecuteType     = sw_normal;
     StringReg       = '\Software\MAI.609\SIGMA32\3.0';
     SigmaPathReg    = 'SigmaPath';
     SigmaSource     = 'SigmaSource';
     SigmaSourceDll     = 'SigmaSourceDLL'; { dll version ... kotov}
     InputFileNameReg= 'InputFileName';
     DelMakReg       = 'DelMakReg';
     DelObjReg       = 'DelObjReg';
     DelTmpReg       = 'DelTmpReg';
     CreateBakReg    = 'CreateBakReg';
Implementation

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

End.






