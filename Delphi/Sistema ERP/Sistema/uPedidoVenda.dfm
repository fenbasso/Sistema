object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pedido de Venda'
  ClientHeight = 348
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Bar: TStatusBar
    Left = 0
    Top = 329
    Width = 628
    Height = 19
    Panels = <
      item
        Text = 'Valor Pedido:'
        Width = 100
      end
      item
        Text = 'R$ 0,00'
        Width = 50
      end>
    ExplicitTop = 376
    ExplicitWidth = 624
  end
  object pnDados: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 329
    Align = alClient
    TabOrder = 0
    ExplicitTop = 8
    ExplicitHeight = 347
    object lblCodigo: TLabel
      Left = 16
      Top = 96
      Width = 43
      Height = 15
      Caption = 'Produto'
    end
    object lblCodigoCliente: TLabel
      Left = 16
      Top = 48
      Width = 37
      Height = 15
      Caption = 'Cliente'
    end
    object lblCliente: TLabel
      Left = 80
      Top = 73
      Width = 39
      Height = 15
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblProduto: TLabel
      Left = 80
      Top = 121
      Width = 45
      Height = 15
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuantidade: TLabel
      Left = 16
      Top = 144
      Width = 62
      Height = 15
      Caption = 'Quantidade'
    end
    object lblVlrUnitario: TLabel
      Left = 144
      Top = 144
      Width = 71
      Height = 15
      Caption = 'Valor Unitario'
    end
    object edtCodigoProduto: TEdit
      Left = 16
      Top = 117
      Width = 57
      Height = 23
      TabOrder = 1
      OnExit = edtCodigoProdutoExit
      OnKeyPress = edtQuantidadeKeyPress
    end
    object edtCodigoCliente: TEdit
      Left = 16
      Top = 69
      Width = 57
      Height = 23
      TabOrder = 0
      OnChange = edtCodigoClienteChange
      OnExit = edtCodigoClienteExit
      OnKeyPress = edtQuantidadeKeyPress
    end
    object edtQuantidade: TEdit
      Left = 16
      Top = 165
      Width = 121
      Height = 23
      TabOrder = 2
      OnKeyPress = edtQuantidadeKeyPress
    end
    object edtVlrUnitario: TEdit
      Left = 144
      Top = 165
      Width = 121
      Height = 23
      Enabled = False
      TabOrder = 3
    end
    object btnGravarProduto: TButton
      Left = 271
      Top = 165
      Width = 97
      Height = 23
      Caption = 'Gravar Produto'
      TabOrder = 4
      OnClick = btnGravarProdutoClick
    end
    object btnExcluirProduto: TButton
      Left = 375
      Top = 165
      Width = 97
      Height = 23
      Caption = 'Excluir Produto'
      TabOrder = 5
      OnClick = btnExcluirProdutoClick
    end
    object dbgProdutos: TDBGrid
      Left = 1
      Top = 208
      Width = 626
      Height = 120
      Align = alBottom
      DataSource = dtsProdutos
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnKeyDown = dbgProdutosKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGOPRODUTO'
          ReadOnly = True
          Title.Caption = 'C'#243'd. Produto'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAOPRODUTO'
          ReadOnly = True
          Title.Caption = 'Descri'#231#227'o'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Caption = 'Quantidade'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORUNITARIO'
          Title.Caption = 'Valor Unit'#225'rio'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORTOTAL'
          ReadOnly = True
          Title.Caption = 'Valor Total'
          Width = 90
          Visible = True
        end>
    end
    object btnGravarPedido: TButton
      Left = 16
      Top = 13
      Width = 97
      Height = 23
      Caption = 'Gravar Pedido'
      TabOrder = 7
      OnClick = btnGravarPedidoClick
    end
    object btnCarregarPedido: TButton
      Left = 120
      Top = 13
      Width = 97
      Height = 23
      Caption = 'Carregar Pedido'
      TabOrder = 8
      OnClick = btnCarregarPedidoClick
    end
    object btnCancelarPedido: TButton
      Left = 224
      Top = 13
      Width = 97
      Height = 23
      Caption = 'Cancelar Pedido'
      TabOrder = 9
      OnClick = btnCancelarPedidoClick
    end
  end
  object memProdutos: TFDMemTable
    Active = True
    BeforePost = memProdutosBeforePost
    AfterPost = memProdutosAfterPost
    AfterDelete = memProdutosAfterPost
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 272
    Top = 272
    object memProdutosCODIGOPRODUTO: TIntegerField
      FieldName = 'CODIGOPRODUTO'
    end
    object memProdutosDESCRICAOPRODUTO: TStringField
      FieldName = 'DESCRICAOPRODUTO'
      Size = 100
    end
    object memProdutosQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object memProdutosVALORUNITARIO: TFloatField
      FieldName = 'VALORUNITARIO'
    end
    object memProdutosVALORTOTAL: TFloatField
      FieldName = 'VALORTOTAL'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = memProdutos
    Left = 272
    Top = 216
  end
  object qry: TFDQuery
    Connection = dmConexao.Conexao
    Left = 200
    Top = 271
  end
end
