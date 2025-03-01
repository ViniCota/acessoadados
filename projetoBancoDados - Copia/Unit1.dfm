object DM: TDM
  Height = 480
  Width = 640
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=estoqueloja'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 48
  end
  object sqlConsulta: TFDQuery
    Active = True
    Connection = Conexao
    SQL.Strings = (
      'SELECT * FROM estoque')
    Left = 136
    Top = 48
    ParamData = <
      item
        Name = 'pConsulta'
        ParamType = ptInput
      end>
  end
  object dsSqlConsulta: TDataSource
    DataSet = FDQuery1
    Left = 228
    Top = 48
  end
  object FDQuery1: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      '')
    Left = 300
    Top = 56
    object FDQuery1ID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDQuery1nomeProduto: TStringField
      FieldName = 'nomeProduto'
      Origin = 'nomeProduto'
      Required = True
      Size = 50
    end
    object FDQuery1qntProduto: TIntegerField
      FieldName = 'qntProduto'
      Origin = 'qntProduto'
      Required = True
    end
    object FDQuery1valorProduto: TIntegerField
      FieldName = 'valorProduto'
      Origin = 'valorProduto'
      Required = True
    end
  end
end
