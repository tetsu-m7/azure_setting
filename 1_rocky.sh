#az vm image list-publishers --location westus --output table
#az vm image list-offers --location westus --publisher erockyenterprisesoftwarefoundationinc1653071250513 --output table
#az vm image list --location westus --publisher erockyenterprisesoftwarefoundationinc1653071250513 --offer rockylinux  --all --output table

az vm create \
  --resource-group test \
  --name rocky8 \
  --image erockyenterprisesoftwarefoundationinc1653071250513:rockylinux:free:8.7.20230215 \
  --vnet-name vNet1 \
  --subnet default \
  --size Standard_B1ls \
  --admin-username azureuser \
  --ssh-key-name azurekey \
  --nic-delete-option Delete \
  --os-disk-delete-option Delete \
  --custom-data cloud-init.txt
