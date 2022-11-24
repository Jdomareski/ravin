program Ravin;

uses
  Vcl.Forms,
  UfrmCartaoPainelGestao in '..\codigo\frames\UfrmCartaoPainelGestao.pas' {frmCartaoPainelControle: TFrame},
  UfrmLogomarca in '..\codigo\frames\UfrmLogomarca.pas' {frmLogo: TFrame},
  UfrmItemMenu in '..\codigo\frames\UfrmItemMenu.pas' {frmMenuItem: TFrame},
  UdmRavin in '..\codigo\database\UdmRavin.pas' {dmRavin: TDataModule},
  UfrmSplash in '..\codigo\formularios\UfrmSplash.pas' {frmSplash},
  UfrmMesas in '..\codigo\formularios\UfrmMesas.pas' {frmMesas},
  UfrmSobre in '..\codigo\formularios\UfrmSobre.pas' {frmSobre},
  UfrmProdutos in '..\codigo\formularios\UfrmProdutos.pas' {frmProdutos},
  UfrmPainelGestao in '..\codigo\formularios\UfrmPainelGestao.pas' {frmPainelGestao},
  UfrmComandas in '..\codigo\formularios\UfrmComandas.pas' {frmComandas},
  ufrmLogin in '..\codigo\formularios\ufrmLogin.pas' {frmLogin},
  frmBotaoPrimarioAutenticacao in '..\codigo\frames\frmBotaoPrimarioAutenticacao.pas' {Frame1: TFrame},
  Uusuario in '..\codigo\Modelos\Uusuario.pas',
  UusuarioDao in '..\codigo\DAO\UusuarioDao.pas',
  UfrmBotaoPrimario in '..\codigo\frames\UfrmBotaoPrimario.pas' {frmBotaoPrimario: TFrame},
  UfrmRegistrar in '..\codigo\formularios\UfrmRegistrar.pas' {frmRegistrar},
  UValidadorUsuario in '..\codigo\Validadores\UValidadorUsuario.pas',
  UiniUtils in '..\codigo\Utils\UiniUtils.pas',
  UResourceUtils in '..\codigo\Utils\UResourceUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TdmRavin, dmRavin);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmRegistrar, frmRegistrar);
  Application.Run;
end.
