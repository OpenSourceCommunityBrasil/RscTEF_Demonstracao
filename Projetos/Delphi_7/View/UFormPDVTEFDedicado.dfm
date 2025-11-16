inherited FormPDVTEFDedicado: TFormPDVTEFDedicado
  Left = 191
  Top = 167
  BorderStyle = bsSingle
  Caption = 'FormPDVTEFDedicado'
  ClientHeight = 631
  ClientWidth = 970
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 970
    inherited lbl_Title: TLabel
      Width = 970
    end
    object pnl_btn_Close: TPanel
      Left = 904
      Top = 7
      Width = 59
      Height = 49
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Caption = 'Close'
      Color = 4227327
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = pnl_btn_CloseClick
    end
  end
  inherited Panel2: TPanel
    Width = 970
    Height = 523
    object pnl_BordaMargemE: TPanel
      Left = 0
      Top = 0
      Width = 42
      Height = 523
      Align = alLeft
      BevelOuter = bvNone
      Color = 6568459
      TabOrder = 0
    end
    object pnl_BordaMargemD: TPanel
      Left = 920
      Top = 0
      Width = 50
      Height = 523
      Align = alRight
      BevelOuter = bvNone
      Color = 6568459
      TabOrder = 1
    end
    object pnl_tools: TPanel
      Left = 42
      Top = 0
      Width = 878
      Height = 523
      Align = alClient
      BevelOuter = bvNone
      Color = 6568459
      TabOrder = 2
      object pnl_Vlr_msg: TPanel
        Left = 0
        Top = 0
        Width = 528
        Height = 523
        Align = alClient
        BevelOuter = bvNone
        Color = 6568459
        TabOrder = 0
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 528
          Height = 45
          Align = alTop
          Caption = 'R$ Valor Transa'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindow
          Font.Height = -33
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lblAguardando: TLabel
          Left = 0
          Top = 498
          Width = 528
          Height = 25
          Align = alBottom
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lblop: TLabel
          Left = 0
          Top = 105
          Width = 528
          Height = 25
          Align = alTop
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clAqua
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lMensagemTef: TLabel
          Left = 0
          Top = 130
          Width = 528
          Height = 25
          Align = alTop
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindow
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Panel7: TPanel
          Left = 0
          Top = 45
          Width = 528
          Height = 60
          Align = alTop
          BevelOuter = bvNone
          Color = 6568459
          TabOrder = 0
          object edt_Transacao: TEdit
            Left = 0
            Top = 4
            Width = 241
            Height = 41
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -27
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '0,00'
            OnKeyDown = edt_TransacaoKeyDown
          end
        end
      end
      object pnl_CupomQrcode: TPanel
        Left = 528
        Top = 0
        Width = 350
        Height = 523
        Align = alRight
        BevelOuter = bvNone
        Color = 6568459
        TabOrder = 1
        object imgQRCode: TImage
          Left = 0
          Top = 513
          Width = 350
          Height = 400
          Align = alTop
          Proportional = True
          Stretch = True
          Visible = False
        end
        object Mm_Cupom: TMemo
          Left = 0
          Top = 0
          Width = 350
          Height = 513
          Align = alTop
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6568459
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Visible = False
        end
      end
    end
  end
  object Panel8: TPanel
    Left = 0
    Top = 596
    Width = 970
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    Color = 6568459
    TabOrder = 2
  end
  object RscTefCliSiTef1: TRscTefCliSiTef
    TefConfig.Tef_Ip = '127.0.0.1'
    TefConfig.Tef_Empresa = '00000000'
    TefConfig.Tef_EmpresaCnpj = '11111111111111'
    TefConfig.Tef_Terminal = 'SE000001'
    TefConfig.Tef_SoftHouseCnpj = '22222222222222'
    TefConfig.Tef_PinPadPorta = 'AUTO_USB'
    TefConfig.Tef_PinPadMensagem = 'RSC SISTEMAS'
    TefConfig.Tef_PinPadVerificar = True
    TefConfig.Tef_PinPadQrCode = True
    TefConfig.Tef_PathArquivos = 'C:\Program Files (x86)\Embarcadero\Studio\19.0\bin\Tef/'
    TefConfig.Tef_SuportaDesconto = False
    TefConfig.Tef_ConfirmaTransacaoPendente = True
    OnExibeMenu = RscTefCliSiTef1ExibeMenu
    OnObtemCampo = RscTefCliSiTef1ObtemCampo
    OnExibeMsg = RscTefCliSiTef1ExibeMsg
    OnExibeQrCode = RscTefCliSiTef1ExibeQrCode
    OnImprimeVia = RscTefCliSiTef1ImprimeVia
    OnAguardaResp = RscTefCliSiTef1AguardaResp
    OnFinalTransacao = RscTefCliSiTef1FinalTransacao
    OnGravarLog = RscTefCliSiTef1GravarLog
    Left = 385
    Top = 249
  end
  object QRecCartao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 385
  end
end
