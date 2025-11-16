object FormMenuTEF: TFormMenuTEF
  Left = 563
  Top = 293
  BorderStyle = bsNone
  Caption = 'Selecione uma op'#231#227'o'
  ClientHeight = 400
  ClientWidth = 616
  Color = clHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 24
  object lbOpcoes: TListBox
    Left = 0
    Top = 50
    Width = 616
    Height = 300
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsNone
    ExtendedSelect = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 24
    ParentFont = False
    TabOrder = 0
    OnClick = lbOpcoesClick
    OnKeyDown = lbOpcoesKeyDown
    OnKeyPress = lbOpcoesKeyPress
  end
  object pTitulo: TPanel
    Left = 0
    Top = 0
    Width = 616
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pTitulo'
    Color = clHotLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 350
    Width = 616
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
      Left = 416
      Top = 0
      Width = 200
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
      Left = 200
      Top = 0
      Width = 216
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
      Width = 200
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
