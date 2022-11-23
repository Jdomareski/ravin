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
  // Nome não pode ser vazio
  // login não pode ser vazio
  // CPF Não pode ser vazio
  // Quantidade de caracteres de login
  //Só numeros no cpf
  // nome não pode aceitar numero
  // validar caracteres especiais nso campos
  // cpf não pode ser vazio
  // senha = validação de senha
  // cpf é valido

    if Pusuario.login.isEmpty then
      begin
        raise Exception.create('O campo senha não pode ser vazio');
      end;

    if PUsuario.senha.isEmpty then
      begin
        raise Exception.create('O Campo senha não pode ficar em branco');
      end;

      if PUsuario.senha <> PSenhaConfirmacao then
        begin
          raise Exception.create('A senha e a confirmação devem ser iguais');

        end;

  end;
end.
