param(
    [string]$networkSSID
)

# Get the list of wireless network interfaces
$interfaces = netsh wlan show interfaces

# Check if the specified network is currently connected
# Select-String is now used to find the SSID in the output without using context
$ssidLine = $interfaces | Select-String -Pattern "^\s*SSID\s*:\s*$networkSSID$"

# Split the interface information by new lines and find the State line
$stateLine = ($interfaces -split "`r`n") | Where-Object { $_ -match "^\s*State\s*:\s*connected" }

if ($ssidLine -and $stateLine) {
    Write-Host "Already connected to $networkSSID."
} else {
    Write-Host "Not connected to $networkSSID. Attempting to connect..."

    # Check if the specified SSID is available
    $availableNetworks = netsh wlan show networks | Select-String -Pattern $networkSSID

    if ($availableNetworks) {
        # If the network is available, attempt to connect
        netsh wlan connect name=$networkSSID
        Write-Host "Attempted to connect to $networkSSID."
    } else {
        Write-Host "$networkSSID is not available."
    }
}
