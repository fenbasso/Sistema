unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    mniCadastro: TMenuItem;
    mniCidades: TMenuItem;
    mniEstados: TMenuItem;
    mniClientes: TMenuItem;
    mniProdutos: TMenuItem;
    mniMovimentação: TMenuItem;
    mniPedidoVenda: TMenuItem;
    procedure mniCidadesClick(Sender: TObject);
    procedure mniEstadosClick(Sender: TObject);
    procedure mniClientesClick(Sender: TObject);
    procedure mniProdutosClick(Sender: TObject);
    procedure mniPedidoVendaClick(Sender: TObject);
  private
    procedure pConectaBanco;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uCidades, udmConexao, uEstados, uClientes, uProdutos, uPedidoVenda;

procedure TfrmPrincipal.mniCidadesClick(Sender: TObject);
begin
  frmCidades := TfrmCidades.Create(Nil);

  try
    frmCidades.ShowModal;
  finally
    FreeAndNil(frmCidades);
  end;
end;

procedure TfrmPrincipal.mniClientesClick(Sender: TObject);
begin
  frmClientes := TfrmClientes.Create(Nil);

  try
    frmClientes.ShowModal;
  finally
    FreeAndNil(frmClientes);
  end;
end;

procedure TfrmPrincipal.mniEstadosClick(Sender: TObject);
begin
  frmEstados := TfrmEstados.Create(Nil);

  try
    frmEstados.ShowModal;
  finally
    FreeAndNil(frmEstados);
  end;
end;

procedure TfrmPrincipal.mniPedidoVendaClick(Sender: TObject);
begin
  frmPedidoVenda := TfrmPedidoVenda.Create(Nil);

  try
    frmPedidoVenda.ShowModal;
  finally
    FreeAndNil(frmPedidoVenda);
  end;
end;

procedure TfrmPrincipal.mniProdutosClick(Sender: TObject);
begin
  frmProdutos := TfrmProdutos.Create(Nil);

  try
    frmProdutos.ShowModal;
  finally
    FreeAndNil(frmProdutos);
  end;
end;

procedure TfrmPrincipal.pConectaBanco;
begin
  try
    dmConexao.Conexao.Connected := True;
  except
    on e : Exception do
    begin
      MessageBox(Handle, PChar('Ocorreu um Erro ao conectar o Banco de Dados!' + #13#10 + E.Message), 'Atenção', MB_ICONEXCLAMATION or MB_OK);
    end;
  end;
end;

initialization
  RegisterClass(TfrmCidades);

end.
