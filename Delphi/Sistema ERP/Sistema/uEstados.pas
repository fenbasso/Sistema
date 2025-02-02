unit uEstados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TfrmEstados = class(TfrmPadrao)
    lblEstado: TLabel;
    edtEstado: TDBEdit;
    lblUF: TLabel;
    edtUF: TDBEdit;
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
  frmEstados: TfrmEstados;

implementation

{$R *.dfm}

uses udmConexao;

{ TfrmPadrao1 }

procedure TfrmEstados.FormShow(Sender: TObject);
begin
  inherited;

  qry.Close;
  qry.SQL.Text := 'SELECT * FROM ESTADOS ORDER BY ESTADO';
  qry.Open;
end;

function TfrmEstados.fValida: Boolean;
begin
  Result := True;

  if Trim(qry.FieldByName('ESTADO').AsString) = '' then
  begin
    Result := False;

    MessageBox(Handle, 'Informe o Estado', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    edtEstado.SetFocus;
  end
  else if Trim(qry.FieldByName('UF').AsString) = '' then
  begin
    Result := False;

    MessageBox(Handle, 'Informe a UF', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    edtUF.SetFocus;
  end;
end;

procedure TfrmEstados.qryAfterCancel(DataSet: TDataSet);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmEstados.qryAfterInsert(DataSet: TDataSet);
var vqry : TFDQuery;
begin
  inherited;

  vqry := TFDQuery.Create(Nil);

  try
    vqry.Close;
    vqry.Connection := dmConexao.Conexao;
    vqry.SQL.Text := 'select max(codigoestado) +1 as codigo from estados';
    vqry.Open;

    qry.FieldByName('CODIGOESTADO').AsInteger := vqry.FieldByName('CODIGO').AsInteger;
  finally
    freeandnil(vqry);
  end;
end;

procedure TfrmEstados.qryAfterPost(DataSet: TDataSet);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmEstados.qryBeforeEdit(DataSet: TDataSet);
begin
  inherited;

  pgcDados.ActivePageIndex := 1;
  edtEstado.SetFocus;
end;

procedure TfrmEstados.qryBeforeInsert(DataSet: TDataSet);
begin
  inherited;

  pgcDados.ActivePageIndex := 1;
  edtEstado.SetFocus;
end;

procedure TfrmEstados.qryBeforePost(DataSet: TDataSet);
begin
  inherited;

  if not fValida then
  begin
    Abort;
  end;
end;

end.
