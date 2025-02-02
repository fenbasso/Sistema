program pSistema;

uses
  Vcl.Forms,
  udmConexao in 'udmConexao.pas' {dmConexao: TDataModule},
  uPadrao in 'uPadrao.pas' {frmPadrao},
  uCidades in 'uCidades.pas' {frmCidades},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uEstados in 'uEstados.pas' {frmEstados},
  uClientes in 'uClientes.pas' {frmClientes},
  uProdutos in 'uProdutos.pas' {frmProdutos},
  uPedidoVenda in 'uPedidoVenda.pas' {frmPedidoVenda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmPadrao, frmPadrao);
  Application.Run;
end.
