unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Variants, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, IniFiles, Menus, ShellAPI,
  uAbout, uSettings, minireg, XPMan;

type
  TMemo = class(TCustomMemo)
    procedure WMPaint(var Msg: TMessage); message WM_Paint;
    procedure WMSetFocus(var Msg: TMessage); message WM_SetFocus;
    procedure WMNCHitTest(var Msg: TMessage); message WM_NCHitTest;
  published
    property Align;
    property Alignment;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property Lines;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WantReturns;
    property WantTabs;
    property WordWrap;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TfrmMain = class(TForm)
    btnOk: TButton;
    Memo1: TMemo;
    tmUpdDate: TTimer;
    menuMain: TMainMenu;
    menuSettings: TMenuItem;
    menuAbout: TMenuItem;
    menuExit: TMenuItem;
    menuEditDates: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure tmUpdDateTimer(Sender: TObject);
    procedure menuAboutClick(Sender: TObject);
    procedure menuSettingsClick(Sender: TObject);
    procedure menuExitClick(Sender: TObject);
    procedure AddToday;
    procedure AddOther(numDays: Integer);
    procedure OutText(text: string);
    procedure FormDestroy(Sender: TObject);
    procedure menuEditDatesClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure SetAutostart(); forward;
procedure DelAutostart(); forward;
procedure CreateSampleFile(filename: string); forward;
function ReadData(filename: string): TStrings; forward;
procedure FirstParsing(SL: TStrings); forward;
function TextVozr(n: Integer): string; forward;
function TextD(n: Integer): string; forward;
procedure IncDate(var localD: Integer; var localM:Integer; var localY:Integer); forward;
procedure ReadSettings(settingsFile: string); forward;
procedure SaveSettings(settingsFile: string); forward;

const
  Months: array[1..12] of string=('января','февраля','марта','апреля','мая',
               'июня','июля','августа','сентября','октября','ноября','декабря');

var
  frmMain: TfrmMain;
  A: array of record
    D,M,Y: Integer;
    T: string;
  end;
  nowD,nowM,nowY: Word;
  numDays: Integer;
  settingsFile, dataFile: string;
  dateSeparator,textSeparator, todayLine: string;
  autostart: Boolean;

implementation

{$R *.dfm}

procedure TMemo.WMPaint(var Msg: TMessage);
begin
  inherited;
  HideCaret(Handle);
end;

procedure TMemo.WMSetFocus(var Msg: TMessage);
begin
  inherited;
  HideCaret(Handle);
end;

procedure TMemo.WMNCHitTest(var Msg: TMessage);
begin
  inherited;
  HideCaret(Handle);
end;

procedure TfrmMain.OutText(text: string);
begin
  frmMain.Memo1.Lines.Add(text);
end;

function IsAutostart(): Boolean;
var
  regText: string;
