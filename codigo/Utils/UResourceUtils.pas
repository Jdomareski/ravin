unit UResourceUtils;

interface

uses
  System.IOUtils,
  System.SysUtils,
  System.Classes;

type
  TResourceUtils = Class(TObject)

  Private

  Protected

  public
    Class function CarregarArquivoResource(PNomeArquivo: String;
      PNomeAplicacao: String): String;
  end;

implementation

Class function TResourceUtils.CarregarArquivoResource(PNomeArquivo: String;
  PNomeAplicacao: String): String;
var
  LConteudoArquivo: TStringlist;
  LCaminhoArquivo: String;
  LCaminhoPastaAplicacao: String;
  LconteudoTexto: String;

Begin
  Try
    LConteudoArquivo := TStringlist.Create();
    LconteudoTexto := '';
    try
      LCaminhoPastaAplicacao := TPath.Combine(TPath.GetDocumentsPath,
        PNomeAplicacao);
      LCaminhoArquivo := TPath.Combine(LCaminhoPastaAplicacao, PNomeArquivo);

      LConteudoArquivo.LoadFromFile(LCaminhoArquivo);
      LconteudoTexto := LConteudoArquivo.Text;

    Except
      on E: Exception do
        raise Exception.Create('Erro ao carregar arquivo do resource.' +
          'Arquivo: ' + PNomeArquivo);
    end;

  Finally

    LConteudoArquivo.free;

  End;

  Result := LconteudoTexto;
End;

end.
