unit uProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TfrmProdutos = class(TfrmPadrao)
    lblDescricao: TLabel;
    edtDescricao: TDBEdit;
    lblPrecoVenda: TLabel;
    edtPrecoVenda: TDBEdit;
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
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

uses udmConexao;

{ TfrmPadrao1 }

procedure TfrmProdutos.FormShow(Sender: TObject);
begin
  inherited;

  qry.Close;
  qry.SQL.Text := 'SELECT * FROM PRODUTOS ORDER BY DESCRICAO';
  qry.Open;

  TFloatField(qry.FieldByName('PRECOVENDA')).DisplayFormat := 'R$ #,##0.00';
end;

function TfrmProdutos.fValida: Boolean;
begin
  Result := True;

  if Trim(qry.FieldByName('DESCRICAO').AsString) = '' then
  begin
    Result := False;

    MessageBox(Handle, 'Informe a Descri��o do Produto', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    edtDescricao.SetFocus;
  end
  else if Trim(qry.FieldByName('PRECOVENDA').AsString) = '' then
  begin
    Result := False;

    MessageBox(Handle, 'Informe o Pre�o de Venda', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    edtPrecoVenda.SetFocus;
  end
  else
  begin
    TRY
      StrToFloat(qry.FieldByName('PRECOVENDA').AsString);
    EXCEPT
      Result := False;

      MessageBox(Handle, 'Valor inv�lido para o Pre�o de Venda', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

      edtPrecoVenda.SetFocus;
    END;
  end;
end;

procedure TfrmProdutos.qryAfterCancel(DataSet: TDataSet);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmProdutos.qryAfterInsert(DataSet: TDataSet);
var vqry : TFDQuery;
begin
  inherited;

  vqry := TFDQuery.Create(Nil);

  try
    vqry.Close;
    vqry.Connection := dmConexao.Conexao;
    vqry.SQL.Text := 'select max(codigo) +1 as codigo from produtos';
    vqry.Open;

    qry.FieldByName('codigo').AsInteger := vqry.FieldByName('CODIGO').AsInteger;
  finally
    freeandnil(vqry);
  end;
end;

procedure TfrmProdutos.qryAfterPost(DataSet: TDataSet);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmProdutos.qryBeforeEdit(DataSet: TDataSet);
begin
  inherited;

  pgcDados.ActivePageIndex := 1;
  edtDescricao.SetFocus;
end;

procedure TfrmProdutos.qryBeforeInsert(DataSet: TDataSet);
begin
  inherited;

  pgcDados.ActivePageIndex := 1;
  edtDescricao.SetFocus;
end;

procedure TfrmProdutos.qryBeforePost(DataSet: TDataSet);
begin
  inherited;

  if not fValida then
  begin
    Abort;
  end;
end;

end.
