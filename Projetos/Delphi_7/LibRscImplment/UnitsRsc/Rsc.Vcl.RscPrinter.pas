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


unit Rsc.Vcl.RscPrinter;

interface

  uses
  printers,
  Classes,
  SysUtils,
  Controls,
  Graphics,

  Rsc.Vcl.Strings

  ;


Type

  TLineAligned = (laLeftAlign, laRightAlign, laCenterAlign);

  TMargens  = class
  private
    FTop: integer;
    FLeft: integer;
  public
    constructor Create;
    property Left: integer read FLeft write FLeft;
    property Top: integer read FTop write FTop;
  end;

  TRscPrinter = class(TComponent)
  private
    FMargins: TMargens;
    FNomeImpressora: string;
    x, y: integer;
    FBuffer: TStringList;
    FColunas: integer;
    FFont: TFont;
    procedure SetMargins(const Value: TMargens);
    { private declarations }
    procedure AtivarImpressora;
    procedure PaintLine(sLinha: string);
    procedure EndImpresao;

    procedure SelecPrinterCurrent;
    procedure SetColunas(const Value: integer);
    procedure SetFont(const Value: TFont);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ExibirImpressoras(list: TStrings);
    procedure AddLinhaImpressao(linha: string; const Alignment: TLineAligned = laLeftAlign; const RemoverEspacos: Boolean = False);
    procedure Imprimir;

  published
    { published declarations }
    property NomeImpressora: string read FNomeImpressora write FNomeImpressora;
    property Margins: TMargens read FMargins write SetMargins;
    property Buffer: TStringList read FBuffer write FBuffer;
    property Colunas: integer read FColunas write SetColunas;
    property Font:  TFont read FFont write SetFont;
  end;

var
  RscPrinter  : TRscPrinter;

implementation


{ TRscPrinter }

procedure TRscPrinter.AtivarImpressora;
begin
  x :=  Margins.Left;
  y :=  Margins.Top;

  SelecPrinterCurrent;
  Printer.BeginDoc;
end;

constructor TRscPrinter.Create(AOwner: TComponent);
begin
  inherited;
  FFont     :=  TFont.Create;
  FMargins  :=  TMargens.Create;
  Buffer    :=  TStringList.Create;
  Colunas   :=  80;
end;

destructor TRscPrinter.Destroy;
begin
  FFont.Free;
  FMargins.Free;
  Buffer.Free;
  inherited;
end;

procedure TRscPrinter.EndImpresao;
begin
  Printer.EndDoc;
  FBuffer.Clear;

  x :=  0;
  y :=  0;
end;

procedure TRscPrinter.ExibirImpressoras(list: TStrings);
begin
  list.Text := Printer.printers.Text;
end;

procedure TRscPrinter.Imprimir;
var
  L: Integer;
begin
  AtivarImpressora;

  for L := 0 to Pred(FBuffer.Count) do
    begin
      PaintLine(FBuffer.Strings[L]);
    end;

  EndImpresao;
end;

procedure TRscPrinter.AddLinhaImpressao(linha: string; const Alignment: TLineAligned; const RemoverEspacos: Boolean);
begin
  case Alignment of
    laLeftAlign: FBuffer.Add(PadLeftAligned(linha, Colunas, ' ', RemoverEspacos));
    laRightAlign: FBuffer.Add(PadRightAligned(linha, Colunas, ' ', RemoverEspacos));
    laCenterAlign: FBuffer.Add(PadCenterAligned(linha, Colunas, ' ', RemoverEspacos));
  end;
end;

procedure TRscPrinter.PaintLine(sLinha: string);
begin
  Printer.Canvas.Font.Assign(FFont);
  Printer.Canvas.TextOut(x, y, sLinha);
  inc(y, (Printer.Canvas.TextHeight('W') + (FMargins.Top * 2)));
end;

procedure TRscPrinter.SelecPrinterCurrent;
var
  Device, Driver, Port: array [0 .. 255] of char;
  hDMode: THandle;
  i: integer;
  tmpnome: string;
begin
  Printer.PrinterIndex := -1;
  for i := 0 to (Printer.printers.Count - 1) do
  begin
    tmpnome := Printer.printers[i];
    if tmpnome = FNomeImpressora then
    begin
      Printer.PrinterIndex := i;
      Printer.GetPrinter(Device, Driver, Port, hDMode);
      Break;
    end;
  end;
end;

procedure TRscPrinter.SetColunas(const Value: integer);
begin
  FColunas := Value;
end;

procedure TRscPrinter.SetFont(const Value: TFont);
begin
  FFont := Value;
end;

procedure TRscPrinter.SetMargins(const Value: TMargens);
begin
  FMargins := Value;
end;

{ TMargens }

constructor TMargens.Create;
begin
  FLeft :=  3;
  FTop  :=  3;
end;


initialization

  RscPrinter  :=  TRscPrinter.Create(nil);

finalization

  RscPrinter.Free;

end.
