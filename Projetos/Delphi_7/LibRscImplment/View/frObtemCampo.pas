{=======================================}
{                  RSC                  }
{   SISTEMAS E SOLUÇÕES TECNOLÓGICAS    }
{                                       }
{         rscsistemas.com.br            }
{          +55 92 4141-2737             }
{      contato@rscsistemas.com.br       }
{                                       }
{ Desenvolvidor por:                    }
{   Roniery Santos Cardoso              }
{   roniery@rscsistemas.com.br          }
{   +55 92 984391279                    }
{                                       }
{                                       }
{ Versão Original RSC SISTEMAS          }
{ Versão: 2.0 - 2025                    }
{                                       }
{=======================================}


unit frObtemCampo; 

interface

uses
  Classes, SysUtils, 
  Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons, ExtCtrls

  , Rsc.Vcl.Strings
  ;

type

{$R *.dfm}

  TTipoCampo = (tcoString, tcoNumeric, tcoCurrency, tcoAlfa, tcoAlfaNum, tcoDecimal) ;

{ TFormObtemCampo }

  TFormObtemCampo = class(TForm)
    edtResposta : TEdit;
    lTitulo: TLabel;
    pTitulo : TPanel;
    Panel2: TPanel;
    pnlOk: TPanel;
    pnlCancelar: TPanel;
    pnlVoltar: TPanel;
    procedure edtRespostaChange(Sender: TObject);
    procedure edtRespostaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtRespostaKeyPress(Sender : TObject; var Key : char);
    procedure FormCloseQuery(Sender : TObject; var CanClose : boolean);
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure pnlVoltarMouseLeave(Sender: TObject);
    procedure pnlVoltarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlVoltarClick(Sender: TObject);
    procedure pnlCancelarClick(Sender: TObject);
    procedure pnlOkClick(Sender: TObject);
  private
    { private declarations }
    fMascara: String;
    FTamanhoMaximo: Integer;
    FTamanhoMinimo: Integer;
    fTipoCampo: TTipoCampo;
    function GetOcultar: Boolean;
    function GetResposta: widestring;
    function GetTitulo: String;
    procedure SetMascara(AValue: String);
    procedure SetOcultar(AValue: Boolean);
    procedure SetResposta(AValue: widestring);
    procedure SetTitulo(AValue: String);
  public
    { public declarations }
    property TipoCampo: TTipoCampo read fTipoCampo write FTipoCampo;
    property TamanhoMinimo: Integer read FTamanhoMinimo write FTamanhoMinimo;
    property TamanhoMaximo: Integer read FTamanhoMaximo write FTamanhoMaximo;
    property Mascara: String read fMascara write SetMascara;
    property Titulo: String read GetTitulo write SetTitulo;
    property Resposta: widestring read GetResposta write SetResposta;
    property Ocultar: Boolean read GetOcultar write SetOcultar;
  end;

implementation

//uses
//  ACBrConsts;

{ TFormObtemCampo }

procedure TFormObtemCampo.FormCreate(Sender : TObject);
begin
  fTamanhoMinimo := 0;
  fTamanhoMaximo := 0;
  fTipoCampo := tcoString;
  fMascara := '';
end;

procedure TFormObtemCampo.FormShow(Sender : TObject);
var
  TamMascara: Integer;
  TextVal: String;
begin
   if (fTipoCampo in [tcoCurrency, tcoDecimal]) then
   begin
     edtResposta.AutoSelect := False;
     TextVal := '0,00';
     if (fTipoCampo = tcoCurrency) then
       TextVal := 'R$ '+TextVal;

     edtResposta.Text := TextVal;
     edtResposta.SelStart := Length(edtResposta.Text);
     if TamanhoMaximo > 0 then
       TamanhoMaximo := TamanhoMaximo + 1;  // (Ponto Decimal)
   end
   else
   begin
     if (fMascara <> '') then
     begin
       TamMascara := CountStr(fMascara, '*');
       if TamanhoMaximo = 0 then
         TamanhoMaximo := TamMascara;

       if TamanhoMinimo = 0 then
         TamanhoMinimo := TamMascara;
     end;

     edtResposta.SetFocus;
   end;
end;

procedure TFormObtemCampo.FormCloseQuery(Sender : TObject; var CanClose : boolean);
begin
  if (ModalResult = mrOK) then
  begin
    if (TamanhoMinimo > 0) and (Length(Resposta) < TamanhoMinimo) then
    begin
      ShowMessage('O Tamanho Mínimo para este campo e: '+IntToStr(TamanhoMinimo) );
      CanClose := False;
      edtResposta.SetFocus;
    end
    else if (TamanhoMaximo > 0) and (Length(Resposta) > TamanhoMaximo) then
    begin
      ShowMessage('O Tamanho Maximo para este campo e: '+IntToStr(TamanhoMaximo) );
      CanClose := False;
      edtResposta.SetFocus;
    end
  end;
