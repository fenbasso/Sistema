inherited frmProdutos: TfrmProdutos
  Caption = 'Produtos'
  ClientHeight = 442
  ClientWidth = 628
  TextHeight = 15
  inherited GroupBox1: TGroupBox
    Width = 628
    Height = 392
    ExplicitLeft = 0
    ExplicitTop = 50
    ExplicitWidth = 624
    ExplicitHeight = 391
    inherited pgcDados: TPageControl
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
              FieldName = 'DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 250
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRECOVENDA'
              Title.Caption = 'Pre'#231'o de Venda'
              Width = 120
              Visible = True
            end>
        end
      end
      inherited tbsDados: TTabSheet
        object lblDescricao: TLabel [1]
          Left = 16
          Top = 72
          Width = 51
          Height = 15
          Caption = 'Descri'#231#227'o'
        end
        object lblPrecoVenda: TLabel [2]
          Left = 16
          Top = 128
          Width = 81
          Height = 15
          Caption = 'Pre'#231'o de Venda'
        end
        inherited edtCodigo: TDBEdit
          DataField = 'CODIGO'
        end
        object edtDescricao: TDBEdit
          Left = 16
          Top = 93
          Width = 313
          Height = 23
          DataField = 'DESCRICAO'
          DataSource = dts
          TabOrder = 1
        end
        object edtPrecoVenda: TDBEdit
          Left = 16
          Top = 149
          Width = 97
          Height = 23
          DataField = 'PRECOVENDA'
          DataSource = dts
          TabOrder = 2
        end
      end
    end
  end
  inherited DBNavigator1: TDBNavigator
    Width = 628
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
end
