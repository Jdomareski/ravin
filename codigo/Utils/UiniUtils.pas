unit UiniUtils;

interface

uses
  System.IOUtils,

  Vcl.Forms,

  TypInfo,
  IniFiles;

type
{NO TSECAO se colocam os titulos dos blocos de informa��o dos arquivos ini e
tem que ser igual ao que vai ser chamado no m�todo
usar para ordenar as informa��es, para detalhes localizar estas informa��es no
arquivo configura��es.ini}
  TSECAO = (CONFIGURACOES, INFORMACOES_GERAIS, DATABASE, LOGINFO, BANCO);

type
{ NO TPROPRIEDADE se colocam as informa��es que ficam nas linhas abaixo dos titulos
e que s�o os dados que se busca}
  TPROPRIEDADE = (SERVER, DATAHORA_ULTIMO_lOGIN, USERNAME, PASSWORD, DRIVERID, PORT, PATH, LOGADO);
  {ATENCAO ESTES DOIS ITENS EM CONJUNTO FORMAM OS ENUMERADORES}

{OUTRA FORMA DE FAZER:

TPROPRIEDADE_BANCO (SERVER, USERNAME, PASSWORD)

SE FIZER ASSIM, N�O PRECISA COLOCAR OS DOIS ITENS ANTERIORES, MAS TEM QUE DECLARAR TODAS INDIVIDUALMENTE)
}

type
{A seguir, v�o os importados para fazer os metodos funcionar}
  TIniUtils = class
  private

  protected

  public
    constructor Create();
    destructor Destroy; override;
  { Aqui se declaram as procedures que v�o ser chamadas pelas units quando necess�rio
  neste caso, est�o duas procedures do tipo CLASS que v�o ler e gravar o arquivo ini
  a primeira vai gravar, utilizando os parametros definidos no TSECAO e TPROPRIEDADE}
     class procedure gravarPropriedade(PSecao: TSECAO;
      PPropriedade: TPROPRIEDADE; PValor: String);
  { Esta procedure vai ler as propriedades j� registradas no ini, veja que as procedures
  ficam prontas mas somente ser�o utilizadas quando chamadas nas outras units}
    class function lerPropriedade(PSecao: TSECAO;
      PPropriedade: TPROPRIEDADE): String;
  { Aqui, defini��o de uma constante para ser utilizada sempre que se colocar verdadeiro ou falso }
    const VALOR_VERDADEIRO : STRING = 'true';
    const VALOR_FALSO : STRING = 'false';
  end;

implementation

{ TIniUltis }

constructor TIniUtils.Create;
{ Cria a classe}
begin
  inherited;

end;

destructor TIniUtils.Destroy;
begin
{Destroi a classe criada }
  inherited;
end;


class procedure TIniUtils.gravarPropriedade(PSecao: TSECAO;
  PPropriedade: TPROPRIEDADE; PValor: String);
  {Implementa��o da procedures declarada acima}
var
  LcaminhoArquivoIni: String;
  LarquivoINI: TIniFile;
  LNomeSecao : String;
  LNomePropriedade : String;

begin
  LcaminhoArquivoIni := TPath.Combine(TPath.Combine(TPath.GetDocumentsPath,
    'ravin'), 'configuracoes.ini');

  LarquivoINI := TIniFile.Create(LcaminhoArquivoIni);

  LarquivoINI.WriteString(GetEnumName(TypeInfo(TSECAO), Integer(PSecao)),
    GetEnumName(TypeInfo(TPROPRIEDADE), Integer(PPropriedade)), PValor);

  LarquivoINI.Free;
end;

class function TIniUtils.lerPropriedade(PSecao: TSECAO;
  PPropriedade: TPROPRIEDADE): String;
  {Implementa��o da procedures declarada acima}
var
  LcaminhoArquivoIni: String;
  LarquivoINI: TIniFile;
begin
  LcaminhoArquivoIni := TPath.Combine(TPath.Combine(TPath.GetDocumentsPath,
    'ravin'), 'configuracoes.ini');
  LarquivoINI := TIniFile.Create(LcaminhoArquivoIni);
  Result := LarquivoINI.ReadString(GetEnumName(TypeInfo(TSECAO), Integer(PSecao)
    ), GetEnumName(TypeInfo(TPROPRIEDADE), Integer(PPropriedade)), '');
  LarquivoINI.Free;
end;

end.
