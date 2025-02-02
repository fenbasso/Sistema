unit uPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Async,
  FireDAC.DApt, Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TfrmPedidoVenda = class(TForm)
    memProdutos: TFDMemTable;
    Bar: TStatusBar;
    dtsProdutos: TDataSource;
    memProdutosCODIGOPRODUTO: TIntegerField;
    memProdutosQUANTIDADE: TIntegerField;
    memProdutosVALORUNITARIO: TFloatField;
    memProdutosVALORTOTAL: TFloatField;
    memProdutosDESCRICAOPRODUTO: TStringField;
    pnDados: TPanel;
    lblCodigo: TLabel;
    edtCodigoProduto: TEdit;
    lblCodigoCliente: TLabel;
    edtCodigoCliente: TEdit;
    lblCliente: TLabel;
    lblProduto: TLabel;
    lblQuantidade: TLabel;
    edtQuantidade: TEdit;
    lblVlrUnitario: TLabel;
    edtVlrUnitario: TEdit;
    btnGravarProduto: TButton;
    btnExcluirProduto: TButton;
    dbgProdutos: TDBGrid;
    qry: TFDQuery;
    btnGravarPedido: TButton;
    btnCarregarPedido: TButton;
    btnCancelarPedido: TButton;
    procedure btnGravarProdutoClick(Sender: TObject);
    procedure btnExcluirProdutoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure memProdutosBeforePost(DataSet: TDataSet);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure memProdutosAfterPost(DataSet: TDataSet);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnCarregarPedidoClick(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure dbgProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function fValida : Boolean;
    function fValidaProdutos : Boolean;
    function fCalculaTotalItem : Double;
    function fCalculaTotal : Double;
    function fBuscaProduto(vProduto : String) : String;
  public
    { Public declarations }
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

{$R *.dfm}

uses udmConexao;

procedure TfrmPedidoVenda.btnCancelarPedidoClick(Sender: TObject);
var vNumPedido : String;
begin
  vNumPedido := InputBox('Pedido', 'Informe o n�mero do Pedido', '');

  if Trim(vNumPedido) <> '' then
  begin
    if MessageBox(Handle, PChar('Deseja realmente Excluir o Pedido ' + vNumPedido + '?'), 'Aten��o', MB_ICONQUESTION or MB_YESNO) = IDNO then
      Exit;

    qry.Connection.StartTransaction;

    TRY
      qry.Close;
      qry.SQL.Text := 'Delete FROM PEDIDOSPRODUTOS WHERE NUMEROPEDIDO = :pNUMEROPEDIDO';
      qry.Params.ParamByName('pNUMEROPEDIDO').AsString := vNumPedido;
      qry.ExecSQL;

      qry.Close;
      qry.SQL.Text := 'Delete FROM PEDIDOSDADOSGERAIS WHERE NUMEROPEDIDO = :pNUMEROPEDIDO';
      qry.Params.ParamByName('pNUMEROPEDIDO').AsString := vNumPedido;
      qry.ExecSQL;

      qry.Connection.Commit;

      MessageBox(Handle, 'Pedido exclu�do com Sucesso!', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);
    EXCEPT
      on E : Exception do
      begin
        MessageBox(Handle, PChar('Ocorreu um erro ao Excluir o Pedido!' + #13#10 + E.Message), 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

        qry.Connection.Rollback;
      end;
    END;

    Bar.Panels[1].Text := '';
    memProdutos.EmptyDataSet;
  end;
end;

procedure TfrmPedidoVenda.btnCarregarPedidoClick(Sender: TObject);
var vNumPedido : String;
begin
  Bar.Panels[1].Text := '';
  memProdutos.EmptyDataSet;

  vNumPedido := InputBox('Pedido', 'Informe o n�mero do Pedido', '');

  if Trim(vNumPedido) <> '' then
  begin
    qry.Close;
    qry.SQL.Text := 'Select * FROM PEDIDOSDADOSGERAIS WHERE NUMEROPEDIDO = :pNUMEROPEDIDO';
    qry.Params.ParamByName('pNUMEROPEDIDO').AsString := vNumPedido;
    qry.Open;

    if qry.IsEmpty then
      MessageBox(Handle, 'Pedido inv�lido!', 'Aten��o', MB_ICONEXCLAMATION or MB_OK)
    else
      edtCodigoCliente.Text := qry.FieldByName('CODIGOCLIENTE').AsString;

    qry.Close;
    qry.SQL.Text := 'Select * FROM PEDIDOSPRODUTOS WHERE NUMEROPEDIDO = :pNUMEROPEDIDO';
    qry.Params.ParamByName('pNUMEROPEDIDO').AsString := vNumPedido;
    qry.Open;

    qry.First;
    while not qry.Eof do
    begin
      memProdutos.Insert;
      memProdutosCODIGOPRODUTO.AsString     := qry.FieldByName('CODIGOPRODUTO').AsString;
      memProdutosDESCRICAOPRODUTO.AsString  := fBuscaProduto(memProdutosCODIGOPRODUTO.AsString);
      memProdutosQUANTIDADE.AsString        := qry.FieldByName('QUANTIDADE').AsString;
      memProdutosVALORUNITARIO.AsString     := qry.FieldByName('VALORUNITARIO').AsString;
      memProdutos.Post;

      qry.Next;
    end;
  end;
end;

procedure TfrmPedidoVenda.btnExcluirProdutoClick(Sender: TObject);
begin
  if memProdutos.Active and (not memProdutos.IsEmpty) then
  begin
    if MessageBox(Handle, 'Deseja realmente Excluir o Produto?', 'Aten��o', MB_ICONQUESTION or MB_YESNO) = IDNO then
      Exit;

    memProdutos.Delete;
  end;
end;

procedure TfrmPedidoVenda.btnGravarPedidoClick(Sender: TObject);
var vNumPedido : Integer;
begin
  if fValida then
  begin
    qry.Close;
    qry.SQL.Text := 'Select Max(NUMEROPEDIDO) +1 as NUMEROPEDIDO From PEDIDOSDADOSGERAIS';
    qry.Open;

    vNumPedido := qry.FieldByName('NUMEROPEDIDO').AsInteger;

    qry.Connection.StartTransaction;

    TRY
      qry.Close;
      qry.SQL.Text := 'Insert into PEDIDOSDADOSGERAIS Values (:pNUMEROPEDIDO, :pDATAEMISSAO, :pCODIGOCLIENTE, :pVALORTOTAL)';
      qry.Params.ParamByName('pNUMEROPEDIDO').AsInteger   := vNumPedido;
      qry.Params.ParamByName('pDATAEMISSAO').AsDate       := Date;
      qry.Params.ParamByName('pCODIGOCLIENTE').AsInteger  := StrToInt(edtCodigoCliente.Text);
      qry.Params.ParamByName('pVALORTOTAL').AsFloat       := fCalculaTotal;
      qry.ExecSQL;

      memProdutos.First;
      while not memProdutos.Eof do
      begin
        qry.Close;
        qry.SQL.Text := 'Insert into PEDIDOSPRODUTOS (NUMEROPEDIDO, CODIGOPRODUTO, QUANTIDADE, VALORUNITARIO, VALORTOTAL) values '
                      + '                            (:pNUMEROPEDIDO, :pCODIGOPRODUTO, :pQUANTIDADE, :pVALORUNITARIO, :pVALORTOTAL)';
        qry.Params.ParamByName('pNUMEROPEDIDO').AsInteger   := vNumPedido;
        qry.Params.ParamByName('pCODIGOPRODUTO').AsInteger  := memProdutosCODIGOPRODUTO.AsInteger;
        qry.Params.ParamByName('pQUANTIDADE').AsFloat       := memProdutosQUANTIDADE.AsFloat;
        qry.Params.ParamByName('pVALORUNITARIO').AsFloat    := memProdutosVALORUNITARIO.AsFloat;
        qry.Params.ParamByName('pVALORTOTAL').AsFloat       := memProdutosVALORTOTAL.AsFloat;
        qry.ExecSQL;

        memProdutos.Next;
      end;

      qry.Connection.Commit;
    EXCEPT
      on E : Exception do
      begin
        qry.Connection.Rollback;

        MessageBox(Handle, PChar('Ocorreu um erro ao gravar o Pedido!' + #13#10 + E.Message), 'Aten��o', MB_ICONEXCLAMATION or MB_OK);
      end;
    END;
  end;
end;

procedure TfrmPedidoVenda.btnGravarProdutoClick(Sender: TObject);
begin
  if memProdutos.Active and (memProdutos.State = dsEdit) then
    memProdutos.Post
  else if fValidaProdutos then
  begin
    memProdutos.Insert;
    memProdutosCODIGOPRODUTO.AsString     := Trim(edtCodigoProduto.Text);
    memProdutosDESCRICAOPRODUTO.AsString  := lblProduto.Caption;
    memProdutosQUANTIDADE.AsString        := Trim(edtQuantidade.Text);
    memProdutosVALORUNITARIO.AsString     := Trim(edtVlrUnitario.Text);
    memProdutos.Post;

    Bar.Panels[1].Text := FormatFloat('R$ #,##0.00', fCalculaTotal);
  end;

  edtCodigoProduto.Clear;
  edtQuantidade.Clear;
end;

procedure TfrmPedidoVenda.dbgProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = VK_DELETE) then
    Key := 0
  else if Key = VK_DELETE then
    btnExcluirProduto.Click;
end;

procedure TfrmPedidoVenda.edtCodigoClienteChange(Sender: TObject);
begin
  btnCarregarPedido.Enabled := Trim(edtCodigoCliente.Text) = '';
  btnCancelarPedido.Enabled := Trim(edtCodigoCliente.Text) = '';
end;

procedure TfrmPedidoVenda.edtCodigoClienteExit(Sender: TObject);
begin
  if Trim(edtCodigoCliente.Text) <> '' then
  begin
    qry.Close;
    qry.SQL.Text := 'SELECT CODIGO, NOME FROM CLIENTES WHERE CODIGO = :pCodigo';
    qry.Params.ParamByName('pCodigo').AsString := Trim(edtCodigoCliente.Text);
    qry.Open;

    if qry.IsEmpty then
    begin
      MessageBox(Handle, 'Cliente inv�lido!', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

      edtCodigoCliente.SetFocus;
    end
    else
      lblCliente.Caption := qry.FieldByName('NOME').AsString;
  end;
end;

procedure TfrmPedidoVenda.edtCodigoProdutoExit(Sender: TObject);
begin
  if Trim(edtCodigoProduto.Text) <> '' then
  begin
    lblProduto.Caption := fBuscaProduto(Trim(edtCodigoProduto.Text));

    if Trim(lblProduto.Caption) = '' then
    begin
      MessageBox(Handle, 'Produto inv�lido!', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

      edtCodigoProduto.SetFocus;
    end
    else
      edtVlrUnitario.Text := FormatFloat('#,##0.00', qry.FieldByName('PRECOVENDA').AsFloat);
  end;
end;

procedure TfrmPedidoVenda.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', Chr(8)]) then
    Key := #0;
end;

function TfrmPedidoVenda.fCalculaTotalItem: Double;
begin
  Result := 0;

  if memProdutos.Active and (not memProdutos.IsEmpty) and (memProdutos.State in [dsInsert, dsEdit]) then
    Result := memProdutosQUANTIDADE.AsFloat * memProdutosVALORUNITARIO.AsFloat;
end;

procedure TfrmPedidoVenda.FormCreate(Sender: TObject);
begin
  lblCliente.Caption := '';
  lblProduto.Caption := '';

  TFloatField(memProdutosVALORUNITARIO).DisplayFormat := 'R$ #,##0.00';
  TFloatField(memProdutosVALORTOTAL).DisplayFormat    := 'R$ #,##0.00';
end;

function TfrmPedidoVenda.fValida: Boolean;
begin
  Result := True;

  if (Trim(edtCodigoCliente.Text) = '') or (lblCliente.Caption = '') then
  begin
    Result := False;

    MessageBox(Handle, 'Informe o Cliente', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    edtCodigoCliente.SetFocus;
  end
  else if (Trim(edtCodigoProduto.Text) = '') or (lblProduto.Caption = '') then
  begin
    Result := False;

    MessageBox(Handle, 'Informe o Produto', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    edtCodigoProduto.SetFocus;
  end
  else if memProdutos.IsEmpty then
  begin
    Result := False;

    MessageBox(Handle, 'N�o h� Produtos inclu�dos para o Pedido', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    edtCodigoProduto.SetFocus;
  end
end;

function TfrmPedidoVenda.fValidaProdutos: Boolean;
begin
  Result := True;

  if (Trim(edtCodigoProduto.Text) = '') or (Trim(lblProduto.Caption) = '') then
  begin
    Result := False;

    MessageBox(Handle, 'Informe o Produto', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    edtCodigoProduto.SetFocus;
  end
  else if Trim(edtQuantidade.Text) = '' then
  begin
    Result := False;

    MessageBox(Handle, 'Informe a Quantidade', 'Aten��o', MB_ICONEXCLAMATION or MB_OK);

    edtQuantidade.SetFocus;
  end;
end;

procedure TfrmPedidoVenda.memProdutosAfterPost(DataSet: TDataSet);
begin
  Bar.Panels[1].Text := FormatFloat('R$ #,##0.00', fCalculaTotal);
end;

procedure TfrmPedidoVenda.memProdutosBeforePost(DataSet: TDataSet);
begin
  memProdutosVALORTOTAL.AsFloat := fCalculaTotalItem;
end;

function TfrmPedidoVenda.fBuscaProduto(vProduto : String): String;
var qry2 : TFDQuery;
begin
  if Trim(vProduto) <> '' then
  begin
    qry2 := TFDQuery.Create(Nil);

    TRY
      qry2.Close;
      qry2.Connection := dmConexao.Conexao;
      qry2.SQL.Text   := 'SELECT DESCRICAO, PRECOVENDA FROM PRODUTOS WHERE CODIGO = :pCodigo';
      qry2.Params.ParamByName('pCodigo').AsString := Trim(vProduto);
      qry2.Open;

      Result := qry2.FieldByName('DESCRICAO').AsString;
    FINALLY
      qry2.Close;

      FreeAndNil(qry2);
    END;
  end;
end;

function TfrmPedidoVenda.fCalculaTotal : Double;
var vTotal : Double;
begin
  Result := 0;

  if memProdutos.Active and (memProdutos.RecordCount > 0) then
  begin
    vTotal := 0;

    memProdutos.First;
    while not memProdutos.Eof do
    begin
      vTotal := vTotal + memProdutos.FieldByName('VALORTOTAL').AsFloat;

      memProdutos.Next;
    end;

    Result := vTotal;
  end;
end;

end.
