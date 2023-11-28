Identifier=$(date +%y%m%d%H%M%S)
servicePrincipalName="s2pcreation-sp-$Identifier"
roleName="s2pcreation"
subscriptionID=$(az account show --query id --output tsv)
echo "Using subscription ID $subscriptionID"
resourceGroup="s2pTest"
echo "Creating SP for RBAC with name $servicePrincipalName, with role $roleName and in scopes /subscriptions/$subscriptionID/resourceGroups/$resourceGroup"

spinfo=$(az ad sp create-for-rbac --name $servicePrincipalName --role $roleName --scopes /subscriptions/$subscriptionID/resourceGroups/$resourceGroup )
echo $spinfo

sleep 60
az login --service-principal --username $(echo $spinfo | jq -r .appId ) --password $(echo $spinfo | jq -r .password) --tenant $(echo $spinfo | jq -r .tenant)

