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

unit UFormPDVTEFDedicado;

interface

uses
  Windows, Messages
  , SysUtils, Variants, Classes
  , StrUtils
  , Graphics, Controls, Forms, Dialogs, UFormPDVBase, StdCtrls, ExtCtrls,
  Mask, ComCtrls,
  DB, RscTefCliSiTef

  {$IFDEF VER150}
  {$ELSE}
  , System.UITypes
  {$ENDIF}

  //Roniery
  , DelphiZXIngQRCode
  , Rsc.Vcl.RscPrinter
  , Controller.IniFiles
//  , RscTefCliSiTef
  , CliSiTef.Classes.TefCupom
  , CliSiTef.Classes.TefTransacao
  , CliSiTef.Classes.TefRetorno
  , CliSiTef.Utils.Enuns
  , frMenuTEF
  , frObtemCampo
  , DateUtils, jpeg, DBClient
  //Roniery

  ;

type
  TFormPDVTEFDedicado = class(TFormPDVBase)
    RscTefCliSiTef1: TRscTefCliSiTef;
    pnl_Vlr_msg: TPanel;
    pnl_CupomQrcode: TPanel;
    pnl_BordaMargemE: TPanel;
    pnl_BordaMargemD: TPanel;
    Mm_Cupom: TMemo;
    imgQRCode: TImage;
    Label1: TLabel;
    Panel7: TPanel;
    edt_Transacao: TEdit;
    lblAguardando: TLabel;
    Panel8: TPanel;
    lblop: TLabel;
    lMensagemTef: TLabel;
    pnl_btn_Close: TPanel;
    QRecCartao: TClientDataSet;
    pnl_tools: TPanel;
    procedure FormShow(Sender: TObject);
    procedure RscTefCliSiTef1AguardaResp(Arquivo: string;
      SegundosTimeOut: Integer; var Interromper: Boolean);
    procedure RscTefCliSiTef1ExibeMenu(Titulo: string; Opcoes: TStringList;
      var ItemSelecionado: Integer; var VoltarMenu: Boolean);
    procedure RscTefCliSiTef1ExibeMsg(Operacao: TRscTEFOperacaoMensagem;
      Mensagem: string; var AModalResult: TModalResult);
    procedure RscTefCliSiTef1FinalTransacao(const Cupom: TTefCupom);
    procedure RscTefCliSiTef1ImprimeVia(Via: Integer;
      ImagemComprovante: TStringList);
    procedure RscTefCliSiTef1ExibeQrCode(const Dados: string);
    procedure RscTefCliSiTef1ObtemCampo(Titulo: string; TamanhoMinimo,
      TamanhoMaximo, TipoCampo: Integer; Operacao: TRscTEFCliSiTefOperacaoCampo;
      var Resposta: string; var Digitado, VoltarMenu: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edt_TransacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pnl_btn_CloseClick(Sender: TObject);
    procedure RscTefCliSiTef1GravarLog(const ALogLine: String;
      var Tratado: Boolean);
  private

    FCodigoOperadoraCredito: integer;
    FCodigoOperadoraDebito: integer;
    FCodigoOperadoraVoucher: integer;
    FCodigoOperadoraPix: integer;
    FValorTransacionar: Currency;

    //Roniery
    FCanceladoPeloOperador  :  Boolean;
    FReceber: Boolean;
    FGerencial: Boolean;
    FFrmMsgSplash: TForm;
    FFormaPgto: TRscTefOpCRT;
    FTipoCartao: TTecCart;
    FParcelas: integer;
    FModalidadePgto: integer;
    FLogTratado: Boolean;
    //Roniery

    FAtivandoEncerrandoTef: Boolean;
    //Roniery
    procedure SetTEFIniciar;

    procedure CarregarConfiguracaoTef;

    procedure CriarFrmMsgSplash;
    procedure ExibirFrmMsgSplash(const Esconder: Boolean = False);
    procedure UpdateTextFrmMsgSplash(const Text: string);
    procedure CarregarImagemLogo;
    procedure CriarCamposDataSet;

    //Roniery
  public

    procedure AtivarTef;
    procedure DesativarTef;
    procedure SetIniciarGerencial;

    property CodigoOperadoraDebito : integer read FCodigoOperadoraDebito write FCodigoOperadoraDebito;
    property CodigoOperadoraCredito : integer read FCodigoOperadoraCredito write FCodigoOperadoraCredito;
    property CodigoOperadoraPix : integer read FCodigoOperadoraPix write FCodigoOperadoraPix;
    property CodigoOperadoraVoucher : integer read FCodigoOperadoraVoucher write FCodigoOperadoraVoucher;
    property ValorTransacionar : Currency read FValorTransacionar write FValorTransacionar;
    property Receber: Boolean read FReceber write FReceber;
    property Gerencial: Boolean read FGerencial write FGerencial;
    property FormaPgto: TRscTefOpCRT read FFormaPgto write FFormaPgto;
    property TipoCartao: TTecCart read FTipoCartao write FTipoCartao;
    property Parcelas: integer read FParcelas write FParcelas;
    property ModalidadePgto: integer read FModalidadePgto write FModalidadePgto;

  end;

var
  FormPDVTEFDedicado: TFormPDVTEFDedicado;

implementation

uses
  Rsc.Vcl.Utils;

{$R *.dfm}

procedure TFormPDVTEFDedicado.AtivarTef;
begin
  FAtivandoEncerrandoTef  :=  True;
  UpdateTextFrmMsgSplash('Carregando TEF');
  Sleep(500);
  try
    UpdateTextFrmMsgSplash('Carregando configuração do TEF');
    Sleep(500);
    CarregarConfiguracaoTef;
    UpdateTextFrmMsgSplash('Iniciando TEF');
    if RscTefCliSiTef1.Inicializada then
      begin
        Exit;
      end
    else
      begin
        try
          RscTefCliSiTef1.Inicializar;
          UpdateTextFrmMsgSplash('TEF iniciado com sucesso');
          Sleep(1000);
        except on E: Exception do
          begin
            MessageDlg('Erro ao iniciar CliSitef: ' + e.Message, mtError, [mbOK], 0);
          end;
        end;
//        if RscTefCliSiTef1.Inicializada then
//          begin
//            RscTefCliSiTef1.ATV;
//          end;
      end;
  finally
    FAtivandoEncerrandoTef  :=  False;
    ExibirFrmMsgSplash(True);
  end;
end;

procedure TFormPDVTEFDedicado.DesativarTef;
begin
  UpdateTextFrmMsgSplash('Desinicializando TEF');
  Sleep(500);
  try
    if not RscTefCliSiTef1.Inicializada then
      begin
        Exit;
      end
    else
      begin
        try
          RscTefCliSiTef1.Desinicializar;
          UpdateTextFrmMsgSplash('TEF Desinicializado!');
          Sleep(500);
        except on E: Exception do
          begin
            MessageDlg('Erro ao Desinicializar CliSitef: ' + e.Message, mtError, [mbOK], 0);
          end;
        end;
      end;
  finally
    FAtivandoEncerrandoTef  :=  False;
    ExibirFrmMsgSplash(True);
  end;
end;

procedure TFormPDVTEFDedicado.CarregarConfiguracaoTef;
begin
  FLogTratado :=  TControllerTefConfigIni.LerInteger('TEF', 'GERAR_LOG_TRASACOES', 1) = 0;

//  {$REGION 'preenchendo a classe de configuração'}
  RscTefCliSiTef1.ArqLOG  :=  ExtractFilePath(ParamStr(0))  + 'RscTefLog_'  + FormatDateTime('ddmmyyyhhnnsszzzz', Now)  + '.log';
  //IP onde o Gerenciador do TEF esta instalado
  RscTefCliSiTef1.TefConfig.Tef_Ip :=  TControllerTefConfigIni.LerString('TEF', 'IP_SERVER', '');;
  //Codigo da Empresa
  RscTefCliSiTef1.TefConfig.Tef_Empresa := TControllerTefConfigIni.LerString('TEF', 'EMPRESA_CODIGO', '');;
  //CNPJ da Empresa que usará o TEF
  RscTefCliSiTef1.TefConfig.Tef_EmpresaCnpj :=  TControllerTefConfigIni.LerString('TEF', 'EMPRESA_CNPJ', '');
  //Numero do Terminal que esta acessando o TEF com 6 posições numericas com zero a esquerda
  RscTefCliSiTef1.TefConfig.Tef_Terminal :=  TControllerTefConfigIni.LerString('TEF', 'TERMINAL', '');
  //CNPJ da Software House Homologada no Sitef
  RscTefCliSiTef1.TefConfig.Tef_SoftHouseCnpj :=  TControllerTefConfigIni.LerString('TEF', 'CNPJ_SH', '');
  //Porta onde o PinPad esta conectado Ex: AUTO_USB ou a porta Serial: 01, 02, 03 etc sem o inicio COM
  RscTefCliSiTef1.TefConfig.Tef_PinPadPorta :=  TControllerTefConfigIni.LerString('TEF', 'PORTA_USB', '');
  //Mensagem que vai aparecer no visor do PinPad
  RscTefCliSiTef1.TefConfig.Tef_PinPadMensagem :=  TControllerTefConfigIni.LerString('TEF', 'MSG_PINPAD', '');
  //Verificar ser o PinPad esta conectado Parametros: 0 = NAO   e   1 = SIM
  RscTefCliSiTef1.TefConfig.Tef_PinPadVerificar :=  TControllerTefConfigIni.LerInteger('TEF', 'VERIFICA_PINPAD', 0) = 1;
  //Verificar ser o QrCode em Pagamento Digitais sera enviado ao PinPad Parametros: 0 = NAO   e   1 = SIM

//   0 Não Suportado
//   1 Auto
//   2 Exibir no PinPad
//   3 Exibir na Tela
//   4 Imprimir

  RscTefCliSiTef1.TefConfig.Tef_PinPadQrCode :=  TControllerTefConfigIni.LerInteger('TEF', 'LOCAL_QRCODE', 2) = 2;
  RscTefCliSiTef1.TefConfig.Tef_PathArquivos :=
    Rsc.Vcl.Utils.IfThen(
      TControllerTefConfigIni.LerString('TEF', 'PATH_ARQUIVOS', '') = '',
      ExtractFilePath(ParamStr(0))  + 'Tef\',
      TControllerTefConfigIni.LerString('TEF', 'PATH_ARQUIVOS', ''));
//  mTefConfig.Tef_ParametrosAdicionais :=  nil;  //não por nil aqui
  RscTefCliSiTef1.TefConfig.Tef_SuportaDesconto :=  TControllerTefConfigIni.LerInteger('TEF', 'SUPORTA_DESCONTO', 0) = 1;
  //
  RscTefCliSiTef1.TefConfig.Tef_ConfirmaTransacaoPendente :=  TControllerTefConfigIni.LerInteger('TEF', 'CONFIRMA_TRANS_PENDENTES', 0) = 1;

  //
  RscTefCliSiTef1.PasswordAdmin :=  TControllerTefConfigIni.LerString('TEF', 'SENHA_ADM', '123456');
//  {$ENDREGION}

end;

procedure TFormPDVTEFDedicado.CriarFrmMsgSplash;
begin
  if not Assigned(FFrmMsgSplash) then
    begin
      FFrmMsgSplash :=  TForm.Create(nil);

      FFrmMsgSplash.Color       :=  $00643A0B;
      FFrmMsgSplash.BorderStyle :=  bsNone;
      FFrmMsgSplash.Height      :=  100;
      FFrmMsgSplash.Width       :=  350;
      FFrmMsgSplash.Top         :=  (Screen.Height div 2) - 50;
      FFrmMsgSplash.Left        :=  (Screen.Width div 2) - 175;

      with TLabel.Create(FFrmMsgSplash)  do
        begin
          Parent      :=  FFrmMsgSplash;
          Color       :=  $00643A0B;
          Font.Color  :=  clWhite;
          Font.Size   :=  16;
          Align       :=  alClient;
          Alignment   :=  taCenter;
          Layout      :=  tlCenter;
          Caption     :=  '...';
        end;

    end;

end;

procedure TFormPDVTEFDedicado.ExibirFrmMsgSplash(const Esconder: Boolean);
begin
  if Assigned(FFrmMsgSplash) then
    begin
      if not FFrmMsgSplash.Showing then
        begin
          FFrmMsgSplash.Show;
          FFrmMsgSplash.Top         :=  (Screen.Height div 2) - 50;
          FFrmMsgSplash.Left        :=  (Screen.Width div 2) - 125;
        end
      else
        begin
          if Esconder then
            begin
              FFrmMsgSplash.Hide;
            end;
        end;
    end;
end;

procedure TFormPDVTEFDedicado.UpdateTextFrmMsgSplash(const Text: string);
begin
  if Assigned(FFrmMsgSplash) then
    begin
      ExibirFrmMsgSplash;
      if FFrmMsgSplash.ControlCount > 0 then
        begin
          TLabel(FFrmMsgSplash.Controls[0]).Caption :=  Text;
          Application.ProcessMessages;
        end;
    end;
end;

procedure TFormPDVTEFDedicado.FormCreate(Sender: TObject);
begin
  inherited;
  CarregarImagemLogo;
  Mm_Cupom.Visible  :=  False;
  imgQRCode.Visible  :=  True;
  lblAguardando.Caption :=  '';
  lblop.Caption :=  '';
  lMensagemTef.Caption :=  '';

  pnl_btn_Close.ParentBackground :=  False;
  pnl_btn_Close.ParentColor :=  False;
  pnl_btn_Close.Color  :=  $004080FF;

  FAtivandoEncerrandoTef  :=  False;
  FFormaPgto :=  opCrtTodos;
  FTipoCartao :=  cMagChip;
  FParcelas :=  0;
  FModalidadePgto :=  0;
  CriarCamposDataSet;
  Receber :=  False;
  Gerencial :=  False;
  CriarFrmMsgSplash;
end;

procedure TFormPDVTEFDedicado.FormDestroy(Sender: TObject);
begin
  inherited;
  if RscTefCliSiTef1.Inicializada then
    begin
      UpdateTextFrmMsgSplash('Encerrando TEF');
      RscTefCliSiTef1.Desinicializar;
    end;
  FFrmMsgSplash.Free;
end;

procedure TFormPDVTEFDedicado.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #27 then
    begin
      if not FCanceladoPeloOperador then
        FCanceladoPeloOperador  :=  True;
    end;
end;

procedure TFormPDVTEFDedicado.FormShow(Sender: TObject);
begin
  inherited;
  edt_Transacao.Text  :=  FormatFloat('R$ #0.00', FValorTransacionar);
  if  Gerencial then
    begin
      edt_Transacao.Visible :=  False;
      edt_Transacao.Enabled :=  False;
    end;
end;

procedure TFormPDVTEFDedicado.SetTEFIniciar;
begin
  RscTefCliSiTef1.SetConfigCRT(
    integer(FormaPgto),
    TipoCartao,
    ModalidadePgto,
    Parcelas
    );

  RscTefCliSiTef1.SetCRT(ValorTransacionar, FormatDateTime('zzzzssnnhhddmmyy', Now), '', 'Roniery');

end;

procedure TFormPDVTEFDedicado.RscTefCliSiTef1AguardaResp(Arquivo: string;
  SegundosTimeOut: Integer; var Interromper: Boolean);
var
  Msg:  string;
begin
  inherited;
  if FCanceladoPeloOperador then
  begin
    FCanceladoPeloOperador := False;
    Interromper := True;
    lblAguardando.Caption :=  'Aguarde processo sendo cancelado.';
    Exit;
  end;

  Msg := '';

  if (Arquivo = '23') {and xTecladoBloqueado} then  // Está aguardando Pin-Pad ?
    begin
      Msg := 'Aguardando Resposta do Pinpad. ' + #13 + 'Pressione <ESC> para Cancelar';
    end;

  if Msg <> '' then
    begin
      lblAguardando.Caption :=  Msg;
    end;

  Application.ProcessMessages;
end;

procedure TFormPDVTEFDedicado.RscTefCliSiTef1ExibeMenu(Titulo: string;
  Opcoes: TStringList; var ItemSelecionado: Integer; var VoltarMenu: Boolean);
Var
  MR: TModalResult ;
  FormMenuTEF: TFormMenuTEF;
begin
  inherited;

  FormMenuTEF := TFormMenuTEF.Create(nil);
  try
    FormMenuTEF.Titulo := Titulo;
    FormMenuTEF.Opcoes := Opcoes;

    MR := FormMenuTEF.ShowModal ;

    VoltarMenu := (MR = mrRetry) ;

    if (MR = mrOK) then
      begin
        ItemSelecionado := FormMenuTEF.ItemSelecionado;
      end;

  finally
    FormMenuTEF.Free;
  end;
end;

procedure TFormPDVTEFDedicado.RscTefCliSiTef1ExibeMsg(
  Operacao: TRscTEFOperacaoMensagem; Mensagem: string;
  var AModalResult: TModalResult);
var
   Fim : TDateTime;
   OldMensagem : String;
begin
  inherited;

  case Operacao of
    opmOK:
      begin
        AModalResult := MessageDlg( Mensagem, mtInformation, [mbOK], 0);
        lblAguardando.Caption :=  '';

        if AnsiLowerCase('Operação cancelada pelo operador') = AnsiLowerCase(Mensagem) then
          begin
            if Receber then
              begin
                Mm_Cupom.Clear;
                ModalResult :=  mrCancel;
              end;
          end;
      end;

    opmYesNo:
       AModalResult := MessageDlg( Mensagem, mtConfirmation, [mbYes, mbNo], 0);

    opmExibirMsgOperador:
      begin
        lblop.Caption :=  Mensagem;
        if FAtivandoEncerrandoTef then
          begin
            UpdateTextFrmMsgSplash(Mensagem);
          end;
      end;

    opmRemoverMsgOperador:
      begin
        lblop.Caption :=  '';
        if FAtivandoEncerrandoTef then
          begin
            UpdateTextFrmMsgSplash(Mensagem);
          end;
      end;

    opmExibirMsgCliente:
      begin
        lMensagemTef.Caption :=  Mensagem;
      end;

    opmRemoverMsgCliente:
      begin
        lMensagemTef.Caption :=  '';
      end;

    opmDestaqueVia:
      begin
        OldMensagem := 'Transação OK!';
        try
          { Aguardando 3 segundos }
          Fim := IncSecond(now, 3)  ;
          repeat
            lblAguardando.Caption :=  Mensagem + ' ' + IntToStr(SecondsBetween(Fim,now));
            Sleep(200) ;
          until (now > Fim) ;
        finally
          lblAguardando.Caption :=  OldMensagem;
        end;
      end;
  end;

  Application.ProcessMessages;
end;

procedure TFormPDVTEFDedicado.RscTefCliSiTef1ExibeQrCode(const Dados: string);
var
  QRCode: TDelphiZXingQRCode;
  QRCodeBitmap: TBitmap;
  Row, Column: Integer;

begin
  inherited;

  if (Dados = '') then
  begin
    CarregarImagemLogo;
      imgQRCode.BringToFront;
      Mm_Cupom.Visible  :=  False;
      Mm_Cupom.SendToBack;
      Application.ProcessMessages;
    Exit;
  end;

  QRCode := TDelphiZXingQRCode.Create;
  QRCodeBitmap := TBitmap.Create;
  try
    QRCode.Encoding := qrUTF8BOM;
    QRCode.QuietZone := 2;
    QRCode.Data := widestring(Dados);

    QRCodeBitmap.Width := QRCode.Columns;
    QRCodeBitmap.Height := QRCode.Rows;

    for Row := 0 to QRCode.Rows - 1 do
    begin
      for Column := 0 to QRCode.Columns - 1 do
      begin
        if (QRCode.IsBlack[Row, Column]) then
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clBlack
        else
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;
      end;
    end;

//    TThread.Synchronize(nil,
//    procedure
//    begin
      imgQRCode.Visible :=  True;
      imgQRCode.Picture.Bitmap.Assign(QRCodeBitmap);
      imgQRCode.BringToFront;
      Mm_Cupom.Visible  :=  False;
      Mm_Cupom.SendToBack;
      Application.ProcessMessages;
//    end);

  finally
    QRCode.Free;
    QRCodeBitmap.Free;
  end;
end;

procedure TFormPDVTEFDedicado.RscTefCliSiTef1FinalTransacao(
  const Cupom: TTefCupom);
var
  Transacao: TTefTransacao;
  P: Integer;
  iCOD_OPERADORA: integer;
  I: integer;
  TotalParcelas: integer;
begin
  inherited;
  Mm_Cupom.Visible  :=  False;
  imgQRCode.Visible  :=  True;
  Application.ProcessMessages;

    for I := 0 to Cupom.Transacoes.count - 1 do
    begin
      Transacao := Cupom.Transacoes.Items[I] as TTefTransacao;
      if  Trim(Transacao.NSU) = '' then
        begin
          Continue;
        end;
      TotalParcelas :=  StrToIntDef(Transacao.Parcelas, 0);

      if TotalParcelas >= 1 then
        begin
          for P := 1 to TotalParcelas do
            begin
              case
                AnsiIndexStr(Transacao.MdPgtoCodigo,
                [
                  '00', //CHEQUE
                  '01', //CARTAO DE DEBITO
                  '02', //CARTAO DE CREDITO
                  '03', //CARTAO TIPO VOUCHER
                  '05', //CARTAO FIDELIDADE
                  '98', //DINHEIRO
                  '99'  //OUTRO TIPO DE CARTAO
                ])
              of
                0: iCOD_OPERADORA :=  0;  //CHEQUE
                1: iCOD_OPERADORA :=  2;  //CARTAO DE DEBITO
                2: iCOD_OPERADORA :=  1;  //CARTAO DE CREDITO
                3: iCOD_OPERADORA :=  3;  //CARTAO TIPO VOUCHER
                4: iCOD_OPERADORA :=  0;  //CARTAO FIDELIDADE
                5: iCOD_OPERADORA :=  0;  //DINHEIRO
                6: iCOD_OPERADORA :=  0;  //OUTRO TIPO DE CARTAO
              else
                iCOD_OPERADORA :=  4;
              end;

              QRecCartao.Append;
              try
                QRecCartao.FieldByName('COD_OPERADORA').AsInteger :=  iCOD_OPERADORA;
                QRecCartao.FieldByName('BANDEIRA').AsString       :=  Transacao.BandeiraNome;
                QRecCartao.FieldByName('DOCUMENTO').AsString      :=  Transacao.DocumentoVinculado;
                QRecCartao.FieldByName('NSU').AsString            :=  Transacao.NSU;
                QRecCartao.FieldByName('NSU_HOST').AsString       :=  Transacao.NSUHost;
                QRecCartao.FieldByName('VALOR').AsFloat           :=  Transacao.ValorTransacao; //(Transacao.ValorTransacao / TotalParcelas);
                QRecCartao.FieldByName('PARCELA').AsInteger       :=  P;
              finally
                QRecCartao.Post;
              end;
            end;
        end
      else
        begin
          if UpperCase(Transacao.BandeiraNome) = 'PIX' then
            begin
              iCOD_OPERADORA  :=  4;
            end
          else
            begin
              case
                AnsiIndexStr(Transacao.MdPgtoCodigo,
                [
                  '00', //CHEQUE
                  '01', //CARTAO DE DEBITO
                  '02', //CARTAO DE CREDITO
                  '03', //CARTAO TIPO VOUCHER
                  '05', //CARTAO FIDELIDADE
                  '98', //DINHEIRO
                  '99'  //OUTRO TIPO DE CARTAO
                ])
              of
                0: iCOD_OPERADORA :=  0;  //CHEQUE
                1: iCOD_OPERADORA :=  2;  //CARTAO DE DEBITO
                2: iCOD_OPERADORA :=  1;  //CARTAO DE CREDITO
                3: iCOD_OPERADORA :=  3;  //CARTAO TIPO VOUCHER
                4: iCOD_OPERADORA :=  0;  //CARTAO FIDELIDADE
                5: iCOD_OPERADORA :=  0;  //DINHEIRO
                6: iCOD_OPERADORA :=  0;  //OUTRO TIPO DE CARTAO
              else
                iCOD_OPERADORA :=  4;
              end;
            end;

         QRecCartao.Append;
          try
            QRecCartao.FieldByName('COD_OPERADORA').AsInteger :=  iCOD_OPERADORA;
            QRecCartao.FieldByName('BANDEIRA').AsString       :=  Transacao.BandeiraNome;
            QRecCartao.FieldByName('DOCUMENTO').AsString      :=  Transacao.DocumentoVinculado;
            QRecCartao.FieldByName('NSU').AsString            :=  Transacao.NSU;
            QRecCartao.FieldByName('NSU_HOST').AsString       :=  Transacao.NSUHost;
            QRecCartao.FieldByName('VALOR').AsFloat           :=  Transacao.ValorTransacao;
            QRecCartao.FieldByName('PARCELA').AsInteger       :=  0;
          finally
            QRecCartao.Post;
          end;
        end;
    end;

  Mm_Cupom.Visible  :=  False;
  imgQRCode.Visible  :=  True;
  lblAguardando.Caption :=  '';
  lblop.Caption :=  '';
  lMensagemTef.Caption :=  '';
  edt_Transacao.Enabled :=  True;
  ModalResult :=  mrOk;
  Mm_Cupom.Clear;
end;

procedure TFormPDVTEFDedicado.RscTefCliSiTef1ImprimeVia(Via: Integer;
  ImagemComprovante: TStringList);
var
  I: Integer;
begin
  inherited;

  imgQRCode.SendToBack;
  imgQRCode.Visible :=  False;

//  TThread.Synchronize(nil, procedure begin
    Mm_Cupom.Visible  :=  True;
    Mm_Cupom.BringToFront;
    Mm_Cupom.Text :=  ImagemComprovante.Text;
    Application.ProcessMessages;
//  end);

  RscPrinter.Font.Size      :=  TControllerTefConfigIni.LerInteger('IMPRESSORA', 'FONTE_SIZE', 10);
  RscPrinter.Margins.Top    :=  0;
  RscPrinter.Colunas        :=  80;
  RscPrinter.NomeImpressora :=  TControllerTefConfigIni.LerString('IMPRESSORA', 'NOME', '');

  for I := 0 to ImagemComprovante.Count - 1 do
  begin
    RscPrinter.AddLinhaImpressao(ImagemComprovante.Strings[I]);
  end;

  RscPrinter.Imprimir;
end;

procedure TFormPDVTEFDedicado.RscTefCliSiTef1ObtemCampo(Titulo: string;
  TamanhoMinimo, TamanhoMaximo, TipoCampo: Integer;
  Operacao: TRscTEFCliSiTefOperacaoCampo; var Resposta: string; var Digitado,
  VoltarMenu: Boolean);
Var
  MR: TModalResult ;
  FormObtemCampo: TFormObtemCampo;
begin
  inherited;

  FormObtemCampo := TFormObtemCampo.Create(nil);
  try
    FormObtemCampo.Titulo := Titulo;
    FormObtemCampo.TamanhoMaximo := TamanhoMaximo;
    FormObtemCampo.TamanhoMinimo := TamanhoMinimo;
    FormObtemCampo.Resposta := widestring(Resposta); { Para usar Valores Previamente informados }

    case Operacao of
      tcDouble:
        FormObtemCampo.TipoCampo := tcoCurrency;
      tcCMC7, tcBarCode:
        FormObtemCampo.TipoCampo := tcoNumeric;
    else
      FormObtemCampo.TipoCampo := tcoString;
    end;

    if (Operacao = tcStringMask) then
      begin
        FormObtemCampo.Ocultar := True;
      end;

    MR := FormObtemCampo.ShowModal ;

    if (Operacao = tcStringMask) then
      begin
        if  (FormObtemCampo.Resposta <> RscTefCliSiTef1.PasswordAdmin) or (RscTefCliSiTef1.PasswordAdmin = '') then
          begin
            MessageDlg('Senha Informada é Inválida', mtWarning, [mbOK], 0);
            Digitado    :=  false;
            VoltarMenu  :=  True;
            Resposta    :=  '';
            Exit;
          end;
      end;

    Digitado := (MR = mrOK) ;
    VoltarMenu := (MR = mrRetry) ;

    if Digitado then
       Resposta := FormObtemCampo.Resposta;
  finally
    FormObtemCampo.Free;
  end;
end;

procedure TFormPDVTEFDedicado.edt_TransacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if  key = VK_RETURN then
    begin
      TEdit(Sender).Enabled :=  False;
      Key := 0;
      SetTEFIniciar;
    end;
end;

procedure TFormPDVTEFDedicado.pnl_btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFormPDVTEFDedicado.CarregarImagemLogo;
var
  pathlogo: string;
begin
  pathlogo  :=  ExtractFilePath(ParamStr(0))  + 'Marca_940X390px.jpg';

  if FileExists(pathlogo) then
    begin
      { remover o QrCode e add logo }
      try
        imgQRCode.Picture.LoadFromFile(pathlogo);
      except
      end;                                       
    end;
end;

procedure TFormPDVTEFDedicado.RscTefCliSiTef1GravarLog(
  const ALogLine: String; var Tratado: Boolean);
begin
  inherited;
  Tratado :=  FLogTratado;
end;

procedure TFormPDVTEFDedicado.CriarCamposDataSet;
var
  StrField: TStringField;
  IntField: TIntegerField;
  FloatField: TFloatField;
begin

  IntField  :=  TIntegerField.Create(QRecCartao);
  IntField.FieldKind  :=  fkData;
  IntField.FieldName  :=  'COD_OPERADORA';
  IntField.DisplayLabel  :=  'COD_OPERADORA';
  IntField.DataSet  :=  QRecCartao;

  IntField  :=  TIntegerField.Create(QRecCartao);
  IntField.FieldKind  :=  fkData;
  IntField.FieldName  :=  'PARCELA';
  IntField.DisplayLabel  :=  'PARCELA';
  IntField.DataSet  :=  QRecCartao;

  StrField  :=  TStringField.Create(QRecCartao);
  StrField.FieldKind  :=  fkData;
  StrField.FieldName  :=  'BANDEIRA';
  StrField.DisplayLabel  :=  'BANDEIRA';
  StrField.DataSet  :=  QRecCartao;
  StrField.Size :=  50;

  StrField  :=  TStringField.Create(QRecCartao);
  StrField.FieldKind  :=  fkData;
  StrField.FieldName  :=  'DOCUMENTO';
  StrField.DisplayLabel  :=  'DOCUMENTO';
  StrField.DataSet  :=  QRecCartao;
  StrField.Size :=  50;

  StrField  :=  TStringField.Create(QRecCartao);
  StrField.FieldKind  :=  fkData;
  StrField.FieldName  :=  'NSU';
  StrField.DisplayLabel  :=  'NSU';
  StrField.DataSet  :=  QRecCartao;
  StrField.Size :=  50;

  StrField  :=  TStringField.Create(QRecCartao);
  StrField.FieldKind  :=  fkData;
  StrField.FieldName  :=  'NSU_HOST';
  StrField.DisplayLabel  :=  'NSU_HOST';
  StrField.DataSet  :=  QRecCartao;
  StrField.Size :=  50;

  FloatField  :=  TFloatField.Create(QRecCartao);
  FloatField.FieldKind  :=  fkData;
  FloatField.FieldName  :=  'VALOR';
  FloatField.DisplayLabel  :=  'VALOR';
  FloatField.DataSet  :=  QRecCartao;

  QRecCartao.CreateDataSet;
  QRecCartao.Open;

end;

procedure TFormPDVTEFDedicado.SetIniciarGerencial;
begin
  edt_Transacao.Visible :=  False;
  edt_Transacao.Enabled :=  False;
  RscTefCliSiTef1.ADM;
end;

end.
