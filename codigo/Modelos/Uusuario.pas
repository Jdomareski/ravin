unit Uusuario;

interface

type
  Tusuario = class
  private
    FId: Integer;
    Flogin: string;
    Fsenha: string;
    FPessoaid: Integer;
    Fcriadoem: TdateTime;
    Fcriadopor: string;
    Falteradoem: TdateTime;
    Falteradopor: string;
  protected

  public
    property Id: Integer read FId write FId;
    property login: string read Flogin write Flogin;
    property senha: string read Fsenha write Fsenha;
    property Pessoaid: Integer read FPessoaid write FPessoaid;
    property criadoem: TdateTime read Fcriadoem write Fcriadoem;
    property criadopor: string read Fcriadopor write Fcriadopor;
    property alteradoem: TdateTime read Falteradoem write Falteradoem;
    property alteradopor: string read Falteradopor write Falteradopor;

  end;

implementation

end.
