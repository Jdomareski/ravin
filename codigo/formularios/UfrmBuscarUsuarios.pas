unit UfrmBuscarUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, System.Generics.Collections;

type
  TfrmBuscarUsuarios = class(TForm)
    IMGFundo: TImage;
    LBTodosUsuarios: TLabel;
    MMUsuarios: TMemo;
    BTListarUsuarios: TBitBtn;
    procedure BTListarUsuariosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuscarUsuarios: TfrmBuscarUsuarios;

implementation

uses
  UusuarioDao, Uusuario;

{$R *.dfm}

procedure TfrmBuscarUsuarios.BTListarUsuariosClick(Sender: TObject);
var
  LDao: TUsuarioDao;
  LUsuario: TUsuario;
  LLista: TList<TUsuario>;
  I: Integer;

begin
  LDao := TUsuarioDao.Create();
  LLista := LDao.BuscarTodosUsuarios();

  for I := 0 to LLista.count - 1 do
  begin
    LUsuario := LLista.Items[I];
    MMUsuarios.Lines.Add(LUsuario.login);
    FreeAndNil(LUsuario);

    MMUsuarios.visible := true;

  end;
   FreeAndNil(LDao);
   FreeAndNil(LLista);

end;

end.
