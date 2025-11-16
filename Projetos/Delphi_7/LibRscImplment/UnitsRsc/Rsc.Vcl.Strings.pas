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


unit Rsc.Vcl.Strings;

interface

uses
    SysUtils
  , StrUtils
  , Math;

var
  fmtst: TFormatSettings;
  CurrencyString: string;
  CurrencyFormat: Byte;
  NegCurrFormat: Byte;
  ThousandSeparator: Char;
  DecimalSeparator: Char;
  CurrencyDecimals: Byte;
  DateSeparator: Char;
  ShortDateFormat: string;
  LongDateFormat: string;
  TimeSeparator: Char;
  TimeAMString: string;
  TimePMString: string;
  ShortTimeFormat: string;
  LongTimeFormat: string;
  TwoDigitYearCenturyWindow: Word = 50;
  ListSeparator: Char;

type
  TFormatMask = (msk4x2, msk7x2, msk9x2, msk10x2, msk13x2, msk15x2, msk6x3, msk6x4, mskAliq);


function CharIsAlpha(const C: Char): Boolean;
function CharIsAlphaNum(const C: Char): Boolean;
function CharIsNum(const C: Char): Boolean;
function OnlyNumber(const AValue: String): String;

function LeftStrNativeString(const AString: String; const ALen: Integer): String;
function LengthNativeString(const AString: String): Integer;
function PosLast(const SubStr, S: String ): Integer;
function CountStr(const AString, SubStr : String ) : Integer ;

function PadLeftAligned(const AString: String; const nLen: Integer;
  const Caracter: Char = ' '; const RemoverEspacos: Boolean = True): String;
function PadRightAligned(const AString: String; const nLen: Integer;
  const Caracter: Char = ' '; const RemoverEspacos: Boolean = True): String;
function PadCenterAligned(const AString: String; const nLen: Integer;
  const Caracter: Char = ' '; const RemoverEspacos: Boolean = True): String;

Function FormatarMascaraDinamica(const AValue: String; const Mascara: String): String;
Function RemoverMascara(const AValue: String; const Mascara: String): String;

function FormatFloatBr(const AValue: Extended; AFormat: String = ''): String; overload;
function FormatFloatBr(const AFormat: TFormatMask; const AValue: Extended): String; overload;
function FloatMask(const DecimalDigits: SmallInt = 2; UseThousandSeparator: Boolean = True): String;

function EstaVazio(const AValue: String): Boolean;

function FloatToString(const AValue: Double; SeparadorDecimal: Char = '.';
  const AFormat: String = ''): String;

implementation

function CreateFormatSettings: TFormatSettings;
begin
  Result.CurrencyString            := CurrencyString;
  Result.CurrencyFormat            := CurrencyFormat;
  Result.NegCurrFormat             := NegCurrFormat;
  Result.ThousandSeparator         := ThousandSeparator;
  Result.DecimalSeparator          := DecimalSeparator;
  Result.CurrencyDecimals          := CurrencyDecimals;
  Result.DateSeparator             := DateSeparator;
  Result.ShortDateFormat           := ShortDateFormat;
  Result.LongDateFormat            := LongDateFormat;
  Result.TimeSeparator             := TimeSeparator;
  Result.TimeAMString              := TimeAMString;
  Result.TimePMString              := TimePMString;
  Result.ShortTimeFormat           := ShortTimeFormat;
  Result.LongTimeFormat            := LongTimeFormat;
  Result.TwoDigitYearCenturyWindow := TwoDigitYearCenturyWindow;
  Result.ListSeparator             := ListSeparator;

end;


function CharIsAlpha(const C: Char): Boolean;
begin
  Result := (C in ['A'..'Z','a'..'z'] ) ;
end ;

function CharIsAlphaNum(const C: Char): Boolean;
begin
  Result := ( CharIsAlpha( C ) or CharIsNum( C ) );
end ;

function CharIsNum(const C: Char): Boolean;
begin
  Result := ( C in ['0'..'9'] ) ;
end;

function OnlyNumber(const AValue: String): String;
Var
  I : Integer ;
  LenValue : Integer;
begin
  Result   := '' ;
  LenValue := Length( AValue ) ;
  For I := 1 to LenValue  do
  begin
     if CharIsNum( AValue[I] ) then
        Result := Result + AValue[I];
  end;
end ;

function LeftStrNativeString(const AString: String; const ALen: Integer): String;
begin
  Result := LeftStr(AString, ALen);
end;

function LengthNativeString(const AString: String): Integer;
begin
  Result := Length(AString);
end;

function PosLast(const SubStr, S: String ): Integer;
Var P : Integer ;
begin
  Result := 0 ;
  P := Pos( SubStr, S) ;
  while P <> 0 do
  begin
     Result := P ;
     P := PosEx( SubStr, S, P+1) ;
  end ;
end ;

function CountStr(const AString, SubStr : String ) : Integer ;
Var ini : Integer ;
begin
  result := 0 ;
  if SubStr = '' then exit ;

  ini := Pos( SubStr, AString ) ;
  while ini > 0 do
  begin
     Result := Result + 1 ;
     ini    := PosEx( SubStr, AString, ini + 1 ) ;
  end ;
end ;

function PadLeftAligned(const AString: String; const nLen: Integer;
  const Caracter: Char = ' '; const RemoverEspacos: Boolean = True): String;
var
  S: String;
begin
  if RemoverEspacos then
    S := Trim(AString)
  else
    S := AString;
  // Limita o comprimento, se necessário
  if Length(S) > nLen then
    S := Copy(S, 1, nLen);
  // Preenche até o comprimento desejado
  Result := S + StringOfChar(Caracter, nLen - Length(S));
end;

