unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi;

type
  TfrmAbout = class(TForm)
    btnOk: TButton;
    lblName: TLabel;
    lblDescription: TLabel;
    lblAuthor: TLabel;
    lblContactText: TLabel;
    lblContactMail: TLabel;
    lblVersion: TLabel;
    procedure lblContactMailClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    incLetter: Integer;  //позиция набираемой буквы для пасхалки
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

const
  sEgg    = 'STRAY';  //слово для пасхалки
  iEggLen = Length(sEgg);
  VERSION = '0.2.1';

implementation

{$R *.dfm}

function GetFileVersion(const sFilename: String; var n1,n2,n3,n4: Integer): String;
//выдает в результат версию файла sFilename
//можно получить отдельные цифры из версии(n1, n2, n3, n4)
var
  pInfo,pPointer: Pointer;
  nSize: DWORD;
  nHandle: DWORD;
  pVerInfo: PVSFIXEDFILEINFO;
  nVerInfoSize: DWORD;
begin
  Result:='?.?.?.?';
  n1:=-1;
  n2:=-1;
  n3:=-1;
  n4:=-1;
  nSize:=GetFileVersionInfoSize(PChar(sFilename),nHandle);
  if (nSize <>0) then begin
    GetMem(pInfo,nSize);
    try
      FillChar(pInfo^,nSize,0);
      if (GetFileVersionInfo(PChar(sFilename),nHandle,nSize,pInfo)) then begin
        nVerInfoSize:=SizeOf(VS_FIXEDFILEINFO);
        GetMem(pVerInfo,nVerInfoSize);
        try
          FillChar(pVerInfo^,nVerInfoSize,0);
          pPointer:=Pointer(pVerInfo);
          VerQueryValue(pInfo,'\',pPointer,nVerInfoSize);
          n1:=PVSFIXEDFILEINFO(pPointer)^.dwFileVersionMS shr 16;
          n2:=PVSFIXEDFILEINFO(pPointer)^.dwFileVersionMS and $FFFF;
          n3:=PVSFIXEDFILEINFO(pPointer)^.dwFileVersionLS shr 16;
          n4:=PVSFIXEDFILEINFO(pPointer)^.dwFileVersionLS and $FFFF;
          Result:=IntToStr(n1)+'.'+IntToStr(n2)+'.'+IntToStr(n3)+'.'+IntToStr(n4);
        finally
          FreeMem(pVerInfo,nVerInfoSize);
        end;
      end;
    finally
      FreeMem(pInfo,nSize);
    end;
  end;
end;

procedure TfrmAbout.lblContactMailClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow,'open','mailto:stray.omsk@gmail.com',
               nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.btnOkClick(Sender: TObject);
begin
  frmAbout.Hide;
  Close;
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  lblVersion.Caption:=lblVersion.Caption+VERSION; //вывод версии
  KeyPreview:=True; //обработка нажатий клавиш
  incLetter:=1;     //набиратьь секр.слово с 1 символа
end;

procedure TfrmAbout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //если с контролом набрать секр. слово и курсор стоит где надо,
  //то показать пасхалку
  if ssCtrl in Shift then begin
    if Key=Ord(sEGG[incLetter]) then begin
      if incLetter=iEggLen then begin
        if (Mouse.CursorPos.X > frmAbout.Left+264) and
           (Mouse.CursorPos.X < frmAbout.Left+frmAbout.Width) and
           (Mouse.CursorPos.Y > frmAbout.Top+128) and
           (Mouse.CursorPos.Y < frmAbout.Top+frmAbout.Height)
        then begin
          ShowMessage('Да ты я вижу, Xakep :-D');
          incLetter:=1;
        end;
      end
      else incLetter:=incLetter+1;
    end
    else incLetter:=1;
  end;
end;

end.
