inherited frmEstados: TfrmEstados
  Caption = 'Estados'
  ExplicitWidth = 634
  ExplicitHeight = 471
  TextHeight = 15
  inherited GroupBox1: TGroupBox
    ExplicitLeft = 0
    ExplicitTop = 50
    ExplicitWidth = 618
    ExplicitHeight = 382
    inherited pgcDados: TPageControl
      Width = 618
      Height = 364
      ExplicitWidth = 614
      ExplicitHeight = 363
      inherited tbsVisualizacao: TTabSheet
        ExplicitWidth = 610
        ExplicitHeight = 334
        inherited dbgVisualizacao: TDBGrid
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          Columns = <
            item
              Expanded = False
              FieldName = 'CODIGOESTADO'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ESTADO'
              Title.Caption = 'Estado'
              Width = 200
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UF'
              Visible = True
            end>
        end
      end
      inherited tbsDados: TTabSheet
        ExplicitWidth = 610
        ExplicitHeight = 334
        object lblEstado: TLabel [1]
          Left = 16
          Top = 72
          Width = 35
          Height = 15
          Caption = 'Estado'
        end
        object lblUF: TLabel [2]
          Left = 16
          Top = 128
          Width = 14
          Height = 15
          Caption = 'UF'
        end
        inherited edtCodigo: TDBEdit
          DataField = 'CODIGOESTADO'
        end
        object edtEstado: TDBEdit
          Left = 16
          Top = 93
          Width = 313
          Height = 23
          DataField = 'ESTADO'
          DataSource = dts
          TabOrder = 1
        end
        object edtUF: TDBEdit
          Left = 16
          Top = 149
          Width = 39
          Height = 23
          DataField = 'UF'
          DataSource = dts
          MaxLength = 2
          TabOrder = 2
        end
      end
    end
  end
  inherited DBNavigator1: TDBNavigator
    Hints.Strings = ()
    ConfirmDelete = False
    ExplicitTop = 0
    ExplicitWidth = 618
  end
  inherited qry: TFDQuery
    BeforeInsert = qryBeforeInsert
    AfterInsert = qryAfterInsert
    BeforeEdit = qryBeforeEdit
    BeforePost = qryBeforePost
    AfterCancel = qryAfterCancel
  end
end