function PadRightAligned(const AString: String; const nLen: Integer;
  const Caracter: Char = ' '; const RemoverEspacos: Boolean = True): String;
var
  S: String;
begin
  if RemoverEspacos then
    S := Trim(AString)
  else
    S := AString;

  if Length(S) > nLen then
    S := Copy(S, 1, nLen);

  Result := StringOfChar(Caracter, nLen - Length(S)) + S;
end;

function PadCenterAligned(const AString: String; const nLen: Integer;
  const Caracter: Char = ' '; const RemoverEspacos: Boolean = True): String;
var
  S: String;
  TotalPad, PadLeft, PadRight: Integer;
begin
  if RemoverEspacos then
    S := Trim(AString)
  else
    S := AString;

  if Length(S) > nLen then
    S := Copy(S, 1, nLen);

  TotalPad := nLen - Length(S);
  PadLeft  := TotalPad div 2;
  PadRight := TotalPad - PadLeft;

  Result := StringOfChar(Caracter, PadLeft) + S + StringOfChar(Caracter, PadRight);
end;


Function FormatarMascaraDinamica(const AValue: String; const Mascara: String): String;
var
  LenMas, LenDoc: Integer;
  i, j: Integer;
  c: Char;
  wValue: String;
begin
  Result := '';
  wValue := Trim( AValue );
  LenMas := Length( Mascara ) ;
  LenDoc := Length( wValue );

  i := 1; j := 1 ;
  while (i <= LenMas) and (j <= LenDoc) do
  begin
    c := Mascara[i];
    if c = '*' then
    begin
      c := wValue[j];
      Inc(j);
    end;

    Result := Result + c;
    Inc(i);
  end;
end;

function RemoverMascara(const AValue: String; const Mascara: String): String;
var
  i, m: Integer;
  cm, cv: Char;
  wValue: String;
begin
  Result := '';
  wValue := Trim(AValue);
  m := min(Length(Mascara), Length(wValue));

  i := 1;
  while (i <= m) do
  begin
    cm := Mascara[i];
    cv := wValue[i];
    if (cm = '*') or (cm <> cv) then
      Result := Result + cv;

    Inc(i);
  end;
end;

function FormatFloatBr(const AValue: Extended; AFormat: String): String;
Var
  FS: TFormatSettings;
begin
  if AFormat = '' then
     AFormat := FloatMask();
  FS := CreateFormatSettings;
  FS.DecimalSeparator := ',';
  FS.ThousandSeparator := '.';
  Result := FormatFloat(AFormat, AValue, FS);
end;

function FormatFloatBr(const AFormat: TFormatMask; const AValue: Extended): String; overload;
var
  Mask: String;
begin
  case AFormat of
    msk4x2  : Mask := '#,##0.00';
    msk7x2  : Mask := '#,###,##0.00';
    msk9x2  : Mask := '###,###,##0.00';
    msk10x2 : Mask := '#,###,###,##0.00';
    msk13x2 : Mask := '#,###,###,###,##0.00';
    msk15x2 : Mask := '###,###,###,###,##0.00';
    msk6x3  : Mask := ',0.000';
    msk6x4  : Mask := ',0.0000';
    mskAliq : Mask := '#00%';
  end;

  Result := FormatFloatBr(AValue, Mask);
  {$IfDef FPC}
  // Workround para BUG em FPC
  if (AValue > 999) and (pos(',', Mask) > 0) and (pos('.', Result) = 0) then
    Result := FormatFloatBr(AValue);
  {$EndIf}
end;

function FloatMask(const DecimalDigits: SmallInt; UseThousandSeparator: Boolean
  ): String;
begin
  if DecimalDigits > 0 then
  begin
    if UseThousandSeparator then
      Result := ','
    else
      Result := '';

    Result := Result + '0.' + StringOfChar('0',DecimalDigits)
  end
  else
    Result := '0';
end;

function EstaVazio(const AValue: String): Boolean;
begin
  Result := (AValue = '');
end;

function FloatToString(const AValue: Double; SeparadorDecimal: Char;
  const AFormat: String): String;
var
  DS, TS: Char;
  FS: TFormatSettings;
begin
  if EstaVazio(AFormat) then
    Result := FloatToStr(AValue)
  else
    Result := FormatFloat(AFormat, AValue);

  FS := CreateFormatSettings;
  DS := FS.DecimalSeparator;
  TS := FS.ThousandSeparator;

  // Removendo Separador de milhar //
  if ( DS <> TS ) then
    Result := StringReplace(Result, TS, '', [rfReplaceAll]);

  // Verificando se precisa mudar Separador decimal //
  if DS <> SeparadorDecimal then
    Result := StringReplace(Result, DS, SeparadorDecimal, [rfReplaceAll]);
end;


initialization
//  fmtst := TFormatSettings.Create('');
  CurrencyString := fmtst.CurrencyString;
  CurrencyFormat := fmtst.CurrencyFormat;
  NegCurrFormat := fmtst.NegCurrFormat;
  ThousandSeparator := fmtst.ThousandSeparator;
  DecimalSeparator := fmtst.DecimalSeparator;
  CurrencyDecimals := fmtst.CurrencyDecimals;
  DateSeparator := fmtst.DateSeparator;
  ShortDateFormat := fmtst.ShortDateFormat;
  LongDateFormat := fmtst.LongDateFormat;
  TimeSeparator := fmtst.TimeSeparator;
  TimeAMString := fmtst.TimeAMString;
  TimePMString := fmtst.TimePMString;
  ShortTimeFormat := fmtst.ShortTimeFormat;
  LongTimeFormat := fmtst.LongTimeFormat;
  TwoDigitYearCenturyWindow := fmtst.TwoDigitYearCenturyWindow;
  ListSeparator := fmtst.ListSeparator;

end.
