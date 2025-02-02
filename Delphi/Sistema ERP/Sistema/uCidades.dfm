inherited frmCidades: TfrmCidades
  Caption = 'Cidades'
  TextHeight = 15
  inherited GroupBox1: TGroupBox
    inherited pgcDados: TPageControl
      ActivePage = tbsVisualizacao
      ExplicitWidth = 624
      ExplicitHeight = 364
      inherited tbsVisualizacao: TTabSheet
        inherited dbgVisualizacao: TDBGrid
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          Columns = <
            item
              Expanded = False
              FieldName = 'CODIGOCIDADE'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CIDADE'
              Title.Caption = 'Cidade'
              Width = 250
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ESTADO'
              Title.Caption = 'Estado'
              Width = 200
              Visible = True
            end>
        end
      end
      inherited tbsDados: TTabSheet
        object lblCidade: TLabel [1]
          Left = 16
          Top = 72
          Width = 37
          Height = 15
          Caption = 'Cidade'
        end
        object lblEstado: TLabel [2]
          Left = 16
          Top = 128
          Width = 35
          Height = 15
          Caption = 'Estado'
        end
        inherited edtCodigo: TDBEdit
          DataField = 'CODIGOCIDADE'
        end
        object edtCidade: TDBEdit
          Left = 16
          Top = 93
          Width = 313
          Height = 23
          DataField = 'CIDADE'
          DataSource = dts
          TabOrder = 1
        end
        object cmbEstado: TDBLookupComboBox
          Left = 16
          Top = 148
          Width = 193
          Height = 23
          DataField = 'CODIGOESTADO'
          DataSource = dts
          KeyField = 'CODIGOESTADO'
          ListField = 'ESTADO'
          ListSource = dtsEstados
          TabOrder = 2
        end
      end
    end
  end
  inherited DBNavigator1: TDBNavigator
    Hints.Strings = ()
    ConfirmDelete = False
  end
  inherited qry: TFDQuery
    BeforeInsert = qryBeforeInsert
    AfterInsert = qryAfterInsert
    BeforeEdit = qryBeforeEdit
    BeforePost = qryBeforePost
    AfterCancel = qryAfterCancel
  end
  object dtsEstados: TDataSource
    DataSet = qryEstados
    Left = 480
    Top = 280
  end
  object qryEstados: TFDQuery
    BeforePost = qryBeforePost
    BeforeDelete = qryBeforeDelete
    Connection = dmConexao.Conexao
    Left = 480
    Top = 344
  end
end
