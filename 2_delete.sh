az vm delete --resource-group test --name rocky8 --force-deletion true
az network public-ip delete --resource-group test --name rocky8PublicIP
az network nsg delete  --resource-group test --name rocky8NSG
