object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'bancoEstoque'
  ClientHeight = 554
  ClientWidth = 845
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label2: TLabel
    Left = 615
    Top = 48
    Width = 43
    Height = 15
    Caption = 'Produto'
  end
  object Label3: TLabel
    Left = 615
    Top = 80
    Width = 73
    Height = 15
    Caption = 'Qntd Produto'
  end
  object Label4: TLabel
    Left = 615
    Top = 112
    Width = 30
    Height = 15
    Caption = 'Pre'#231'o'
  end
  object btnInserir: TButton
    Left = 599
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Inserir'
    TabOrder = 0
    OnClick = btnInserirClick
  end
  object Edit2: TEdit
    Left = 694
    Top = 45
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 694
    Top = 74
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object Edit4: TEdit
    Left = 694
    Top = 103
    Width = 121
    Height = 23
    TabOrder = 3
  end
  object btnAlterar: TButton
    Left = 680
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 4
    OnClick = btnAlterarClick
  end
  object btnDeletar: TButton
    Left = 761
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Deletar'
    TabOrder = 5
    OnClick = btnDeletarClick
  end
  object ListView1: TListView
    Left = 8
    Top = 8
    Width = 585
    Height = 490
    Columns = <
      item
        Caption = 'Nome'
        Width = 400
      end
      item
        Caption = 'Quantidade'
        MinWidth = 50
        Width = 80
      end
      item
        Caption = 'Valor'
        MinWidth = 100
        Width = 100
      end>
    TabOrder = 6
    ViewStyle = vsReport
  end
end
