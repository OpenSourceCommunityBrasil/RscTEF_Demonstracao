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


unit frMenuTEF;

interface

uses
  Classes, SysUtils,
  Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons

  ;

type

{$R *.dfm}

  { TFormMenuTEF }

  TFormMenuTEF = class(TForm)
     lbOpcoes : TListBox;
     pTitulo : TPanel;
     Panel2 : TPanel;
    pnlOk: TPanel;
    pnlCancelar: TPanel;
    pnlVoltar: TPanel;
     procedure FormShow(Sender: TObject);
     procedure lbOpcoesClick(Sender: TObject);
     procedure lbOpcoesKeyPress(Sender: TObject; var Key: char);
    procedure pnlVoltarClick(Sender: TObject);
    procedure pnlCancelarClick(Sender: TObject);
    procedure pnlOkClick(Sender: TObject);
    procedure pnlVoltarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlVoltarMouseLeave(Sender: TObject);
    procedure lbOpcoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { private declarations }
    FUsaTeclasDeAtalho: Boolean;
    FNumeroPressionado: Boolean;
    function GetItemSelecionado: Integer;
    function GetOpcoes: TStrings;
    function GetTitulo: String;
    procedure SetItemSelecionado(AValue: Integer);
    procedure SetOpcoes(AValue: TStrings);
    procedure SetTitulo(AValue: String);
  public
    { public declarations }
    property Titulo: String read GetTitulo write SetTitulo;
    property Opcoes: TStrings read GetOpcoes write SetOpcoes;
    property ItemSelecionado: Integer read GetItemSelecionado write SetItemSelecionado;
    property UsaTeclasDeAtalho: Boolean read FUsaTeclasDeAtalho write FUsaTeclasDeAtalho;
  end; 

implementation

{ TFormMenuTEF }

procedure TFormMenuTEF.FormShow(Sender: TObject);
begin
   lbOpcoes.SetFocus;
   if lbOpcoes.Items.Count > 0 then
      lbOpcoes.ItemIndex := 0 ;

   FNumeroPressionado := False;
end;

procedure TFormMenuTEF.lbOpcoesClick(Sender: TObject);
begin
  if FUsaTeclasDeAtalho and FNumeroPressionado then
    ModalResult := mrOK;
end;

procedure TFormMenuTEF.lbOpcoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    begin
      pnlOkClick(pnlOk);
    end;
  if key = 27 then
    begin
      pnlCancelarClick(pnlCancelar);
    end;
end;

procedure TFormMenuTEF.lbOpcoesKeyPress(Sender: TObject; var Key: char);
begin
  {$IFDEF UNICODE}
  FNumeroPressionado := CharInSet(Key, ['0'..'9']);
  {$ELSE}
  FNumeroPressionado := (Key in ['0'..'9']);
  {$ENDIF}
end;

procedure TFormMenuTEF.pnlCancelarClick(Sender: TObject);
begin
  ModalResult :=  mrCancel;
end;

procedure TFormMenuTEF.pnlOkClick(Sender: TObject);
begin
  ModalResult :=  mrOk;
end;

procedure TFormMenuTEF.pnlVoltarClick(Sender: TObject);
begin
  ModalResult :=  mrRetry;
end;

procedure TFormMenuTEF.pnlVoltarMouseLeave(Sender: TObject);
begin
  if sender is TPanel then
    begin
      TPanel(Sender).Color        :=  clMenuHighlight;
    end;
end;

procedure TFormMenuTEF.pnlVoltarMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if sender is TPanel then
    begin
      TPanel(Sender).Color        :=  clNavy;
    end;
end;

function TFormMenuTEF.GetTitulo: String;
begin
  Result := pTitulo.Caption;
end;

procedure TFormMenuTEF.SetItemSelecionado(AValue: Integer);
begin
  lbOpcoes.ItemIndex := AValue;
end;

function TFormMenuTEF.GetOpcoes: TStrings;
begin
  Result := lbOpcoes.Items;
end;

function TFormMenuTEF.GetItemSelecionado: Integer;
begin
  Result := lbOpcoes.ItemIndex;
end;

procedure TFormMenuTEF.SetOpcoes(AValue: TStrings);
begin
  lbOpcoes.Items.AddStrings(AValue);
end;

procedure TFormMenuTEF.SetTitulo(AValue: String);
begin
  pTitulo.Caption := AValue;
end;

end.

