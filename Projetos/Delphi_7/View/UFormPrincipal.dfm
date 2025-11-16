object FormPrincipal: TFormPrincipal
  Left = 450
  Top = 203
  BorderStyle = bsSingle
  ClientHeight = 439
  ClientWidth = 756
  Color = 8404992
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    756
    439)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 49
    Width = 73
    Height = 13
    Caption = 'Valor a receber'
  end
  object Label2: TLabel
    Left = 360
    Top = 8
    Width = 102
    Height = 13
    Caption = 'Forma de Pagamento'
  end
  object Label3: TLabel
    Left = 360
    Top = 56
    Width = 44
    Height = 13
    Caption = 'Tipo Cart'
  end
  object Label4: TLabel
    Left = 360
    Top = 151
    Width = 40
    Height = 13
    Caption = 'Parcelas'
  end
  object Label5: TLabel
    Left = 360
    Top = 103
    Width = 126
    Height = 13
    Caption = 'Modalidade do pagamento'
  end
  object sbtnGerarValor: TSpeedButton
    Left = 215
    Top = 66
    Width = 34
    Height = 50
    Caption = 'R$'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = sbtnGerarValorClick
  end
  object btn_Receber: TButton
    Left = 604
    Top = 8
    Width = 129
    Height = 50
    Anchors = [akTop, akRight]
    Caption = 'Receber Pagamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btn_ReceberClick
  end
  object Button2: TButton
    Left = 24
    Top = 8
    Width = 129
    Height = 25
    Caption = 'Configurar Tef'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object btn_Gerencial: TButton
    Left = 23
    Top = 122
    Width = 129
    Height = 50
    Anchors = [akTop, akRight]
    Caption = 'Gerencial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btn_GerencialClick
  end
  object cbbxTipoPgto: TComboBox
    Left = 360
    Top = 27
    Width = 102
    Height = 21
    Cursor = crHandPoint
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ItemIndex = 0
    ParentFont = False
    TabOrder = 4
    Text = 'Todas'
    OnChange = cbbxTipoPgtoChange
    Items.Strings = (
      'Todas'
      'Cheque'
      'D'#233'bito'
      'Cr'#233'dito'
      'Cr'#233'dito '#224' vista'
      'Carteira digital')
  end
  object cbbxTipoCartao: TComboBox
    Left = 360
    Top = 75
    Width = 102
    Height = 21
    Cursor = crHandPoint
    Style = csDropDownList
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ItemIndex = 0
    ParentFont = False
    TabOrder = 6
    Text = 'Magn'#233'tico/Chip'
    Items.Strings = (
      'Magn'#233'tico/Chip'
      'Digitado'
      'Ambos')
  end
  object sedt_Parcelas: TSpinEdit
    Left = 360
    Top = 170
    Width = 102
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxValue = 60
    MinValue = 2
    ParentFont = False
    TabOrder = 3
    Value = 2
  end
  object cbbx_ModalidadePgto: TComboBox
    Left = 360
    Top = 122
    Width = 141
    Height = 21
    Cursor = crHandPoint
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 5
    OnChange = cbbx_ModalidadePgtoChange
  end
  object EdValor: TEdit
    Left = 24
    Top = 69
    Width = 185
    Height = 41
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    Text = '100,00'
  end
  object pnl_btn_Ativar: TPanel
    Left = 160
    Top = 8
    Width = 81
    Height = 25
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = 'Iniciar'
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = pnl_btn_AtivarClick
  end
  object DBGrid2: TDBGrid
    Left = 16
    Top = 216
    Width = 721
    Height = 201
    BorderStyle = bsNone
    DataSource = DataSource1
    FixedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = 8404992
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'COD_OPERADORA'
        Title.Caption = 'C'#243'd Operadora'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BANDEIRA'
        Title.Caption = 'Bandeira'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DOCUMENTO'
        Title.Caption = 'Documento'
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NSU'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NSU_HOST'
        Title.Caption = 'NSU HOST'
        Width = 123
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Title.Caption = 'Valor R$'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PARCELA'
        Title.Caption = 'Parcela'
        Width = 85
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = FDMem_Pagamentos
    Left = 128
    Top = 360
  end
  object FDMem_Pagamentos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 360
  end
end
