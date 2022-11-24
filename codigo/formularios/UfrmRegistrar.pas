unit UfrmRegistrar;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  FIREDAC.PHys.MySQLWrapper,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UfrmBotaoPrimario,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  System.Actions, Vcl.ActnList, Vcl.ExtActns, Vcl.Imaging.jpeg,
  UValidadorUsuario;

type
  TfrmRegistrar = class(TForm)
    imgFundo: TImage;
    pnlRegistrar: TPanel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    lblTituloAutenticar: TLabel;
    lblSubTituloAutenticar: TLabel;
    edtNome: TEdit;
    edtCpf: TEdit;
    frmBotaoPrimarioRegistrar: TfrmBotaoPrimario;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtConfirmarSenha: TEdit;
    procedure lblSubTituloAutenticarClick(Sender: TObject);
    procedure frmBotaoPrimarioRegistrarspbBotaoPrimarioClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetMainForm(NovoMainForm: TForm);
  public
    { Public declarations }
  end;

var
  frmRegistrar: TfrmRegistrar;

implementation

uses
  UusuarioDao,
  Uusuario, ufrmLogin;

{$R *.dfm}

procedure TfrmRegistrar.frmBotaoPrimarioRegistrarspbBotaoPrimarioClick
  (Sender: TObject);
var
  LUsuario: TUsuario;
  LDAO: TUSuarioDAO;
begin
  try

    try

      LUsuario := TUsuario.create;
      LUsuario.login := edtLogin.Text;
      LUsuario.senha := edtSenha.Text;
      LUsuario.pessoaid := 100;
      LUsuario.criadoem := Now();
      LUsuario.criadoPor := 'admin';
      LUsuario.alteradoem := Now();
      LUsuario.alteradoPor := 'admin';

      TValidadorUsuario.Validar(LUsuario, edtConfirmarSenha.Text);

      LDAO := TUSuarioDAO.create();
      LDAO.inserirUsuario(LUsuario);

    except
      on E: EMySQLNativeException do
      Begin
        showMessage('Erro ao inserior usuário');
      End;
      on E: Exception do
      begin
        showMessage
          ('Não foi possivel cadastrar o usuário, DEIXA DE SER BURRO!!! verifique os valores informados');
      end;

    end;
  finally
    if assigned(LDAO) then
      FreeandNil(LDAO);

    FreeandNil(LUsuario);
  end;
end;

procedure TfrmRegistrar.lblSubTituloAutenticarClick(Sender: TObject);
begin
  if not assigned(frmlogin) then
  begin
    Application.CreateForm(Tfrmlogin, frmlogin);
  end;

  SetMainForm(frmlogin);
  frmlogin.Show();

  Close();
end;

procedure TfrmRegistrar.SetMainForm(NovoMainForm: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := NovoMainForm;
end;

end.
