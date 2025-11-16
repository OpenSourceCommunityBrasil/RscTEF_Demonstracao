object FormTefConfig: TFormTefConfig
  Left = 565
  Top = 123
  Width = 550
  Height = 419
  Caption = 'Configurar TEF'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 53
    Width = 53
    Height = 13
    Caption = 'IP Servidor'
  end
  object Label2: TLabel
    Left = 135
    Top = 53
    Width = 67
    Height = 13
    Caption = 'C'#243'd. Empresa'
  end
  object Label3: TLabel
    Left = 262
    Top = 53
    Width = 69
    Height = 13
    Caption = 'CNPJ Empresa'
  end
  object Label4: TLabel
    Left = 389
    Top = 53
    Width = 40
    Height = 13
    Caption = 'Terminal'
  end
  object Label5: TLabel
    Left = 8
    Top = 5
    Width = 41
    Height = 13
    Caption = 'CNPJ SH'
  end
  object Label6: TLabel
    Left = 135
    Top = 101
    Width = 48
    Height = 13
    Caption = 'Porta USB'
  end
  object Label7: TLabel
    Left = 8
    Top = 101
    Width = 86
    Height = 13
    Caption = 'Mensagem PinPad'
  end
  object Label9: TLabel
    Left = 8
    Top = 181
    Width = 62
    Height = 13
    Caption = 'Local Qrcode'
  end
  object Label11: TLabel
    Left = 159
    Top = 181
    Width = 67
    Height = 13
    Caption = 'Path Arquivos'
  end
  object Label12: TLabel
    Left = 262
    Top = 101
    Width = 55
    Height = 13
    Caption = 'Senha ADM'
  end
  object Label8: TLabel
    Left = 8
    Top = 237
    Width = 59
    Height = 13
    Caption = 'Impressoras'
  end
  object SpeedButton1: TSpeedButton
    Left = 326
    Top = 255
    Width = 121
    Height = 22
    Caption = 'Testar Impressora'
    OnClick = SpeedButton1Click
  end
  object Label10: TLabel
    Left = 264
    Top = 235
    Width = 50
    Height = 13
    Caption = 'Fonte Size'
  end
  object Edt_IpServer: TEdit
    Left = 8
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Edt_EmpresaCodigo: TEdit
    Left = 135
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Edt_EmpresaCNPJ: TEdit
    Left = 262
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object Edt_Terminal: TEdit
    Left = 389
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object Edt_CNPJ_SH: TEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edt_PortaUsb: TEdit
    Left = 135
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object Edt_MsgPinPad: TEdit
    Left = 8
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object Edt_PathArquivos: TEdit
    Left = 159
    Top = 200
    Width = 351
    Height = 21
    TabOrder = 11
  end
  object Edt_SenhaADM: TEdit
    Left = 262
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object chkbx_VerificaPinPad: TCheckBox
    Left = 8
    Top = 155
    Width = 97
    Height = 17
    Caption = 'Verificar PinPad'
    TabOrder = 8
  end
  object chkbx_ConfirmaPendentes: TCheckBox
    Left = 135
    Top = 155
    Width = 182
    Height = 17
    Caption = 'Confirmar Transa'#231#245'es Pendentes'
    TabOrder = 9
  end
  object cbbx_LocalQrcode: TComboBox
    Left = 8
    Top = 200
    Width = 145
    Height = 21
    ItemHeight = 13
    ItemIndex = 3
    TabOrder = 10
    Text = 'Exibir na Tela'
    Items.Strings = (
      'N'#227'o Suportado'
      'Auto'
      'Exibir no PinPad'
      'Exibir na Tela'
      'Imprimir')
  end
  object Panel1: TPanel
    Left = 0
    Top = 347
    Width = 542
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 12
    object Button1: TButton
      Left = 442
      Top = 0
      Width = 75
      Height = 41
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object cbbImpressoras: TComboBox
    Left = 8
    Top = 256
    Width = 248
    Height = 21
    ItemHeight = 13
    TabOrder = 13
    Text = 'cbbImpressoras'
  end
  object sEdt_FontSize: TSpinEdit
    Left = 264
    Top = 254
    Width = 52
    Height = 22
    MaxValue = 99
    MinValue = 1
    TabOrder = 14
    Value = 10
  end
  object chkbx_SuportaDesconto: TCheckBox
    Left = 323
    Top = 155
    Width = 129
    Height = 17
    Caption = 'Suporta Desconto'
    TabOrder = 15
  end
  object chkbx_GerarLog: TCheckBox
    Left = 8
    Top = 291
    Width = 129
    Height = 17
    Caption = 'Gerar arquivo de log'
    TabOrder = 16
  end
end
