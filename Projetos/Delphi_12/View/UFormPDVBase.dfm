object FormPDVBase: TFormPDVBase
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'PDV'
  ClientHeight = 481
  ClientWidth = 564
  Color = 6568459
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 564
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Color = 6568459
    TabOrder = 0
    object lbl_Title: TLabel
      Left = 0
      Top = 0
      Width = 564
      Height = 73
      Align = alClient
      Alignment = taCenter
      Caption = 'CAIXA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -33
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 73
    Width = 564
    Height = 408
    Align = alClient
    BevelOuter = bvNone
    Color = 6568459
    TabOrder = 1
  end
end
