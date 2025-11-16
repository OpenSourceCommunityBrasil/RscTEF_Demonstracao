{=======================================}
{                  RSC                  }
{   SISTEMAS E SOLU«’ES TECNOL”GICAS    }
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
{ Vers„o Original RSC SISTEMAS          }
{ Vers„o: 2.0 - 2025                    }
{                                       }
{=======================================}

unit uFormTefConfig;

interface

uses
  Windows, Messages
  , SysUtils, Variants, Classes, Spin, StdCtrls, Controls, ExtCtrls
  , Buttons
  , Graphics
  , Forms
  , Dialogs

  {$IFDEF VER150}
  {$ELSE}
  , System.UITypes
  {$ENDIF}

  , StrUtils;

type
  TFormTefConfig = class(TForm)
    Edt_IpServer: TEdit;
    Label1: TLabel;
    Edt_EmpresaCodigo: TEdit;
    Label2: TLabel;
    Edt_EmpresaCNPJ: TEdit;
    Label3: TLabel;
    Edt_Terminal: TEdit;
    Label4: TLabel;
    Edt_CNPJ_SH: TEdit;
    Label5: TLabel;
    Edt_PortaUsb: TEdit;
    Label6: TLabel;
    Edt_MsgPinPad: TEdit;
    Label7: TLabel;
    Label9: TLabel;
    Edt_PathArquivos: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Edt_SenhaADM: TEdit;
    chkbx_VerificaPinPad: TCheckBox;
    chkbx_ConfirmaPendentes: TCheckBox;
    cbbx_LocalQrcode: TComboBox;
    Panel1: TPanel;
    Button1: TButton;
    Label8: TLabel;
    cbbImpressoras: TComboBox;
    SpeedButton1: TSpeedButton;
    sEdt_FontSize: TSpinEdit;
    Label10: TLabel;
    chkbx_SuportaDesconto: TCheckBox;
    chkbx_GerarLog: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ListarImpressoras;
    procedure CarregarDados;
    procedure SalvarDados;
  public
    { Public declarations }
  end;

var
  FormTefConfig: TFormTefConfig;

implementation

uses
  Controller.IniFiles
  , Rsc.Vcl.Utils
  , Rsc.Vcl.RscPrinter;

{$R *.dfm}

{ TForm1 }

procedure TFormTefConfig.Button1Click(Sender: TObject);
begin
  SalvarDados;
end;

