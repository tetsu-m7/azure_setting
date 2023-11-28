# Delete az app

az ad app list -o table
# az ad app delete --id 90ea35c8-bc13-4731-ab7b-c21cb6139537

# Delete az role assignment
ids=$(az role assignment list --all --query "[?contains(roleDefinitionName,'s2pcreation')].{id:id}" -o tsv)
#az role assignment list --all --query "[?contains(roleDefinitionName,'s2pcreation')]" -o yamlc

for i in $ids
do
  echo "az role assignment delete --ids $i"
  az role assignment delete --ids "$i"
done

az role definition delete --name "s2pcreation"
