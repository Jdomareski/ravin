object dmRavin: TdmRavin
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 507
  Width = 760
  object cnxBancoDeDados: TFDConnection
    Params.Strings = (
      'Server='
      'Pooled='
      'Port='
      'DriverID=MySQL'
      'User_Name=root')
    UpdateOptions.AssignedValues = [uvUpdateMode]
    Connected = True
    AfterConnect = cnxBancoDeDadosAfterConnect
    BeforeConnect = cnxBancoDeDadosBeforeConnect
    Left = 648
    Top = 16
  end
  object drvBancoDeDados: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\jdomareski\Documents\delphi2Blu2022\Material Marcio\Pro' +
      'jeto Ravin\bibliotecas\libmysql.dll'
    Left = 648
    Top = 96
  end
  object wtcBancoDeDados: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 648
    Top = 184
  end
end
