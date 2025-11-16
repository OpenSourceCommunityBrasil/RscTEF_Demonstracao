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


program RscTefCliente;

uses
  Forms,
  UFormPrincipal in 'View\UFormPrincipal.pas' {FormPrincipal},
  UFormPDVBase in 'View\UFormPDVBase.pas' {FormPDVBase},
  UFormPDVTEFDedicado in 'View\UFormPDVTEFDedicado.pas' {FormPDVTEFDedicado},
  Rsc.Vcl.RscPrinter in 'LibRscImplment\UnitsRsc\Rsc.Vcl.RscPrinter.pas',
  Rsc.Vcl.Strings in 'LibRscImplment\UnitsRsc\Rsc.Vcl.Strings.pas',
  Controller.IniFiles in 'LibRscImplment\controller\Controller.IniFiles.pas',
  frMenuTEF in 'LibRscImplment\View\frMenuTEF.pas' {FormMenuTEF},
  frObtemCampo in 'LibRscImplment\View\frObtemCampo.pas' {FormObtemCampo},
  uFormTefConfig in 'View\uFormTefConfig.pas' {FormTefConfig},
  Rsc.Vcl.Utils in 'LibRscImplment\UnitsRsc\Rsc.Vcl.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
