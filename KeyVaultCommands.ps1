$DB_ENVIRONMENT =
$DB_SERVER_NAME =
$DB_DATABASE_NAME =
$DB_USERNAME =
$DB_PASSWORD =
$AZ_TENANT_ID =
$AZ_CLIENT_ID =
$AZ_CLIENT_SECRET =
$AZ_KEY_VAULT =
Write-Host
Write-Host "Getting environment variables from the .env file."
switch -File .env {
    default {
        $name, $value = $_.Trim() -split '=', 2
        if ($name -and $name[0] -ne '#') { # ignore blank and comment lines.
            if ($value) {
                Set-Variable -Name $name -Value $value -Scope Script
            }
        }
    }
}

<# Connect to Azure Key Vault.
$clientSecret = ConvertTo-SecureString $AZ_CLIENT_SECRET -AsPlainText -Force
$connectCreds = New-Object -TypeName System.Management.Automation.PSCredential($AZ_CLIENT_ID, $clientSecret)
Connect-AzAccount -ServicePrincipal -Credential $connectCreds -Tenant $AZ_TENANT_ID
<##>

<# Get all keys of a specific Key Vault
Get-AzKeyVaultKey -VaultName $AZ_KEY_VAULT
<##>

<# Get a key of a specific Key Vault
$akvKeyName = "test"
Get-AzKeyVaultKey -VaultName $AZ_KEY_VAULT -Name $akvKeyName -IncludeVersions
<##>

<# Create Key
$akvKeyName = "test"
$akvKey = Add-AzKeyVaultKey -VaultName $AZ_KEY_VAULT -Name $akvKeyName -Destination "Software"
Write-Host $akvKey.Key.Kid
<##>

<# Remove Key
$akvKeyName = "test"
Remove-AzKeyVaultKey -VaultName $AZ_KEY_VAULT -Name $akvKeyName -PassThru
<##>

<# Purge Key
$akvKeyName = "test"
Remove-AzKeyVaultKey -VaultName $AZ_KEY_VAULT -Name $akvKeyName -InRemovedState
<##>

<# Desactivate previous versions of keys
$vault = $AZ_KEY_VAULT
$keys = ( Get-AzKeyVaultKey -vaultName $vault | Select-Object Name ).Name
ForEach ( $key in $keys ) {
    Get-AzKeyVaultKey -vaultName $vault -name $key -IncludeVersions | 
        Sort-Object Created -Descending | 
        Select-Object -Skip 1 | 
            ForEach-Object { 
                Set-AzKeyVaultKeyAttribute -vaultName $_.VaultName -name $_.Name -Version $_.Version -Enable $False 
            }
}
<##>

<# Disconnect from Azure Key Vault.
Disconnect-AzAccount
<##>
