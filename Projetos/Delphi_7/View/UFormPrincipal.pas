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

unit UFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Mask
  , CliSiTef.Utils.Enuns
  , Controller.IniFiles
  , uFormTefConfig, DB, Grids, DBGrids
  , Buttons, Spin, ExtCtrls, DBClient

  ;

type
  TFormPrincipal = class(TForm)
    btn_Receber: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    btn_Gerencial: TButton;
    Label1: TLabel;
    cbbxTipoPgto: TComboBox;
    Label2: TLabel;
    cbbxTipoCartao: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    sedt_Parcelas: TSpinEdit;
    Label5: TLabel;
    cbbx_ModalidadePgto: TComboBox;
    sbtnGerarValor: TSpeedButton;
    EdValor: TEdit;
    pnl_btn_Ativar: TPanel;
    FDMem_Pagamentos: TClientDataSet;
    DBGrid2: TDBGrid;
    procedure btn_ReceberClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btn_GerencialClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbxTipoPgtoChange(Sender: TObject);
    procedure cbbx_ModalidadePgtoChange(Sender: TObject);
    procedure sbtnGerarValorClick(Sender: TObject);
    procedure pnl_btn_AtivarClick(Sender: TObject);
  private
    { Private declarations }
    procedure CriarCamposDataSet;
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses UFormPDVTEFDedicado;

procedure TFormPrincipal.btn_ReceberClick(Sender: TObject);
begin
  FormPDVTEFDedicado.CodigoOperadoraCredito   := 1;
  FormPDVTEFDedicado.CodigoOperadoraDebito    := 2;
  FormPDVTEFDedicado.CodigoOperadoraVoucher   := 3;
  FormPDVTEFDedicado.CodigoOperadoraPix       := 4;
  FormPDVTEFDedicado.ValorTransacionar        := StrToFloat(EdValor.Text);
  FormPDVTEFDedicado.Receber                  := True;

  FormPDVTEFDedicado.QRecCartao.Close;
  FormPDVTEFDedicado.QRecCartao.Open;

  FormPDVTEFDedicado.Parcelas :=  sedt_Parcelas.Value;

  case cbbxTipoPgto.ItemIndex of
    0:  FormPDVTEFDedicado.FormaPgto  :=  opCrtTodos;
    1:  FormPDVTEFDedicado.FormaPgto  :=  opCrtCheque;
    2:  FormPDVTEFDedicado.FormaPgto  :=  opCrtDebito;
    3:  FormPDVTEFDedicado.FormaPgto  :=  opCrtCredito;
    4:  FormPDVTEFDedicado.FormaPgto  :=  opCrtDebitoAVista;
    5:  FormPDVTEFDedicado.FormaPgto  :=  opCrtCarteiraDigital;
  end;

  case cbbxTipoCartao.ItemIndex of
    0:  FormPDVTEFDedicado.TipoCartao  :=  cMagChip;
    1:  FormPDVTEFDedicado.TipoCartao  :=  cDigit;
    2:  FormPDVTEFDedicado.TipoCartao  :=  cNone;
  end;

  if cbbx_ModalidadePgto.Items.Count > 0 then
    begin
      FormPDVTEFDedicado.ModalidadePgto :=  cbbx_ModalidadePgto.ItemIndex;
    end
  else
    begin
      FormPDVTEFDedicado.ModalidadePgto :=  0;
    end;

  FDMem_Pagamentos.Close;

  FormPDVTEFDedicado.edt_Transacao.Text :=  EdValor.Text;

  case FormPDVTEFDedicado.ShowModal of
    mrOk:
      begin
        FDMem_Pagamentos.Open;
        FormPDVTEFDedicado.QRecCartao.First;
        while not FormPDVTEFDedicado.QRecCartao.Eof do
          begin
            try
              FDMem_Pagamentos.Append;
              FDMem_Pagamentos.FieldByName('COD_OPERADORA').AsInteger :=  FormPDVTEFDedicado.QRecCartao.FieldByName('COD_OPERADORA').AsInteger;
              FDMem_Pagamentos.FieldByName('BANDEIRA').AsString       :=  FormPDVTEFDedicado.QRecCartao.FieldByName('BANDEIRA').AsString;
              FDMem_Pagamentos.FieldByName('DOCUMENTO').AsString      :=  FormPDVTEFDedicado.QRecCartao.FieldByName('DOCUMENTO').AsString;
              FDMem_Pagamentos.FieldByName('NSU').AsString            :=  FormPDVTEFDedicado.QRecCartao.FieldByName('NSU').AsString;
              FDMem_Pagamentos.FieldByName('NSU_HOST').AsString       :=  FormPDVTEFDedicado.QRecCartao.FieldByName('NSU_HOST').AsString;
              FDMem_Pagamentos.FieldByName('VALOR').AsFloat           :=  FormPDVTEFDedicado.QRecCartao.FieldByName('VALOR').AsFloat;
              FDMem_Pagamentos.FieldByName('PARCELA').AsInteger       :=  FormPDVTEFDedicado.QRecCartao.FieldByName('PARCELA').AsInteger;
              FDMem_Pagamentos.Post;
            finally
              FormPDVTEFDedicado.QRecCartao.Next;
            end;
          end;

        if (FormPDVTEFDedicado.QRecCartao.RecordCount > 0) then
          ShowMessage('Transacionado no TEF com Sucesso');
      end;
  end;
