$wifi = "Wi-Fi 2"
$ethernet = "Ethernet"
$ethernetGatewayIP = "192.168.1.1"

# Get all known WiFi networks
$knownNetworks = (netsh wlan show profiles) | ForEach-Object { if($_ -match 'All User Profile\s*:\s*(.*)'){ $Matches[1]} }

# Check if any known network is available
$availableNetworks = (netsh wlan show networks) | ForEach-Object { if($_ -match 'SSID\s*\d*\s*:\s*(.*)'){ $Matches[1]} }
$knownNetworksPresent = $knownNetworks | Where-Object { $availableNetworks -contains $_ }

# If any known network is available, remove the default gateway from the Ethernet adapter
if($knownNetworksPresent){
    Remove-NetRoute -InterfaceAlias $ethernet -DestinationPrefix 0.0.0.0/0 -Confirm:$false
}
# If no known network is available, set the default gateway to the Ethernet adapter
else{
    New-NetRoute -InterfaceAlias $ethernet -DestinationPrefix 0.0.0.0/0 -NextHop $ethernetGatewayIP
}
