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


unit Controller.IniFiles;

interface

uses
  IniFiles,
  SysUtils;


const
  TEFCONFIGINI = 'TefConfig.ini';

type

  TControllerTefConfigIni = class
  public
    class function LerString(const Section, Ident, Default: string): string;
    class procedure GravarString(const Section, Ident, Value: string);
    class function LerInteger(const Section, Ident: string; Default: Integer): Integer;
    class procedure GravarInteger(const Section, Ident: string; Value: Integer);
  end;

implementation

{ TControllerTefConfigIni }

class function TControllerTefConfigIni.LerString(const Section, Ident, Default: string): string;
var
  FIni: TIniFile;
begin
  FIni  :=  TIniFile.Create(ExtractFilePath(ParamStr(0))  + TEFCONFIGINI);
  try
    try
      Result  :=  FIni.ReadString(Section, Ident, Default);
    except on E: Exception do
      Result  :=  Default;
    end;
  finally
    FIni.Free
  end;
end;

class procedure TControllerTefConfigIni.GravarString(const Section, Ident, Value: string);
var
  FIni: TIniFile;
begin
  FIni  :=  TIniFile.Create(ExtractFilePath(ParamStr(0))  + TEFCONFIGINI);
  try
    try
      FIni.WriteString(Section, Ident, Value);
    except on E: Exception do
    end;
  finally
    FIni.Free
  end;
end;

class function TControllerTefConfigIni.LerInteger(const Section, Ident: string;
  Default: Integer): Integer;
var
  FIni: TIniFile;
begin
  FIni  :=  TIniFile.Create(ExtractFilePath(ParamStr(0))  + TEFCONFIGINI);
  try
    try
      Result  :=  FIni.ReadInteger(Section, Ident, Default);
    except on E: Exception do
      Result  :=  Default;
    end;
  finally
    FIni.Free
  end;
end;

class procedure TControllerTefConfigIni.GravarInteger(const Section, Ident: string;
  Value: Integer);
var
  FIni: TIniFile;
begin
  FIni  :=  TIniFile.Create(ExtractFilePath(ParamStr(0))  + TEFCONFIGINI);
  try
    try
      FIni.WriteInteger(Section, Ident, Value);
    except on E: Exception do
    end;
  finally
    FIni.Free
  end;
end;

end.