end;

procedure TFormPrincipal.Button2Click(Sender: TObject);
begin
  FormTefConfig  :=  TFormTefConfig.Create(nil);
  try
    FormTefConfig.ShowModal;
  finally
    FormTefConfig.Free;
  end;
end;

procedure TFormPrincipal.btn_GerencialClick(Sender: TObject);
begin
  FormPDVTEFDedicado.CodigoOperadoraCredito   := 1;
  FormPDVTEFDedicado.CodigoOperadoraDebito    := 2;
  FormPDVTEFDedicado.CodigoOperadoraVoucher   := 3;
  FormPDVTEFDedicado.CodigoOperadoraPix       := 4;
  FormPDVTEFDedicado.ValorTransacionar        := StrToFloat(EdValor.Text);
  FormPDVTEFDedicado.Receber                  := False;
  FormPDVTEFDedicado.Gerencial                := True;

  FormPDVTEFDedicado.SetIniciarGerencial;
end;

procedure TFormPrincipal.cbbxTipoPgtoChange(Sender: TObject);
begin
  cbbx_ModalidadePgto.Enabled :=  False;
  cbbxTipoCartao.Enabled :=  False;
  cbbx_ModalidadePgto.Clear;
  case cbbxTipoPgto.ItemIndex of
    2:
      begin
        cbbx_ModalidadePgto.Items.Add('Todas');
        cbbx_ModalidadePgto.Items.Add('A Vista');
        cbbx_ModalidadePgto.Items.Add('Compra e Saque');
        cbbx_ModalidadePgto.Items.Add('Consulta parcelas CDC');
        cbbx_ModalidadePgto.Items.Add('CDC');
        cbbx_ModalidadePgto.ItemIndex :=  0;
        cbbx_ModalidadePgto.Enabled :=  True;
        cbbxTipoCartao.Enabled :=  True;
      end;
    3:
      begin
        cbbx_ModalidadePgto.Items.Add('Todas');
        cbbx_ModalidadePgto.Items.Add('A Vista');
        cbbx_ModalidadePgto.Items.Add('Parcelado pelo Estabelecimento');
        cbbx_ModalidadePgto.Items.Add('Parcelado pela Administradora');
        cbbx_ModalidadePgto.Items.Add('Crediario');
        cbbx_ModalidadePgto.Items.Add('Consulta parcelamento');
        cbbx_ModalidadePgto.ItemIndex :=  0;
        cbbx_ModalidadePgto.Enabled :=  True;
        cbbxTipoCartao.Enabled :=  True;
      end;
    4:
      begin
        cbbxTipoCartao.Enabled :=  True;
      end;
  end;

  cbbx_ModalidadePgtoChange(cbbx_ModalidadePgto);

end;

procedure TFormPrincipal.cbbx_ModalidadePgtoChange(Sender: TObject);
begin
  sedt_Parcelas.Enabled :=  False;
  if cbbxTipoPgto.ItemIndex = 3 then
    begin
      if
        (cbbx_ModalidadePgto.ItemIndex = 2) or
        (cbbx_ModalidadePgto.ItemIndex = 3)
      then
        begin
          sedt_Parcelas.Enabled :=  True;
          sedt_Parcelas.Value :=  2;
        end;
    end;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  btn_Receber.Enabled :=  False;
  cbbxTipoPgto.Enabled :=  False;
  EdValor.Enabled :=  False;
  btn_Gerencial.Enabled :=  False;
  cbbxTipoCartao.Enabled :=  False;
  cbbx_ModalidadePgto.Clear;
  cbbx_ModalidadePgto.Enabled :=  False;
  sedt_Parcelas.Enabled :=  False;
  sbtnGerarValor.Enabled  :=  False;

  pnl_btn_Ativar.ParentBackground :=  False;
  pnl_btn_Ativar.ParentColor :=  False;
  pnl_btn_Ativar.Color  :=  clMaroon;

  CriarCamposDataSet;

