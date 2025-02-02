unit uClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TfrmClientes = class(TfrmPadrao)
    lblNome: TLabel;
    edtNome: TDBEdit;
    lblCidade: TLabel;
    cmbCidade: TDBLookupComboBox;
    dtsCidades: TDataSource;
    qryCidades: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure qryBeforePost(DataSet: TDataSet);
    procedure qryBeforeInsert(DataSet: TDataSet);
    procedure qryBeforeEdit(DataSet: TDataSet);
    procedure qryAfterCancel(DataSet: TDataSet);
    procedure qryAfterPost(DataSet: TDataSet);
    procedure qryAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    function fValida: Boolean;
  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.dfm}

uses udmConexao;

{ TfrmPadrao1 }

procedure TfrmClientes.FormShow(Sender: TObject);
begin
  inherited;

  qryCidades.Close;
  qryCidades.SQL.Text := 'SELECT * FROM CIDADES ORDER BY CIDADE';
  qryCidades.Open;

  qry.Close;
  qry.SQL.Text := 'SELECT A.*, B.CIDADE '+
                  'FROM dba.CLIENTES A '+
                  'JOIN dba.CIDADES  B on B.CODIGOCIDADE = A.CODIGOCIDADE '+
                  'ORDER by A.NOME ';
  qry.Open;
end;

function TfrmClientes.fValida: Boolean;
begin
  Result := True;

  if Trim(qry.FieldByName('NOME').AsString) = '' then
  begin
    Result := False;

    MessageBox(Handle, 'Informe o Nome', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    edtNome.SetFocus;
  end
  else if Trim(qry.FieldByName('CODIGOCIDADE').AsString) = '' then
  begin
    Result := False;

    MessageBox(Handle, 'Informe a Cidade', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    cmbCidade.SetFocus;
  end;
end;

procedure TfrmClientes.qryAfterCancel(DataSet: TDataSet);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmClientes.qryAfterInsert(DataSet: TDataSet);
var vqry : TFDQuery;
begin
  inherited;

  vqry := TFDQuery.Create(Nil);

  try
    vqry.Close;
    vqry.Connection := dmConexao.Conexao;
    vqry.SQL.Text := 'select max(CODIGO) +1 as codigo from CLIENTES';
    vqry.Open;

    qry.FieldByName('CODIGO').AsInteger := vqry.FieldByName('CODIGO').AsInteger;
  finally
    freeandnil(vqry);
  end;
end;

procedure TfrmClientes.qryAfterPost(DataSet: TDataSet);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmClientes.qryBeforeEdit(DataSet: TDataSet);
begin
  inherited;

  pgcDados.ActivePageIndex := 1;
  edtNome.SetFocus;
end;

procedure TfrmClientes.qryBeforeInsert(DataSet: TDataSet);
begin
  inherited;

  pgcDados.ActivePageIndex := 1;
  edtNome.SetFocus;
end;

procedure TfrmClientes.qryBeforePost(DataSet: TDataSet);
begin
  inherited;

  if not fValida then
  begin
    Abort;
  end;
end;

end.
