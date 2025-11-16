object FormObtemCampo: TFormObtemCampo
  Left = 644
  Top = 278
  BorderStyle = bsNone
  Caption = 'Entre com a Informa'#231#227'o'
  ClientHeight = 172
  ClientWidth = 446
  Color = clHighlight
  Constraints.MinHeight = 170
  Constraints.MinWidth = 420
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    446
    172)
  TextHeight = 24
  object edtResposta: TEdit
    Left = 24
    Top = 74
    Width = 400
    Height = 32
    Anchors = [akLeft, akRight, akBottom]
    AutoSelect = False
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = edtRespostaChange
    OnKeyDown = edtRespostaKeyDown
    OnKeyPress = edtRespostaKeyPress
  end
  object pTitulo: TPanel
    Left = 0
    Top = 0
    Width = 446
    Height = 58
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Color = clHotLight
    ParentBackground = False
    TabOrder = 1
    object lTitulo: TLabel
      Left = 0
      Top = 0
      Width = 50
      Height = 24
      Align = alClient
      Alignment = taCenter
      Caption = 'lTitulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 122
    Width = 446
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    Color = clHotLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object pnlOk: TPanel
      Left = 319
      Top = 0
      Width = 127
      Height = 50
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Ok'
      Color = clMenuHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = pnlOkClick
      OnMouseMove = pnlVoltarMouseMove
    end
    object pnlCancelar: TPanel
      Left = 127
      Top = 0
      Width = 192
      Height = 50
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Cancelar'
      Color = clMenuHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      OnClick = pnlCancelarClick
      OnMouseMove = pnlVoltarMouseMove
    end
    object pnlVoltar: TPanel
      Left = 0
      Top = 0
      Width = 127
      Height = 50
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Voltar'
      Color = clMenuHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      OnClick = pnlVoltarClick
      OnMouseMove = pnlVoltarMouseMove
    end
  end
end