begin
  RegGetString(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Run\napominalka',regText);
  if (Application.ExeName=regText) then Result:=True else Result:=False;
end;

procedure SetAutostart();
begin
  RegSetString(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Run\napominalka', Application.ExeName);
end;

procedure DelAutostart();
begin
  RegDelValue(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Run\napominalka');
end;

procedure CreateSampleFile(filename: string);
var
  f: TextFile;
begin
  AssignFile(f, filename);
  Rewrite(f);
  Writeln(f,';Файл данных Напоминалки');
  Writeln(f,';');
  Writeln(f,';Каждую запись пишите с новой строчки.');
  Writeln(f,';Сначала дата в формате дд/мм/гггг,');
  Writeln(f,';затем через пробел выводимый текст(например, ФИО).');
  Writeln(f,';');
  Writeln(f,';Комментарии начинаются точкой с запятой');
  Writeln(f,';');
  Writeln(f,'1/01/1968 Иванов Иван Иванович');
  Writeln(f,'31/12/1949 Сидоров Пётр Петрович');
  Writeln(f,'22/08/2009 день рождение Напоминалки ;-)');
  Writeln(f,'1/09/1990 День знаний');
  CloseFile(f);
end;

function ReadData(filename: string): TStrings;
var
  f: TextFile;
  s: string;
begin
  if not FileExists(filename) then CreateSampleFile(filename);
  AssignFile(f, filename);
  Result:=TStringList.Create;
  Reset(f);
  while not EOF(f) do begin
    Readln(f,s);
    if (Length(s)>9) and (s[1]<>';') and (Trim(s)<>'') then Result.Add(s);
  end;
  CloseFile(f);
end;

procedure FirstParsing(SL: TStrings);
var
  i,position: Integer;
  dateStr, textStr: string;
begin
  SetLength(A,SL.Count);
  for i:=0 to SL.Count-1 do begin
    try
      position:=AnsiPos(' ',SL[i]);
      dateStr:=Copy(SL[i],1,position);
      textStr:=Copy(SL[i],position+Length(dateSeparator),MaxInt);
      position:=AnsiPos(dateSeparator,dateStr);
      A[i].D:=StrToInt(Copy(dateStr,1,position-1));
      A[i].M:=StrToInt(Copy(dateStr,position+1,2));
      A[i].Y:=StrToInt(Copy(dateStr,position+4,4));
      A[i].T:=Trim(textStr);
    except
      ShowMessage('Ошибка парсинга файла, в строке:'+sLineBreak+SL[i]);
      frmMain.Hide;
      Application.Terminate;
    end;
  end;
end;

function TextVozr(n: Integer): string;
var
  i: Integer;
begin
  Result:=IntToStr(n);
  i:= n mod 10;
  if n<0 then begin
    Result:='Появится на свет через '+IntToStr(Abs(n));
    i:=-i;
  end;
  if i=1 then Result:=Result+' год'
  else if (i>1) and (i<5) then Result:=Result+' года'
  else Result:=Result+' лет'
end;

function TextD(n: Integer): string;
var
  i,j: Integer;
begin
  Result:=IntToStr(n);
  i:= n mod 10;
  j:= n mod 100;
  if (j>10) and (j<21) then Result:=Result+' дней'
  else if i=1 then Result:=Result+' день'
  else if (i>1) and (i<5) then Result:=Result+' дня'
  else Result:=Result+' дней'
end;

procedure IncDate(var localD: Integer; var localM:Integer; var localY:Integer);
var
  lastY,lastM,lastD: Word;
  y,m,d: Word;
begin
  DecodeDate(now, y, m, d);
  m:=localM;
  m:=m+1;
  if m>12 then begin
    y:=y+1;
    m:=1;
  end;
  DecodeDate(EncodeDate(y, m, 1)-1,lastY,lastM,lastD);
  if ((localD=lastD) and (localM=lastM)) then begin
    localM:=localM+1;
    if localM>12 then begin
      localY:=localY+1;
      localM:=1;
    end;
    localD:=1;
  end
  else begin
    localD:=localD+1;
  end;
end;

procedure TfrmMain.AddToday;
var
  i: Integer;
  TextShowed: Boolean;
begin
  TextShowed:=False;
  for i:=0 to Length(A) do begin
    if (A[i].M=nowM) and (A[i].D=nowD) then begin
      if TextShowed=False then begin
        OutText(todayLine);
        TextShowed:=True;
      end;
      OutText(A[i].T+' - '+TextVozr(nowY-A[i].Y));
    end
  end;
  if TextShowed=True then OutText(textSeparator);
end;

procedure TfrmMain.AddOther(numDays: Integer);
var
  i,localD,localM,localY,k: Integer;
  FirstTextShowed, EndTextShowing: Boolean;
  tempStr: String;
begin
  localD:=nowD; localM:=nowM; localY:=nowY;
  k:=0;
  while k<numDays do begin
    Inc(k);
    FirstTextShowed:=false;
    EndTextShowing:=false;
    IncDate(localD, localM, localY);
    for i:=0 to Length(A) do begin
      if (A[i].M=localM) and (A[i].D=localD) then begin
        if FirstTextShowed=False then begin
          tempStr:='через '+TextD(k);
          tempStr:=tempStr+' ('+IntToStr(localD)+' '+Months[localM]+'):';
          OutText(tempStr);
        end;
        FirstTextShowed:=true;
        OutText(A[i].T+' - '+TextVozr(localY-A[i].Y));
        EndTextShowing:= True;
      end;
    end;
  if EndTextShowing then OutText(textSeparator);
  end;
end;

procedure ReadSettings(settingsFile: string);
var
  iniFile: TIniFile;
begin
  iniFile:= TIniFile.Create(settingsFile);
  try
    numDays:=        iniFile.ReadInteger('main','numDays',30);
    frmMain.Caption:=iniFile.ReadString('main','caption','Напоминалка');
    dateSeparator:=  iniFile.ReadString('main','dateSeparator','/');
    autostart:=      iniFile.ReadBool('main','autostart',false);
    todayLine:=      iniFile.ReadString('main','todayLine','—————————— Сегодня празднуют: ————————————');
    textSeparator:=iniFile.ReadString('main','textSeparator','——————————————————————————————————');
    frmMain.Left:=   iniFile.ReadInteger('form','left',  218);
    frmMain.Top:=    iniFile.ReadInteger('form','top',   142);
    frmMain.Height:=   iniFile.ReadInteger('form','height',  379);
    frmMain.Width:=    iniFile.ReadInteger('form','width',   361);
  except
    ShowMessage('Ошибка при чтении настроек');
  end;
  iniFile.Free;
end;

procedure SaveSettings(settingsFile: string);
var
  iniFile: TIniFile;
begin
  iniFile:= TIniFile.Create(settingsFile);
  try
    iniFile.WriteString('main','caption',frmMain.Caption);
    iniFile.WriteInteger('main','numDays',numDays);
    iniFile.WriteString('main','dateSeparator',dateSeparator);
    IniFile.WriteBool('main','autostart',autostart);
    iniFile.WriteString('main','textSeparator',textSeparator);
    iniFile.WriteString('main','todayLine',todayLine);
    IniFile.WriteInteger('form','left',  frmMain.Left);
    IniFile.WriteInteger('form','top',   frmMain.Top);
    IniFile.WriteInteger('form','height',frmMain.Height);
    IniFile.WriteInteger('form','width', frmMain.Width);
  except
    ShowMessage('Ошибка при записи настроек');
  end;
  iniFile.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  SL: TStrings;
  Path: string;
begin
  Path:=ExtractFileDir(Application.ExeName);
  if Path[Length(Path)]<>'\' then Path:=Path+'\';
  settingsFile:=Path+'settings.ini';
  ReadSettings(settingsFile);
  dataFile:=Path+'data.txt';
  SL:=ReadData(dataFile);
  FirstParsing(SL);
  SL.Destroy;
  tmUpdDateTimer(nil);
  AddToday;
  AddOther(numDays);
end;

procedure TfrmMain.btnOkClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.tmUpdDateTimer(Sender: TObject);
begin
  DecodeDate(Date,nowY,nowM,nowD);
end;

procedure TfrmMain.menuAboutClick(Sender: TObject);
begin
  frmAbout:=TfrmAbout.Create(nil);
  TfrmAbout(frmAbout).ShowModal;
  TfrmAbout(frmAbout).Free;
end;

procedure TfrmMain.menuSettingsClick(Sender: TObject);
begin
  SaveSettings(settingsFile);
  frmSettings:=TfrmSettings.Create(nil);
  frmSettings.Transfer(settingsFile);
  TfrmSettings(frmSettings).ShowModal;
  TfrmSettings(frmSettings).Free;
  ReadSettings(settingsFile);
  Memo1.Clear;
  AddToday;
  AddOther(numDays);
  if (autostart) and (not IsAutostart) then SetAutostart
  else if (not autostart) and (IsAutostart) then DelAutostart;
end;

procedure TfrmMain.menuExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
   SaveSettings(settingsFile);
end;

procedure TfrmMain.menuEditDatesClick(Sender: TObject);
begin
  ShellExecute(0,'open',PChar(dataFile),nil,nil,SW_SHOWNORMAL);
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  if frmMain.Width<325 then frmMain.Width:=325;
  if frmMain.Height<120 then frmMain.Height:=120;
  Memo1.Height:=frmMain.Height-98;
  Memo1.Width:=frmMain.Width-25;
  btnOk.Top:=frmMain.Height-83;
  btnOk.Left:=(frmMain.Width div 2)-85;
end;

end.
