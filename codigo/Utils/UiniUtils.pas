unit UiniUtils;

interface

uses
  System.IOUtils,

  Vcl.Forms,

  TypInfo,
  IniFiles;

type
{NO TSECAO se colocam os titulos dos blocos de informação dos arquivos ini e
tem que ser igual ao que vai ser chamado no método
usar para ordenar as informações, para detalhes localizar estas informações no
arquivo configurações.ini}
  TSECAO = (CONFIGURACOES, INFORMACOES_GERAIS, DATABASE, LOGINFO, BANCO);

type
{ NO TPROPRIEDADE se colocam as informações que ficam nas linhas abaixo dos titulos
e que são os dados que se busca}
  TPROPRIEDADE = (SERVER, DATAHORA_ULTIMO_lOGIN, USERNAME, PASSWORD, DRIVERID, PORT, PATH, LOGADO);
  {ATENCAO ESTES DOIS ITENS EM CONJUNTO FORMAM OS ENUMERADORES}

{OUTRA FORMA DE FAZER:

TPROPRIEDADE_BANCO (SERVER, USERNAME, PASSWORD)

SE FIZER ASSIM, NÃO PRECISA COLOCAR OS DOIS ITENS ANTERIORES, MAS TEM QUE DECLARAR TODAS INDIVIDUALMENTE)
}

type
{A seguir, vão os importados para fazer os metodos funcionar}
  TIniUtils = class
  private

  protected

  public
    constructor Create();
    destructor Destroy; override;
  { Aqui se declaram as procedures que vão ser chamadas pelas units quando necessário
  neste caso, estão duas procedures do tipo CLASS que vão ler e gravar o arquivo ini
  a primeira vai gravar, utilizando os parametros definidos no TSECAO e TPROPRIEDADE}
     class procedure gravarPropriedade(PSecao: TSECAO;
      PPropriedade: TPROPRIEDADE; PValor: String);
  { Esta procedure vai ler as propriedades já registradas no ini, veja que as procedures
  ficam prontas mas somente serão utilizadas quando chamadas nas outras units}
    class function lerPropriedade(PSecao: TSECAO;
      PPropriedade: TPROPRIEDADE): String;
  { Aqui, definição de uma constante para ser utilizada sempre que se colocar verdadeiro ou falso }
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
  {Implementação da procedures declarada acima}
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
  {Implementação da procedures declarada acima}
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
