object dmConexao: TdmConexao
  OnCreate = DataModuleCreate
  Height = 365
  Width = 563
  PixelsPerInch = 120
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=dba'
      'User_Name=root'
      'Password=Casa0604!'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 65
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\fe_ba\OneDrive\'#193'rea de Trabalho\Delphi\Sistema ERP\Sist' +
      'ema\Win32\Debug\libmysql.dll'
    Left = 208
    Top = 24
  end
end
