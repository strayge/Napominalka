unit uSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, Buttons, ExtCtrls;

type
  TfrmSettings = class(TForm)
    btnOk: TButton;
    edtCaption: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edtNumDays: TEdit;
    btnCancel: TButton;
    lbl3: TLabel;
    edtSeparator: TEdit;
    lbl5: TLabel;
    chkAutostart: TCheckBox;
    sbtnExpertDown: TSpeedButton;
    sbtnExpertUp: TSpeedButton;
    pnl1: TPanel;
    edtTodayLine: TEdit;
    edtTextSeparator: TEdit;
    Label1: TLabel;
    lbl6: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbtnExpertDownClick(Sender: TObject);
    procedure sbtnExpertUpClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Transfer(setFile: string);
    procedure ReadSettings;
    procedure SaveSettings;
    { Public declarations }
  end;

var
  frmSettings: TfrmSettings;
  settingsFile: string;
  autostart: Boolean;

implementation

{$R *.dfm}

procedure TfrmSettings.Transfer(setFile: string);
//��������� ����� ����� � �����������
//(�������� ����� ��������� �����)
begin
  settingsFile:=setFile; 
end;

procedure TfrmSettings.btnOkClick(Sender: TObject);
begin
  SaveSettings;
  Close;
end;

procedure TfrmSettings.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSettings.ReadSettings;
var
  iniFile: TIniFile;
begin
  iniFile:= TIniFile.Create(settingsFile);
  try
    edtNumDays.Text:=IntToStr(iniFile.ReadInteger('main','numDays',30));
    edtCaption.Text:=iniFile.ReadString('main','caption','�����������');
    //edtNameFile.Text:=iniFile.ReadString('main','file','data.txt');
    edtSeparator.Text:=iniFile.ReadString('main','dateSeparator','/');
    edtTodayLine.Text:=iniFile.ReadString('main','todayLine','���������� ������� ���������: ������������');
    edtTextSeparator.Text:=iniFile.ReadString('main','textSeparator','����������������������������������');
    autostart:=iniFile.ReadBool('main','autostart',false);
  except
    ShowMessage('������ ��� ������ ��������');
  end;
  if autostart then chkAutostart.Checked:=True else chkAutostart.Checked:=False;
  iniFile.Free;
end;

procedure TfrmSettings.SaveSettings;
var
  iniFile: TIniFile;
begin
  iniFile:= TIniFile.Create(settingsFile);
  try
    iniFile.WriteInteger('main','numDays',StrToInt(edtNumDays.Text));
  except
    ShowMessage('������ � ���-�� ����'+sLineBreak+'���������� �� �����������');
  end;
  try
    iniFile.WriteString('main','caption',edtCaption.Text);
    iniFile.WriteString('main','dateSeparator',edtSeparator.Text);
    iniFile.WriteBool('main','autostart',chkAutostart.Checked);
    iniFile.WriteString('main','textSeparator',edtTextSeparator.Text);
    iniFile.WriteString('main','todayLine',edtTodayLine.Text);
  except
    ShowMessage('������ ��� ������ ��������');
  end;
  iniFile.Free;
end;

procedure TfrmSettings.FormShow(Sender: TObject);
begin
  ReadSettings;
  sbtnExpertUp.Click; //�������� ���������� ����
end;

procedure TfrmSettings.sbtnExpertDownClick(Sender: TObject);
begin
  sbtnExpertDown.Visible:=False;
  sbtnExpertUp.Visible:=True;
  btnOk.Top:=200;
  btnCancel.Top:=200;
  frmSettings.Height:=257;
  pnl1.Visible:=True;
end;

procedure TfrmSettings.sbtnExpertUpClick(Sender: TObject);
begin
  sbtnExpertUp.Visible:=False;
  sbtnExpertDown.Visible:=True;
  btnOk.Top:=112;
  btnCancel.Top:=112;
  frmSettings.Height:=168;
  pnl1.Visible:=False;
end;

end.
