az role definition list --custom-role-only true --output json --query '[].{roleName:roleName, roleType:roleType}'

az role definition create --role-definition s2pcreation.json

#  az role assignment list --all -o table
# az role assignment delete --assignee --role "s2pcreation"
# az role definition delete --name "s2pcreation"
