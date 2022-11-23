unit UValidadorUsuario;

interface
uses
system.Sysutils,
Uusuario;

type TValidadorUsuario = class

private

protected

public
class procedure Validar (PUsuario : TUsuario;
PSenhaConfirmacao : String);

end;

implementation



{ TValidadorUsuario }

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario;PSenhaConfirmacao : String);
  begin
  // Nome n�o pode ser vazio
  // login n�o pode ser vazio
  // CPF N�o pode ser vazio
  // Quantidade de caracteres de login
  //S� numeros no cpf
  // nome n�o pode aceitar numero
  // validar caracteres especiais nso campos
  // cpf n�o pode ser vazio
  // senha = valida��o de senha
  // cpf � valido

    if Pusuario.login.isEmpty then
      begin
        raise Exception.create('O campo senha n�o pode ser vazio');
      end;

    if PUsuario.senha.isEmpty then
      begin
        raise Exception.create('O Campo senha n�o pode ficar em branco');
      end;

      if PUsuario.senha <> PSenhaConfirmacao then
        begin
          raise Exception.create('A senha e a confirma��o devem ser iguais');

        end;

  end;
end.
