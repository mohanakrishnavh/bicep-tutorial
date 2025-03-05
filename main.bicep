@description('Location for the resources')
param location string  = resourceGroup().location

@description('Tags for all resources')
param tags object = {}

@minLength(3)
@maxLength(24)
@description('The name of the storage account')
param storageAccountName string

@minLength(3)
@maxLength(24)
@description('The name of the storage account')
param sftpStorageAccountName string

@description('SKU for the storage account')
@allowed([
  'Standard_GRS'
  'Standard_LRS'
])
param storageAccountSku string

@description('Set storage account SFTP enabled')
param isSftpEnabled bool

@description('The name of the application insights resource')
param applicationInsightsName string

@description('The name of the app service plan resource')
param appServicePlanName string

@allowed([
  'S1'
  'B1'
])
param appServicePlanSku string = 'B1'

module storageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${storageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
  }
}

module sftpStorageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${sftpStorageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: sftpStorageAccountName
    storageAccountSku: storageAccountSku
  }
}

module applicationInsights 'modules/application-insights.bicep' = {
  name: 'deploy-${applicationInsightsName}'
  params: {
    applicationInsightsName: applicationInsightsName
    location: location
    tags: tags
  }
}

module appServicePlan 'modules/app-service-plan.bicep' = {
  name: 'deploy-${appServicePlanName}'
  params: {
    location: resourceGroup().location
    appServicePlanName: appServicePlanName
  }
}

output storageAccountName string = storageAccount.outputs.storageAccountName
output sftpStorageAccountName string = sftpStorageAccount.outputs.storageAccountName
output applicationInsightsName string = applicationInsights.outputs.applicationInsightsName
output appServicePlan string = appServicePlan.outputs.appServicePlanName