end;

procedure TFormPrincipal.sbtnGerarValorClick(Sender: TObject);
begin
  EdValor.Text  :=  FormatFloat('#0.00', (Random(150)  + 10)  + Random);
end;

procedure TFormPrincipal.pnl_btn_AtivarClick(Sender: TObject);
begin

  if not Assigned(FormPDVTEFDedicado) then
    begin
      Application.CreateForm(TFormPDVTEFDedicado, FormPDVTEFDedicado);
    end;

  case TPanel(Sender).Tag of
    1:
      begin
        FormPDVTEFDedicado.DesativarTef;
        if not FormPDVTEFDedicado.RscTefCliSiTef1.Inicializada then
          begin
            TPanel(Sender).Color  :=  clMaroon;
            btn_Receber.Enabled :=  False;
            cbbxTipoPgto.Enabled :=  False;
            EdValor.Enabled :=  False;
            btn_Gerencial.Enabled :=  False;
            sbtnGerarValor.Enabled  :=  False;
            TPanel(Sender).Tag  :=  0;
            TPanel(Sender).Caption  :=  'Iniciar TEF';
          end;
      end;
    0:
      begin
        FormPDVTEFDedicado.AtivarTef;
        if FormPDVTEFDedicado.RscTefCliSiTef1.Inicializada then
          begin
            TPanel(Sender).Color  :=  clGreen;
            btn_Receber.Enabled :=  True;
            cbbxTipoPgto.Enabled :=  True;
            EdValor.Enabled :=  True;
            btn_Gerencial.Enabled :=  True;
            sbtnGerarValor.Enabled  :=  True;
            TPanel(Sender).Tag  :=  1;
            TPanel(Sender).Caption  :=  'Desativar TEF';
          end;
      end;
  end;
end;

procedure TFormPrincipal.CriarCamposDataSet;
var
  StrField: TStringField;
  IntField: TIntegerField;
  FloatField: TFloatField;
begin

  IntField  :=  TIntegerField.Create(FDMem_Pagamentos);
  IntField.FieldKind  :=  fkData;
  IntField.FieldName  :=  'COD_OPERADORA';
  IntField.DisplayLabel  :=  'COD_OPERADORA';
  IntField.DataSet  :=  FDMem_Pagamentos;

  IntField  :=  TIntegerField.Create(FDMem_Pagamentos);
  IntField.FieldKind  :=  fkData;
  IntField.FieldName  :=  'PARCELA';
  IntField.DisplayLabel  :=  'PARCELA';
  IntField.DataSet  :=  FDMem_Pagamentos;

  StrField  :=  TStringField.Create(FDMem_Pagamentos);
  StrField.FieldKind  :=  fkData;
  StrField.FieldName  :=  'BANDEIRA';
  StrField.DisplayLabel  :=  'BANDEIRA';
  StrField.DataSet  :=  FDMem_Pagamentos;
  StrField.Size :=  50;

  StrField  :=  TStringField.Create(FDMem_Pagamentos);
  StrField.FieldKind  :=  fkData;
  StrField.FieldName  :=  'DOCUMENTO';
  StrField.DisplayLabel  :=  'DOCUMENTO';
  StrField.DataSet  :=  FDMem_Pagamentos;
  StrField.Size :=  50;

  StrField  :=  TStringField.Create(FDMem_Pagamentos);
  StrField.FieldKind  :=  fkData;
  StrField.FieldName  :=  'NSU';
  StrField.DisplayLabel  :=  'NSU';
  StrField.DataSet  :=  FDMem_Pagamentos;
  StrField.Size :=  50;

  StrField  :=  TStringField.Create(FDMem_Pagamentos);
  StrField.FieldKind  :=  fkData;
  StrField.FieldName  :=  'NSU_HOST';
  StrField.DisplayLabel  :=  'NSU_HOST';
  StrField.DataSet  :=  FDMem_Pagamentos;
  StrField.Size :=  50;

  FloatField  :=  TFloatField.Create(FDMem_Pagamentos);
  FloatField.FieldKind  :=  fkData;
  FloatField.FieldName  :=  'VALOR';
  FloatField.DisplayLabel  :=  'VALOR';
  FloatField.DataSet  :=  FDMem_Pagamentos;

  FDMem_Pagamentos.CreateDataSet;
  FDMem_Pagamentos.Open;
end;

end.
