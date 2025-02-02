unit uPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask;

type
  TfrmPadrao = class(TForm)
    GroupBox1: TGroupBox;
    DBNavigator1: TDBNavigator;
    pgcDados: TPageControl;
    tbsVisualizacao: TTabSheet;
    tbsDados: TTabSheet;
    qry: TFDQuery;
    dts: TDataSource;
    dbgVisualizacao: TDBGrid;
    lblCodigo: TLabel;
    edtCodigo: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure qryBeforeDelete(DataSet: TDataSet);
    procedure qryAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  frmPadrao: TfrmPadrao;

implementation

{$R *.dfm}

uses udmConexao;

procedure TfrmPadrao.FormCreate(Sender: TObject);
begin
  tbsVisualizacao.TabVisible  := False;
  tbsDados.TabVisible         := False;
end;

procedure TfrmPadrao.FormShow(Sender: TObject);
begin
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmPadrao.qryAfterPost(DataSet: TDataSet);
begin
  qry.Refresh;
end;

procedure TfrmPadrao.qryBeforeDelete(DataSet: TDataSet);
begin
  if qry.Active and (not qry.IsEmpty) then
  begin
    if MessageBox(Handle, 'Deseja realmente Excluir o Registro?', 'Aten��o', MB_ICONQUESTION or MB_YESNO) = IDNO then
    begin
      Abort;
    end;
  end;
end;

end.
