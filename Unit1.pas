unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.FileCtrl, ShellApI;

type
  TForm1 = class(TForm)
    DriveComboBox1: TDriveComboBox;
    Label1: TLabel;
    FileListBox1: TFileListBox;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    procedure DriveComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
  function CopiaTodo(Origen,Destino : String) :
  LongInt;
  var
    F : TShFileOpStruct;
    sOrigen, sDestino : String;
  begin
    Result := 0;
    sOrigen := Origen + #0;
    sDestino := Destino + #0;

    with F do
    begin
      Wnd   := Application.Handle;
      wFunc := FO_COPY;
      pFrom := @sOrigen[1];
      pTo   := @sDestino[1];
      fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION
    end;

    Result := ShFileOperation(F);
end;

begin
  CopiaTodo(Filelistbox1.Directory,DriveCoMbobox1.Drive + ':\');

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    Filelistbox1.Directory := Edit1.Text;
end;

procedure TForm1.DriveComboBox1Change(Sender: TObject);
begin
  Label1.Caption := DriveCoMbobox1.Drive + ':\';
end;


end.
