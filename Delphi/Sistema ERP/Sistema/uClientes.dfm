inherited frmClientes: TfrmClientes
  Caption = 'Clientes'
  TextHeight = 15
  inherited GroupBox1: TGroupBox
    ExplicitLeft = 0
    ExplicitTop = 50
    ExplicitWidth = 624
    ExplicitHeight = 391
    inherited pgcDados: TPageControl
      ActivePage = tbsVisualizacao
      ExplicitWidth = 620
      ExplicitHeight = 372
      inherited tbsVisualizacao: TTabSheet
        inherited dbgVisualizacao: TDBGrid
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          Columns = <
            item
              Expanded = False
              FieldName = 'CODIGO'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME'
              Title.Caption = 'Nome'
              Width = 250
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CIDADE'
              Title.Caption = 'Cidade'
              Width = 250
              Visible = True
            end>
        end
      end
      inherited tbsDados: TTabSheet
        object lblNome: TLabel [1]
          Left = 16
          Top = 72
          Width = 33
          Height = 15
          Caption = 'Nome'
        end
        object lblCidade: TLabel [2]
          Left = 16
          Top = 128
          Width = 37
          Height = 15
          Caption = 'Cidade'
        end
        inherited edtCodigo: TDBEdit
          DataField = 'CODIGO'
        end
        object edtNome: TDBEdit
          Left = 16
          Top = 93
          Width = 313
          Height = 23
          DataField = 'NOME'
          DataSource = dts
          TabOrder = 1
        end
        object cmbCidade: TDBLookupComboBox
          Left = 16
          Top = 148
          Width = 193
          Height = 23
          DataField = 'CODIGOCIDADE'
          DataSource = dts
          KeyField = 'CODIGOCIDADE'
          ListField = 'CIDADE'
          ListSource = dtsCidades
          TabOrder = 2
        end
      end
    end
  end
  inherited DBNavigator1: TDBNavigator
    Hints.Strings = ()
    ConfirmDelete = False
    ExplicitTop = 0
    ExplicitWidth = 624
  end
  inherited qry: TFDQuery
    BeforeInsert = qryBeforeInsert
    AfterInsert = qryAfterInsert
    BeforeEdit = qryBeforeEdit
    BeforePost = qryBeforePost
    AfterCancel = qryAfterCancel
  end
  object dtsCidades: TDataSource
    DataSet = qryCidades
    Left = 480
    Top = 280
  end
  object qryCidades: TFDQuery
    BeforePost = qryBeforePost
    BeforeDelete = qryBeforeDelete
    Connection = dmConexao.Conexao
    Left = 480
    Top = 344
  end
end
