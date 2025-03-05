using './main.bicep'

param storageAccountName = 'mvbicepcoursedev'
param sftpStorageAccountName = 'mvsftpbicepcoursedev'
param storageAccountSku = 'Standard_LRS'
param isSftpEnabled = false

param applicationInsightsName =  'mvappibicepcoursedev'

param appServicePlanName =  'mvappserviceplandev'
