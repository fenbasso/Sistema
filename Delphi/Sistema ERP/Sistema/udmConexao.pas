unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Winapi.Windows, Winapi.Messages, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Forms, Vcl.Dialogs;

type
  TdmConexao = class(TDataModule)
    Conexao: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConexao.DataModuleCreate(Sender: TObject);
var i       : Integer;
    vArq    : TextFile;
    vLinha  : String;
    vArray  : Array of String;
begin
  AssignFile(vArq, 'Conexao.ini');

  Reset(vArq);

  TRY
    if IOResult <> 0 then
      MessageBox(Application.Handle, 'Ocorreu um Erro na leitura do arquivo de par�metros de Conex�o', 'Aten��o', MB_ICONEXCLAMATION or MB_OK)
    else
    begin
      i := 0;
      SetLength(vArray, 7);

      while (not eof(vArq)) do
      begin
        Readln(vArq, vLinha);

        vArray[i] := Copy(vLinha, Pos('=', vLinha) + 1, Length(vLinha));

        Inc(i);
      end;

      Conexao.DriverName := 'MySQL';

      Conexao.Params.Values['Database'] := vArray[0];
      Conexao.Params.Values['UserName'] := vArray[1];
      Conexao.Params.Values['Server']   := vArray[2];
      Conexao.Params.Values['Port']     := vArray[3];
      Conexao.Params.Values['Password'] := vArray[4];
      Conexao.Params.Values['DriverID'] := vArray[5];

      FDPhysMySQLDriverLink1.VendorLib  := vArray[6];

      TRY
        Conexao.Connected := True;
      EXCEPT
        on E : Exception do
        begin
          Conexao.Connected := False;

          MessageBox(Application.Handle, PChar('Ocorreu um ao Conectar ao Banco!' + #13#10 + E.Message), 'Aten��o', MB_ICONEXCLAMATION or MB_OK)
        end;
      END;
    end;
  FINALLY
    CloseFile(vArq);
  END;
end;

end.