procedure TFormTefConfig.CarregarDados;
begin
  Edt_IpServer.Text             :=  TControllerTefConfigIni.LerString('TEF', 'IP_SERVER', '');
  Edt_EmpresaCodigo.Text        :=  TControllerTefConfigIni.LerString('TEF', 'EMPRESA_CODIGO', '');
  Edt_EmpresaCNPJ.Text          :=  TControllerTefConfigIni.LerString('TEF', 'EMPRESA_CNPJ', '');
  Edt_Terminal.Text             :=  TControllerTefConfigIni.LerString('TEF', 'TERMINAL', '');
  Edt_CNPJ_SH.Text              :=  TControllerTefConfigIni.LerString('TEF', 'CNPJ_SH', '');
  Edt_PortaUsb.Text             :=  TControllerTefConfigIni.LerString('TEF', 'PORTA_USB', '');
  Edt_MsgPinPad.Text            :=  TControllerTefConfigIni.LerString('TEF', 'MSG_PINPAD', '');
  Edt_PathArquivos.Text         :=  TControllerTefConfigIni.LerString('TEF', 'PATH_ARQUIVOS', ExtractFilePath(ParamStr(0))  + 'Tef\');
  Edt_SenhaADM.Text             :=  TControllerTefConfigIni.LerString('TEF', 'SENHA_ADM', '');
  chkbx_VerificaPinPad.Checked  :=  TControllerTefConfigIni.LerInteger('TEF', 'VERIFICA_PINPAD', 0) = 1;
  chkbx_ConfirmaPendentes.Checked :=  TControllerTefConfigIni.LerInteger('TEF', 'CONFIRMA_TRANS_PENDENTES', 0) = 1;
  chkbx_SuportaDesconto.Checked :=  TControllerTefConfigIni.LerInteger('TEF', 'SUPORTA_DESCONTO', 0) = 1;
  cbbx_LocalQrcode.ItemIndex    :=  TControllerTefConfigIni.LerInteger('TEF', 'LOCAL_QRCODE', -1);
  chkbx_GerarLog.Checked        :=  TControllerTefConfigIni.LerInteger('TEF', 'GERAR_LOG_TRASACOES', 0) = 1;

  cbbImpressoras.Items[cbbImpressoras.Items.IndexOfName(TControllerTefConfigIni.LerString('IMPRESSORA', 'NOME', ''))];
  sEdt_FontSize.Value :=  TControllerTefConfigIni.LerInteger('IMPRESSORA', 'FONTE_SIZE', 10);
end;

procedure TFormTefConfig.FormCreate(Sender: TObject);
begin
  ListarImpressoras;
  CarregarDados;
end;

procedure TFormTefConfig.ListarImpressoras;
begin
  cbbImpressoras.Items.Clear ;
  RscPrinter.ExibirImpressoras(cbbImpressoras.Items);
  if cbbImpressoras.Items.Count > -1 then
    cbbImpressoras.ItemIndex := cbbImpressoras.Items.IndexOf(TControllerTefConfigIni.LerString('IMPRESSORA', 'NOME', ''));
end;

procedure TFormTefConfig.SalvarDados;
begin

  if Trim(Edt_PathArquivos.Text) = '' then
    begin
      Edt_PathArquivos.Text :=  ExtractFilePath(ParamStr(0))  + 'Tef\';
    end;

  try
    TControllerTefConfigIni.GravarString('TEF', 'IP_SERVER', Trim(Edt_IpServer.Text));
    TControllerTefConfigIni.GravarString('TEF', 'EMPRESA_CODIGO', Trim(Edt_EmpresaCodigo.Text));
    TControllerTefConfigIni.GravarString('TEF', 'EMPRESA_CNPJ', Trim(Edt_EmpresaCNPJ.Text));
    TControllerTefConfigIni.GravarString('TEF', 'TERMINAL', Trim(Edt_Terminal.Text));
    TControllerTefConfigIni.GravarString('TEF', 'CNPJ_SH', Trim(Edt_CNPJ_SH.Text));
    TControllerTefConfigIni.GravarString('TEF', 'PORTA_USB', Trim(Edt_PortaUsb.Text));
    TControllerTefConfigIni.GravarString('TEF', 'MSG_PINPAD', Trim(Edt_MsgPinPad.Text));
    TControllerTefConfigIni.GravarString('TEF', 'PATH_ARQUIVOS', Trim(Edt_PathArquivos.Text));
    TControllerTefConfigIni.GravarString('TEF', 'SENHA_ADM', Trim(Edt_SenhaADM.Text));
    TControllerTefConfigIni.GravarInteger('TEF', 'VERIFICA_PINPAD', IfThen(chkbx_VerificaPinPad.Checked, 1, 0));
    TControllerTefConfigIni.GravarInteger('TEF', 'CONFIRMA_TRANS_PENDENTES', IfThen(chkbx_ConfirmaPendentes.Checked, 1, 0));
    TControllerTefConfigIni.GravarInteger('TEF', 'SUPORTA_DESCONTO', IfThen(chkbx_SuportaDesconto.Checked, 1, 0));
    TControllerTefConfigIni.GravarInteger('TEF', 'LOCAL_QRCODE', cbbx_LocalQrcode.ItemIndex);
    TControllerTefConfigIni.GravarInteger('TEF', 'GERAR_LOG_TRASACOES', IfThen(chkbx_GerarLog.Checked, 1, 0));

    TControllerTefConfigIni.GravarString('IMPRESSORA', 'NOME', cbbImpressoras.Items[cbbImpressoras.ItemIndex]);
    TControllerTefConfigIni.GravarInteger('IMPRESSORA', 'FONTE_SIZE', sEdt_FontSize.Value);
    ModalResult :=  mrOk;
  except on E: Exception do
    begin
      MessageDlg('Erro ao Salvar dados: ' + sLineBreak  + e.Message, mtError, [mbOK], 0);
    end;
  end;

end;

procedure TFormTefConfig.SpeedButton1Click(Sender: TObject);
var
  SL: TStringList;
  I: integer;
begin
  try
    RscPrinter.Font.Size      :=  sEdt_FontSize.Value;
    RscPrinter.Colunas        := 50;
    RscPrinter.Margins.Left   := 10;
    RscPrinter.Margins.Top    := 0;
    RscPrinter.NomeImpressora := cbbImpressoras.Items[cbbImpressoras.ItemIndex];

    SL := TStringList.Create;
    try
      SL.Add('</zera>');
      SL.Add('</linha_dupla>');
      SL.Add('FONTE NORMAL: '+IntToStr(RscPrinter.Colunas)+' Colunas');
      SL.Add(LeftStr('....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8', RscPrinter.Colunas));
      SL.Add('<e>EXPANDIDO: '+IntToStr(RscPrinter.Colunas)+' Colunas');
      SL.Add(LeftStr('....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8', RscPrinter.Colunas));
      SL.Add('</e><c>CONDENSADO: '+IntToStr(RscPrinter.Colunas)+' Colunas');
      SL.Add(LeftStr('....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8', RscPrinter.Colunas));
      SL.Add('</c><n>FONTE NEGRITO</N>');
      SL.Add('<in>FONTE INVERTIDA</in>');
      SL.Add('<S>FONTE SUBLINHADA</s>');
      SL.Add('<i>FONTE ITALICO</i>');
      SL.Add('FONTE NORMAL');
      SL.Add('');
      SL.Add('TESTE DE ACENTOS. ¡…Õ”⁄·ÈÌÛ˙');
      SL.Add('');
      SL.Add('</corte_total>');

      for I := 0 to SL.Count - 1 do
      begin
        RscPrinter.AddLinhaImpressao(SL.Strings[I]);
      end;

      RscPrinter.Imprimir;
    finally
       SL.Free;
    end;
  except
    On E: Exception do
    begin
      MessageDlg('Falha ao ativar a Impressora' + sLineBreak + E.Message, mtError, [mbOK], 0);
    end;
  end
end;

end.
