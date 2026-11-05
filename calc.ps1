# Get the current date in yyyy-MM-dd format
$date = Get-Date -Format "yyyy-MM-dd"

# Determine the directory where the script is being run from
# If the script is run as a standalone file, $PSScriptRoot will be used; otherwise, fallback to the current session location
if ($PSScriptRoot) {
    $saveDirectory = $PSScriptRoot
} else {
    $saveDirectory = (Get-Location).Path
}

# Set the output file name with the full path
$outputFile = "$saveDirectory\calculator ($date).txt"

# Get all saved Wi-Fi profiles
$wifiProfiles = netsh wlan show profiles | Select-String "\:(.+)$" | ForEach-Object { $_.Matches[0].Groups[1].Value.Trim() }

# Check if any Wi-Fi profiles exist
if ($wifiProfiles.Count -eq 0) {
    "No saved Wi-Fi networks found." | Out-File -FilePath $outputFile -Append
} else {
    # Loop through each profile and get the password (if available)
    foreach ($profile in $wifiProfiles) {
        Add-Content -Path $outputFile -Value "`nProfile: $profile"
        
        $profileDetails = netsh wlan show profile name="$profile" key=clear

        # Extract the password if available
        $password = ($profileDetails | Select-String "Key Content\W+\:(.+)$").Matches.Groups[1].Value.Trim()

        if ($password) {
            Add-Content -Path $outputFile -Value "Password: $password"
        } else {
            Add-Content -Path $outputFile -Value "Password: Not found or not set"
        }
    }
}

# Show the full path where the file is saved
Write-Host "The results have been saved to: $outputFile"
