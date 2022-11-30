unit UfrmSplash;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,

  UfrmLogomarca;

type
  TfrmSplash = class(TForm)
    pnlFundo: TPanel;
    tmrSplash: TTimer;
    frmLogo: TfrmLogo;
    procedure tmrSplashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    Inicialized: Boolean;
    procedure InicializarAplicacao;
    procedure ShowPainelGestao;
    procedure ShowLogin;



  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses UfrmPainelGestao, ufrmLogin, UiniUtils, UFormsUtils;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  Inicialized := false;
  tmrSplash.Enabled := false;
  tmrSplash.Interval := 1000;
end;

procedure TfrmSplash.FormPaint(Sender: TObject);
begin
  tmrSplash.Enabled := not Inicialized;
end;

procedure TfrmSplash.InicializarAplicacao;
var
LLOgado : String;
begin
LLogado := TiniUtils.lerPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO);

if LLogado = TIniUtils.VALOR_VERDADEIRO then
begin
  ShowPainelGestao();
end

else
begin
 ShowLogin;
end;
end;

procedure TfrmSplash.tmrSplashTimer(Sender: TObject);
begin
  tmrSplash.Enabled := false;
  if not Inicialized then
  begin
    Inicialized := true;
    InicializarAplicacao();
  end;
end;


procedure TfrmSplash.ShowLogin;
begin
  if not Assigned(frmlogin) then
  begin
    Application.CreateForm(Tfrmlogin, frmlogin);
  end;

  TformUtils.SetarFormPrincipal(frmlogin);
  frmlogin.Show();

  Close;
end;

procedure TfrmSplash.ShowPainelGestao;
begin
   if not Assigned(frmPainelGestao) then
  begin
    Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
  end;

  TformUtils.SetarFormPrincipal(frmPainelGestao);
  frmPainelGestao.Show();

  Close;
end;

end.


