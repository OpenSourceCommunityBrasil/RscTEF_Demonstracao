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


unit Rsc.Vcl.Utils;

interface

function IfThen(const Validar: boolean; const Verdadeiro: integer; const Falso: integer): integer; overload;

function IfThen(const Validar: boolean; const Verdadeiro: string; const Falso: string): string; overload;

implementation

function IfThen(const Validar: boolean; const Verdadeiro: integer; const Falso: integer): integer;
begin
  if Validar then
    Result  :=  Verdadeiro
  else
    Result  :=  Falso;
end;

function IfThen(const Validar: boolean; const Verdadeiro: string; const Falso: string): string;
begin
  if Validar then
    Result  :=  Verdadeiro
  else
    Result  :=  Falso;
end;

end.
