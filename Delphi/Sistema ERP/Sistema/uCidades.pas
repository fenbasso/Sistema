unit uCidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TfrmCidades = class(TfrmPadrao)
    lblCidade: TLabel;
    edtCidade: TDBEdit;
    cmbEstado: TDBLookupComboBox;
    lblEstado: TLabel;
    dtsEstados: TDataSource;
    qryEstados: TFDQuery;
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
  frmCidades: TfrmCidades;

implementation

{$R *.dfm}

uses udmConexao;

{ TfrmPadrao1 }

procedure TfrmCidades.FormShow(Sender: TObject);
begin
  inherited;

  qryEstados.Close;
  qryEstados.SQL.Text := 'SELECT * FROM ESTADOS ORDER BY ESTADO';
  qryEstados.Open;

  qry.Close;
  qry.SQL.Text := 'SELECT A.*, B.ESTADO '+
                  'FROM dba.CIDADES A '+
                  'JOIN dba.ESTADOS B ON B.CODIGOESTADO = A.CODIGOESTADO '+
                  'ORDER BY A.CIDADE ';
  qry.Open;
end;

function TfrmCidades.fValida: Boolean;
begin
  Result := True;

  if Trim(qry.FieldByName('CIDADE').AsString) = '' then
  begin
    Result := False;

    MessageBox(Handle, 'Informe a Cidade', 'Atenção', MB_ICONEXCLAMATION or MB_OK);

    edtCidade.SetFocus;
  end
  else if qry.FieldByName('CODIGOESTADO').IsNull then begin
    Result := False;

    MessageBox(Handle, 'Informe o Estado', 'Atenção', MB_ICONEXCLAMATION or MB_OK);

    cmbEstado.SetFocus;
  end;
end;

procedure TfrmCidades.qryAfterCancel(DataSet: TDataSet);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmCidades.qryAfterInsert(DataSet: TDataSet);
var vqry : TFDQuery;
begin
  inherited;

  vqry := TFDQuery.Create(Nil);

  try
    vqry.Close;
    vqry.Connection := dmConexao.Conexao;
    vqry.SQL.Text := 'select max(codigocidade) +1 as codigo from cidades';
    vqry.Open;

    qry.FieldByName('CODIGOCIDADE').AsInteger := vqry.FieldByName('CODIGO').AsInteger;
  finally
    freeandnil(vqry);
  end;
end;

procedure TfrmCidades.qryAfterPost(DataSet: TDataSet);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmCidades.qryBeforeEdit(DataSet: TDataSet);
begin
  inherited;

  pgcDados.ActivePageIndex := 1;
  edtCidade.SetFocus;
end;

procedure TfrmCidades.qryBeforeInsert(DataSet: TDataSet);
begin
  inherited;

  pgcDados.ActivePageIndex := 1;
  edtCidade.SetFocus;
end;

procedure TfrmCidades.qryBeforePost(DataSet: TDataSet);
begin
  inherited;

  if not fValida then
  begin
    Abort;
  end;
end;

end.