end;

procedure TFormObtemCampo.edtRespostaKeyPress(Sender : TObject; var Key : char);
var
  Ok: Boolean;
begin

   if ((Key in [#8,#13,#27])) then Exit;

   case fTipoCampo of
     tcoNumeric, tcoCurrency, tcoDecimal:
       Ok := CharIsNum(Key);

     tcoAlfa:
     begin
       Key := upcase(Key);
       Ok := CharIsAlpha(Key);
     end;

     tcoAlfaNum:
     begin
       Ok := CharIsNum(Key);
       if not Ok then
       begin
         Key := upcase(Key);
         Ok := CharIsAlpha(Key);
       end;
     end;

   else
     Ok := True;
   end;

   if (not Ok) then
   begin
     Key := #0;
     Exit;
   end;

   if (TamanhoMaximo > 0) and (Length(Resposta) >= TamanhoMaximo) then
     Key := #0;
end;

procedure TFormObtemCampo.edtRespostaChange(Sender: TObject);
var
  AValor: Int64;
  TextVal: String;
begin
  if (fTipoCampo in [tcoCurrency, tcoDecimal]) then
  begin
    AValor := StrToIntDef(OnlyNumber(edtResposta.Text), 0);
    TextVal := FormatFloatBr(AValor/100, FloatMask(2, (fTipoCampo = tcoCurrency)));
    if (fTipoCampo = tcoCurrency) then
      TextVal := 'R$ '+TextVal;

    edtResposta.Text := TextVal;
    edtResposta.SelStart := Length(edtResposta.Text);
  end
  else if (fMascara <> '') then
  begin
    edtResposta.Text := FormatarMascaraDinamica( RemoverMascara(edtResposta.Text, fMascara), fMascara);
    edtResposta.SelStart := Length(edtResposta.Text);
  end;
end;

procedure TFormObtemCampo.edtRespostaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
  begin
    if (TamanhoMinimo > 0) and (Length(Resposta) < TamanhoMinimo) then
      Key := 0
    else
      pnlOkClick(pnlOk);
  end;
end;

function TFormObtemCampo.GetResposta: widestring;
var
  AValor: Int64;
begin
  if (TipoCampo in [tcoCurrency, tcoDecimal]) then
  begin
    AValor := StrToIntDef(OnlyNumber(edtResposta.Text), 0);
    Result := FloatToString(AValor/100, ',', '0.00');
  end
  else if (fMascara <> '') then
    Result := RemoverMascara(edtResposta.Text, fMascara)
  else
    Result := edtResposta.Text;

end;

procedure TFormObtemCampo.SetResposta(AValue: widestring);
begin
  edtResposta.Text := AValue;
end;

function TFormObtemCampo.GetTitulo: String;
begin
  Result := lTitulo.Caption;
end;

procedure TFormObtemCampo.pnlCancelarClick(Sender: TObject);
begin
  ModalResult :=  mrCancel;
end;

procedure TFormObtemCampo.pnlOkClick(Sender: TObject);
begin
  ModalResult :=  mrOk;
end;

procedure TFormObtemCampo.pnlVoltarClick(Sender: TObject);
begin
  ModalResult :=  mrRetry;
end;

procedure TFormObtemCampo.pnlVoltarMouseLeave(Sender: TObject);
begin
  if sender is TPanel then
    begin
      TPanel(Sender).Color        :=  clMenuHighlight;
    end;
end;

procedure TFormObtemCampo.pnlVoltarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if sender is TPanel then
    begin
      TPanel(Sender).Color        :=  clNavy;
    end;
end;

procedure TFormObtemCampo.SetTitulo(AValue: String);
var
  NumLin, AltLin: Integer;
begin
  lTitulo.Caption := AValue;

  // Se houver quebra de linhas na msg, aumente o formulário...
  NumLin := CountStr(AValue, #13);
  if (NumLin > 0) then
  begin
    AltLin := lTitulo.Canvas.TextHeight('H');
    Height := Height + (NumLin * AltLin);
  end;
end;

procedure TFormObtemCampo.SetMascara(AValue: String);
begin
  if fMascara = AValue then
    Exit;

  fMascara := StringReplace(AValue, '@', '*', [rfReplaceAll]);
end;

function TFormObtemCampo.GetOcultar: Boolean;
begin
  Result := (edtResposta.PasswordChar <> #0);
end;


procedure TFormObtemCampo.SetOcultar(AValue: Boolean);
begin
  if AValue then
    edtResposta.PasswordChar := '*'
  else
    edtResposta.PasswordChar := #0;
end;

end.

