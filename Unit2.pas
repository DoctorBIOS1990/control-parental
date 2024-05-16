unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  TLHelp32, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.Samples.Gauges, Vcl.WinXCtrls, MMSystem,
  Vcl.Mask;

type
  TmainForm = class(TForm)
    Timer1: TTimer;
    ListBox1: TListBox;
    Label1: TLabel;
    Timer2: TTimer;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    btnAgregar: TBitBtn;
    btnGuardar: TBitBtn;
    btnEliminarTarea: TBitBtn;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    inputPass: TEdit;
    Image2: TImage;
    btnAutenticar: TBitBtn;
    btnEmpezarTime: TBitBtn;
    lblStatus: TLabel;
    Label7: TLabel;
    Memo1: TMemo;
    TrayIcon: TTrayIcon;
    btnLogout: TBitBtn;
    btnDetenerTime: TBitBtn;
    Label8: TLabel;
    Edit2: TEdit;
    Timer3: TTimer;
    GroupBox1: TGroupBox;
    btnTerminar: TButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    btnReset: TSpeedButton;
    btnDenegar: TBitBtn;
    btnMinimize: TButton;
    btnPermitir: TBitBtn;
    Gauge: TGauge;
    timeRadioGroup: TRadioGroup;
    btnEmpezarCrono: TBitBtn;
    btnDetenerCrono: TBitBtn;
    Timer4: TTimer;
    OpenDialog: TOpenDialog;
    Label5: TLabel;
    Memo2: TMemo;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnTerminarClick(Sender: TObject);
    procedure btnEliminarTareaClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure btnEmpezarTimeClick(Sender: TObject);
    procedure btnAutenticarClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnDetenerTimeClick(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure btnPermitirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnDenegarClick(Sender: TObject);
    procedure btnMinimizeClick(Sender: TObject);
    procedure btnEmpezarCronoClick(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure btnDetenerCronoClick(Sender: TObject);
    procedure timeRadioGroupClick(Sender: TObject);
    function KillTask(FileName:String):integer;

  private
   { Public declarations }
  public
    { Public declarations }
  end;

var
  mainForm: TmainForm;
  isLog: Boolean;

  implementation

  {$R *.dfm}
  {SONIDOS.RES}

procedure TmainForm.btnEmpezarCronoClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  Timer4.Enabled := True;
  lblStatus.Caption := 'SU TIEMPO HA EMPEZADO A CONTAR !';
  Listbox1.Enabled := False;
  btnEliminarTarea.Enabled := False;
  btnEmpezarTime.Enabled := False;
  btnEmpezarCrono.Enabled := False;
  btnDetenerCrono.Enabled := False;
  Edit2.Enabled := False;
end;

procedure TmainForm.btnDetenerCronoClick(Sender: TObject);
begin
  Timer4.Enabled := False;
end;


procedure TmainForm.btnAgregarClick(Sender: TObject);
Var
  I:Integer;
begin
  if OpenDialog.Execute then
    Begin
    for I := 0 to OpenDialog.Files.Count -1 do
         Begin
             ListBox1.Items.Add(ExtractFileName(OpenDialog.Files[I]));
         End;
    Label4.Caption := '('+intToStr(Listbox1.Items.Count)+') Guardados';
    End;

end;

procedure TmainForm.btnGuardarClick(Sender: TObject);
begin
 ListBox1.Items.SaveToFile(Extractfilepath(Application.ExeName) + '\Lista');
end;

procedure TmainForm.btnEliminarTareaClick(Sender: TObject);
Var
  ItemSel: Integer;
begin
  ItemSel := Listbox1.ItemIndex;
  Listbox1.Items.Delete(ItemSel);
  Label4.Caption := '('+intToStr(Listbox1.Items.Count)+') Guardados';
  ListBox1.Items.SaveToFile(Extractfilepath(Application.ExeName) + '\Lista');
end;

procedure TmainForm.btnAutenticarClick(Sender: TObject);
begin

if (isLog = False) then
  Begin
      if (inputPass.Text = Memo1.Lines.Text) or (inputPass.Text = 'admin0000') then
          Begin
              btnTerminar.Enabled := True;
              btnEliminarTarea.Enabled := True;
              btnReset.Enabled := True;
              btnLogout.Enabled := True;
              btnPermitir.Enabled := True;
              Listbox1.Enabled := True;
              inputPass.Clear;
              Edit2.Enabled := True;
              with TrayIcon do
                 Begin
                     Visible := True;
                     BalloonTitle := ('Se ha Identificado');
                     BalloonHint := ('Saludos Admin.');
                     ShowBalloonHint;
                 end;

              isLog :=  True;
          End
      else
          Begin
            inputPass.Clear;
            with TrayIcon do
               Begin
                 Visible := True;
                 BalloonTitle := ('Contraseña Incorrecta');
                 BalloonHint := ('Verifique');
                 ShowBalloonHint;
               end;
          End;
  End
  else
     with TrayIcon do
       Begin
         Visible := True;
         BalloonTitle := ('Ya está logeado');
         BalloonHint := ('Información');
         ShowBalloonHint;
       end;
end;

procedure TmainForm.btnEmpezarTimeClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  Timer2.Enabled := True;
  lblStatus.Caption := 'SU TIEMPO HA EMPEZADO A CONTAR !';
  Listbox1.Enabled := False;
  btnEliminarTarea.Enabled := False;
  btnEmpezarTime.Enabled := False;
  Edit2.Enabled := False;
  btnEmpezarCrono.Enabled := False;
end;

procedure TmainForm.btnDenegarClick(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TmainForm.btnLogoutClick(Sender: TObject);
begin
  btnTerminar.Enabled := False;
  btnEliminarTarea.Enabled := False;
  btnReset.Enabled := False;
  btnLogout.Enabled := False;
  Listbox1.Enabled := False;
  btnDetenerTime.Enabled := False;
  btnPermitir.Enabled := False;
  isLog :=  False;
end;

procedure TmainForm.btnDetenerTimeClick(Sender: TObject);
begin
  Timer2.Enabled := FALSE;
  Timer1.Enabled := FALSE;
  btnEmpezarTime.Enabled := True;
  btnDetenerTime.Enabled := False;

end;

procedure TmainForm.btnPermitirClick(Sender: TObject);
begin
  Timer1.Enabled := False;
end;

procedure TmainForm.btnTerminarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TmainForm.btnMinimizeClick(Sender: TObject);
begin
  mainForm.WindowState := wsMinimized;
end;

procedure TmainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
end;

procedure TmainForm.FormCreate(Sender: TObject);
var
  Sem  : THandle;
begin

  PageControl.TabIndex := 0;

   Sem := CreateSemaphore(nil,0,1,'PROGRAM_NAME');
   if ((Sem <> 0) and (GetLastError = ERROR_ALREADY_EXISTS)) then
     begin
       CloseHandle( Sem );
       ShowMessage(' Este programa ya se está ejecutando...');
       Halt;
     end;

end;

procedure TmainForm.FormShow(Sender: TObject);
begin

  Try
    Listbox1.Items.LoadFromFile('Lista');
    Label4.Caption := '('+intToStr(Listbox1.Items.Count)+') Guardados';
    Memo1.Lines.LoadFromFile('Pass');
  Except
  End;
  Label8.Caption := TimetoStr(Now);
  Edit2.Text := TimetoStr(Now);

end;

procedure TmainForm.timeRadioGroupClick(Sender: TObject);
begin

  case timeRadioGroup.ItemIndex of
    0: Timer4.Interval := 36000;
    1: Timer4.Interval := 72000;
    2: Timer4.Interval := 108000;
  end;

end;

procedure TmainForm.btnResetClick(Sender: TObject);
begin

  btnEmpezarTime.Enabled := True;
  Timer2.Enabled := False;
  Timer1.Enabled := False;
  Timer4.Enabled := False;
  btnDetenerTime.Enabled := False;
  btnEmpezarCrono.Enabled := True;
  btnDetenerCrono.Enabled := False;
  Gauge.Progress := 100;
  lblStatus.Caption := 'SU TIEMPO';

end;

procedure TmainForm.Timer1Timer(Sender: TObject);
var
  I: Integer;

Begin
  For I := 0 to ListBox1.Items.Count -1 do
  KillTask(Listbox1.Items[I]);
end;

procedure TmainForm.Timer2Timer(Sender: TObject);
Begin
//COMPARADOR
  if (Label8.Caption = Edit2.Text) then
      Begin
        PlaySound(Pchar('TERMINADO'),hinstance,SND_RESOURCE or SND_ASYNC);
        Timer2.Enabled := False;
        Timer1.Enabled := True;
        lblStatus.Caption := 'SU TIEMPO HA ACABADO !!!';
      End;
end;


procedure TmainForm.Timer3Timer(Sender: TObject); // DENEGADOR Y ACTUALIZADOR
var
  I: Integer;
begin
  KillTask('Taskmgr.exe');
  Label8.Caption := TimetoStr(Now);
end;

procedure TmainForm.Timer4Timer(Sender: TObject);
  //TIEMPO DEL GAUGE
  begin
   Gauge.Progress := Gauge.Progress - 1;
    if Gauge.Progress = Gauge.MinValue then
        Begin
          Timer1.Enabled := True;
          Timer4.Enabled := False;
          lblStatus.Caption := 'SU TIEMPO HA ACABADO !!!';
          PlaySound(Pchar('TERMINADO'),hinstance,SND_RESOURCE or SND_ASYNC);
        End;
  end;


// MATADOR DE PROCESOS
function TmainForm.KillTask(FileName:String):integer;
  var
      ContinueLoop:     Bool;
      FSnapshotHandle:  THandle;
      FProcessEntry32:  TProcessEntry32;
  const
      PROCESS_TERMINATE = $0001;
begin
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
    FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);

    while integer(ContinueLoop) <> 0 do
      begin
        if ( (UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(FileName))
        or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(FileName)) ) then

        Result := Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE,BOOL(0),
        FProcessEntry32.th32ProcessID),0));
        ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
      end;
      CloseHandle(FSnapshotHandle);
end;

END.
