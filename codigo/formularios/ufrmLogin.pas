unit ufrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, frmBotaoPrimarioAutenticacao;

type
  TfrmLogin = class(TForm)
    Fundo: TImage;
    EdtLogin: TEdit;
    EdtSenha: TEdit;
    LblTitulo: TLabel;
    LBSubtitulo: TLabel;
    LblRegistrar: TLabel;
    Label2: TLabel;
    Mesa: TImage;
    FrameAutenticar: TFrame1;
    Button1: TButton;
    procedure FrameAutenticarSpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LblRegistrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure setarfomprincipal(Pnovoformulario: TForm);
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses UfrmPainelGestao, Uusuario, UusuarioDao, UfrmRegistrar, UiniUtils;

procedure TfrmLogin.Button1Click(Sender: TObject);
var
  LUsuario: TUsuario;
  LDao: TUsuarioDAO;

begin

  LUsuario := TUsuario.Create;
  LUsuario.login := 'Testte';
  LUsuario.senha := '123';
  LUsuario.pessoaId := 1;
  LUsuario.criadoEm := Now();
  LUsuario.criadoPor := 'Testte';
  LUsuario.alteradoEm := Now();
  LUsuario.alteradoPor := 'Testte';

  LDao := TUsuarioDAO.Create;
  LDao.InserirUsuario(LUsuario);

  FreeAndNil(LDao);
  FreeAndNil(LUsuario);

end;

procedure TfrmLogin.FrameAutenticarSpeedButton1Click(Sender: TObject);
var
  LDao: TUsuarioDAO;
  LUsuario: TUsuario;
  LLogin, LSenha: String;
begin
  LDao := TUsuarioDAO.Create;
  LLogin := EdtLogin.Text;
  LSenha := EdtSenha.Text;
  LUsuario := LDao.BuscarUsuarioPorLoginSenha(LLogin, LSenha);

  if Assigned(LUsuario) then
  Begin
    TIniutils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO, Tiniutils.VALOR_VERDADEIRO);
    if not Assigned(frmPainelGestao) then
    begin
      application.CreateForm(tfrmpainelgestao, frmPainelGestao);
    end;
    setarfomprincipal(frmPainelGestao);
    frmPainelGestao.show();
    close();

  End
  else
  begin
    showmessage('Login e/ou senha invalido');
  end;
  FreeAndNil(LUsuario);
  FreeAndNil(LDao);
end;

procedure TfrmLogin.LblRegistrarClick(Sender: TObject);
begin
  if not Assigned(frmregistrar) then
  begin
    application.CreateForm(Tfrmregistrar, frmregistrar);
  end;

  setarfomprincipal(frmregistrar);
  frmregistrar.show();

  close();
end;

procedure TfrmLogin.setarfomprincipal(Pnovoformulario: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @application.Mainform;
  tmpMain^ := Pnovoformulario;
end;

end.
