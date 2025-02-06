unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.DBCtrls, unit1, Vcl.ComCtrls;

type
  TForm2 = class(TForm)
    btnInserir: TButton;
    btnAlterar: TButton;
    btnDeletar: TButton;
    Edit2: TEdit; // Nome do Produto
    Edit3: TEdit; // Quantidade
    Edit4: TEdit; // Preço
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListView1: TListView;

    procedure FormCreate(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);

  private
    DataSource1: TDataSource;
    fbanco: TDM;
    procedure LerTabela;
    procedure InserirProduto;
    procedure AlterarProduto;
    procedure DeletarProduto;
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

// Método para carregar os dados da tabela no ListView
procedure TForm2.LerTabela;
var
  Item: TListItem;
begin
  ListView1.Items.Clear;
  fbanco.FDQuery1.Close;
  fbanco.FDQuery1.SQL.Text := 'SELECT * FROM estoque';
  fbanco.FDQuery1.Open;

  while not fbanco.FDQuery1.Eof do
  begin
    Item := ListView1.Items.Add;
    Item.Caption := fbanco.FDQuery1.FieldByName('nomeProduto').AsString;
    Item.SubItems.Add(fbanco.FDQuery1.FieldByName('qntProduto').AsString);
    Item.SubItems.Add(FormatFloat('R$ #,##0.00',
      fbanco.FDQuery1.FieldByName('valorProduto').AsFloat));

    fbanco.FDQuery1.Next;
  end;
end;

// Configuração inicial do formulário e conexão
procedure TForm2.FormCreate(Sender: TObject);
begin
  if not Assigned(fbanco) then
    fbanco := TDM.Create(self);

  if not Assigned(fbanco.Conexao) then
  begin
    ShowMessage('Erro: A conexão com o banco de dados não foi inicializada!');
    Exit;
  end;

  fbanco.FDQuery1.Connection := fbanco.Conexao;
  fbanco.dsSqlConsulta.DataSet := fbanco.FDQuery1;

  LerTabela;
end;

// Método para inserir um novo produto no banco de dados
procedure TForm2.InserirProduto;
begin
  if (Edit2.Text = '') or (Edit3.Text = '') or (Edit4.Text = '') then
  begin
    ShowMessage('Por favor, preencha todos os campos!');
    Exit;
  end;

  try
    StrToInt(Edit3.Text);
  except
    on E: EConvertError do
    begin
      ShowMessage('Quantidade inválida!');
      Exit;
    end;
  end;

  try
    StrToFloat(Edit4.Text);
  except
    on E: EConvertError do
    begin
      ShowMessage('Preço inválido!');
      Exit;
    end;
  end;

  fbanco.FDQuery1.Close;
  fbanco.FDQuery1.SQL.Text :=
    'INSERT INTO estoque (nomeProduto, qntProduto, valorProduto) VALUES (:produto, :qntdproduto, :preco)';

  fbanco.FDQuery1.ParamByName('produto').AsString := Edit2.Text;
  fbanco.FDQuery1.ParamByName('qntdproduto').AsInteger := StrToInt(Edit3.Text);
  fbanco.FDQuery1.ParamByName('preco').AsFloat := StrToFloat(Edit4.Text);

  try
    fbanco.FDQuery1.ExecSQL;
    ShowMessage('Produto inserido com sucesso!');
    LerTabela;
  except
    on E: Exception do
      ShowMessage('Erro ao inserir produto: ' + E.Message);
  end;
end;

procedure TForm2.btnInserirClick(Sender: TObject);
begin
  InserirProduto;
end;

// Método para alterar um produto no banco de dados
procedure TForm2.AlterarProduto;
var
  produtoAntigo, produtoNovo: string;
  quantidade: Integer;
  preco: Double;
begin
  if ListView1.Selected = nil then
  begin
    ShowMessage('Selecione um produto para alterar!');
    Exit;
  end;

  produtoAntigo := ListView1.Selected.Caption;
  produtoNovo := Edit2.Text;

  if (produtoNovo = '') or (Edit3.Text = '') or (Edit4.Text = '') then
  begin
    ShowMessage('Por favor, preencha todos os campos!');
    Exit;
  end;

  try
    quantidade := StrToInt(Edit3.Text);
  except
    on E: EConvertError do
    begin
      ShowMessage('Quantidade inválida!');
      Exit;
    end;
  end;

  try
    preco := StrToFloat(Edit4.Text);
  except
    on E: EConvertError do
    begin
      ShowMessage('Preço inválido!');
      Exit;
    end;
  end;

  fbanco.FDQuery1.Close;
  fbanco.FDQuery1.SQL.Text :=
    'UPDATE estoque SET nomeProduto = :produtoNovo, qntProduto = :qnt, valorProduto = :preco '
    + 'WHERE nomeProduto = :produtoAntigo';

  fbanco.FDQuery1.ParamByName('produtoNovo').AsString := produtoNovo;
  fbanco.FDQuery1.ParamByName('qnt').AsInteger := quantidade;
  fbanco.FDQuery1.ParamByName('preco').AsFloat := preco;
  fbanco.FDQuery1.ParamByName('produtoAntigo').AsString := produtoAntigo;

  try
    fbanco.FDQuery1.ExecSQL;
    ShowMessage('Produto alterado com sucesso!');
    LerTabela;
  except
    on E: Exception do
      ShowMessage('Erro ao alterar produto: ' + E.Message);
  end;
end;

procedure TForm2.btnAlterarClick(Sender: TObject);
begin
  AlterarProduto;
end;

procedure TForm2.DeletarProduto;
var
  produto: string;
begin
  if ListView1.Selected = nil then
  begin
    ShowMessage('Selecione um produto para excluir!');
    Exit;
  end;

  produto := ListView1.Selected.Caption;

  if MessageDlg('Tem certeza que deseja excluir o produto "' + produto + '"?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    fbanco.FDQuery1.Close;
    fbanco.FDQuery1.SQL.Text :=
      'DELETE FROM estoque WHERE nomeProduto = :produto';
    fbanco.FDQuery1.ParamByName('produto').AsString := produto;

    try
      fbanco.FDQuery1.ExecSQL;
      ShowMessage('Produto excluído com sucesso!');
      LerTabela;
    except
      on E: Exception do
        ShowMessage('Erro ao excluir produto: ' + E.Message);
    end;
  end;
end;

procedure TForm2.btnDeletarClick(Sender: TObject);
begin
  DeletarProduto;
end;

// Preenche os campos ao selecionar um item na ListView
procedure TForm2.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
  begin
    Edit2.Text := Item.Caption;
    Edit3.Text := Item.SubItems[0];
    Edit4.Text := StringReplace(Item.SubItems[1], 'R$ ', '', []);
  end;
end;

end.
