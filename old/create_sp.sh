az ad sp create-for-rbac --name testinstance-sp --role Reader --scopes /subscriptions/88c4acb3-a375-48f0-8729-fc73e5b518f4/resourceGroups/test
az login --service-principal --username <sp_id> --password <sp_secret> --tenant <tenant_id>
