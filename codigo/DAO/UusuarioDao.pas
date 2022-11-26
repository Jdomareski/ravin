unit UusuarioDao;

interface

uses
  Uusuario, FireDAC.Comp.Client, System.Generics.Collections;

type
  TUsuarioDAO = class

  private
  protected
  public
    function BuscarUsuarioPorLoginSenha(Plogin, Psenha: string): TUsuario;
    procedure inserirUsuario(PUsuario: TUsuario);
    function BuscarTodosUsuarios: TList<TUsuario>;

  end;

implementation

uses UdmRavin, System.SysUtils;

{ TUsuarioDAO }

function TUsuarioDAO.BuscarTodosUsuarios: TList<TUsuario>;
var
LQuery : TFDQuery;      //Criar um objeto TFDQuery
LusuarioTemp : TUsuario;   //Criar um objeto Usuario
LLista : TList<TUsuario>;  //Criar a lista
I : Integer;



begin
Lquery := TFDQuery.create(nil);
LQuery.connection := dmRavin.cnxBancoDeDados;
LQuery.SQL.Text := 'Select * FROM usuario ';
LQuery.Open();

LLista := TList<TUsuario>.create;

// mapear os dados

LUsuarioTemp := Nil;
// colocar no inicio
LQuery.First;
// Definir que o while deve prosseguir até o fim arquivo
while not LQuery.Eof do begin
// criar objeto sempre dentro do while para não sobreescrever o objeto.
  LUsuarioTemp := TUsuario.Create();
// consulta o field da tabela e assim de ser feito para todos os itens que se queira recuperar
  LUsuarioTemp.login := LQuery.FieldByName('Login').AsString;

// adicionar na lista
   Llista.Add(LUsuarioTemp);
// ir para o próximo
   LQuery.Next;

end;


Result := Llista;

FreeAndNil (LQuery);


end;

function TUsuarioDAO.BuscarUsuarioPorLoginSenha(Plogin, Psenha: string)
  : TUsuario;
var
  LQuery: TFDQuery;
  LUsuario: TUsuario;
Begin
  LQuery := TFDQuery.Create(nil);
  LQuery.connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'Select * From Usuario ' +
    'WHERE login = :login AND senha = :Senha';
  LQuery.ParamByName('Login').Asstring := Plogin;
  LQuery.ParamByName('senha').Asstring := Psenha;
  LQuery.open();
  LUsuario := Nil;

  if not LQuery.IsEmpty then
  begin
    LUsuario := TUsuario.Create();
    LUsuario.id := LQuery.FieldByName('id').AsInteger;
    LUsuario.login := LQuery.FieldByName('login').Asstring;
    LUsuario.senha := LQuery.FieldByName('senha').Asstring;
    LUsuario.pessoaid := LQuery.FieldByName('pessoaid').AsInteger;
    LUsuario.Criadoem := LQuery.FieldByName('Criadoem').AsDateTime;
    LUsuario.criadopor := LQuery.FieldByName('criadopor').Asstring;
    LUsuario.alteradoem := LQuery.FieldByName('alteradoem').AsDateTime;
    LUsuario.AlteradoPor := LQuery.FieldByName('AlteradoPor').Asstring;
  end;

  LQuery.close();
  freeandnil(LQuery);
  Result := LUsuario;

End;

procedure TUsuarioDAO.inserirUsuario(PUsuario: TUsuario);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  with LQuery do

  begin
    connection := dmRavin.cnxBancoDeDados;
    SQL.add('Insert Into Usuario ');
    SQL.add('(login, senha, pessoaid, criadoEm,  ');
    SQL.add('criadoPor, Alteradoem, alteradoPor)  ');
    SQL.add('VALUES (:login, :senha, :pessoaid, :criadoEm,  ');
    SQL.add(':criadoPor, :Alteradoem, :alteradoPor)  ');

    ParamByName('login').Asstring := PUsuario.login;
    ParamByName('senha').Asstring := PUsuario.senha;
    ParamByName('pessoaid').AsInteger := PUsuario.pessoaid;
    ParamByName('criadoem').AsDateTime := PUsuario.Criadoem;
    ParamByName('criadoPor').Asstring := PUsuario.criadopor;
    ParamByName('alteradoEm').AsDateTime := PUsuario.alteradoem;
    ParamByName('alteradoPor').Asstring := PUsuario.AlteradoPor;
    ExecSQL;
  end;

  Freeandnil (LQuery) ;
end;

end.
