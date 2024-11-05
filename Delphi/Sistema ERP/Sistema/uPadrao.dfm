object frmPadrao: TfrmPadrao
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmPadrao'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 50
    Width = 628
    Height = 392
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 624
    ExplicitHeight = 391
    object pgcDados: TPageControl
      Left = 2
      Top = 17
      Width = 624
      Height = 373
      ActivePage = tbsVisualizacao
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 620
      ExplicitHeight = 372
      object tbsVisualizacao: TTabSheet
        Caption = 'Visualiza'#231#227'o'
        object dbgVisualizacao: TDBGrid
          Left = 0
          Top = 0
          Width = 616
          Height = 343
          Align = alClient
          DataSource = dts
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
      object tbsDados: TTabSheet
        Caption = 'Dados'
        ImageIndex = 1
        object lblCodigo: TLabel
          Left = 16
          Top = 16
          Width = 39
          Height = 15
          Caption = 'C'#243'digo'
        end
        object edtCodigo: TDBEdit
          Left = 16
          Top = 37
          Width = 121
          Height = 23
          DataSource = dts
          Enabled = False
          TabOrder = 0
        end
      end
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 0
    Width = 628
    Height = 50
    DataSource = dts
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 624
  end
  object qry: TFDQuery
    AfterPost = qryAfterPost
    BeforeDelete = qryBeforeDelete
    Connection = dmConexao.Conexao
    Left = 568
    Top = 344
  end
  object dts: TDataSource
    DataSet = qry
    Left = 568
    Top = 280
  end
end
