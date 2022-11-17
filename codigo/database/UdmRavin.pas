unit UdmRavin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs;

type
  TdmRavin = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
  private
    { Private declarations }
    procedure CriarTabelas ();
    procedure InserirDados ();
  public
    { Public declarations }
  end;

var
  dmRavin: TdmRavin;

implementation
uses UResourceUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject);
var
LcriarBaseDados : Boolean;
LCaminhoBaseDados: String;

begin
  LcriarBaseDados := not FileExists
    ('C:\ProgramData\MySQL\MySQL Server 8.0\Data\ravin\statusmesa.ibd');
  if LcriarBaseDados then
  begin
    CriarTabelas();
    InserirDados();
  end;
end;


procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);
var
LCaminhoBaseDados: String;
LcriarBaseDados : Boolean;


begin
LCaminhoBaseDados := ('C:\ProgramData\MySQL\MySQL Server 8.0' +
'\Data\ravin\pessoa.ibd');
LcriarBaseDados := not FileExists ('C:\ProgramData\MySQL\MySQL Server 8.0'
+ '\Data\ravin\statusmesa.ibd');
  with cnxBancoDeDados do
  begin
    params.values['Server']     := 'localhost';
    params.values['User_name']  := 'root';
    params.values['password']   := 'root';
    params.values['DriverID']   := 'Mysql';
    params.values['port']       := '3306';

    if not LcriarBaseDados then begin
    params.values['database'] := 'ravin';
  end;
  end;

end;

procedure TdmRavin.CriarTabelas;


begin
  try
    cnxBancoDeDados.ExecSQL(TResourceUtils.carregararquivoresource
      ('createTable.sql', 'ravin'));
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TdmRavin.DataModuleCreate(Sender: TObject);

begin
  if not cnxBancoDeDados.Connected then
  begin
    cnxBancoDeDados.Connected := true;
  end;
end;

procedure TdmRavin.InserirDados;
var
  LSqlArquivoScripts: TstringList;
  LCaminhoBaseDados: String;

begin
  LSqlArquivoScripts := TstringList.Create();
  LCaminhoBaseDados :=
    'C:\Users\jdomareski\Documents\delphi2Blu2022\Material Marcio\Projeto Ravin\database\inserts.sql';
  LSqlArquivoScripts.LoadFromFile(LCaminhoBaseDados);
  try
    cnxBancoDeDados.StartTransaction();
    cnxBancoDeDados.ExecSQL(LSqlArquivoScripts.Text);
    cnxBancoDeDados.commit();
  except
    on E: exception do
    begin
      cnxBancoDeDados.Rollback();
    end;

  end;

Freeandnil(LsqlArquivoScripts);

end;

end.
