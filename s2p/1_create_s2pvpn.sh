#!/bin/bash
# Ref: https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-point-to-site-rm-ps

RG="TestRG1"
VNetName="VNet1"
FESubName="FrontEnd"
GWSubName="GatewaySubnet"
VNetPrefix="10.1.0.0/16"
FESubPrefix="10.1.0.0/24"
GWSubPrefix="10.1.255.0/27"
VPNClientAddressPool="172.16.201.0/24"
Location="EastUS"
GWName="VNet1GW"
GWIPName="VNet1GWpip"
GWIPconfName="gwipconf"
DNS="10.2.1.4"
Base64Rootcer="certbaes64.txt"
az group create --name $RG --location $Location
az network vnet create --name $VNetName --resource-group $RG --location $Location --address-prefixes $VNetPrefix --dns-servers $DNS
az network vnet subnet create --name $FESubName --resource-group $RG --vnet-name $VNetName --address-prefixes $FESubPrefix
az network vnet subnet create --name $GWSubName --resource-group $RG --vnet-name $VNetName --address-prefixes $GWSubPrefix
az network vnet show --resource-group $RG -n $VNetName -o table
az network vnet subnet list --resource-group $RG --vnet-name $VNetName -o table
pip=$(az network public-ip create --name $GWIPName --resource-group $RG --location $Location --allocation-method Dynamic)
az network vnet-gateway create -g $RG -n $GWName --public-ip-address $GWIPName --vnet $VNetName --gateway-type Vpn --sku VpnGw1 --vpn-type RouteBased
az network vnet-gateway show -g $RG -n $GWName -o table

az network vnet-gateway update --resource-group $RG --name $GWName --address-prefix $VPNClientAddressPool --root-cert-data $Base64Rootcer --root-cert-name Root.cer

sasurl=$(az network vnet-gateway vpn-client show-url --resource-group TestRG1 -n Vnet1GW)
wget $sasurl -o vpnclientconfig.zip
unzip vpnclientconfig.zip -d vpnclient.zip
