# $InstalledSoftware = Get-WmiObject -Class Win32_Product |
# Select-Object -Property Name, Version, Description, InstallDate, Vendor |
# Sort-Object DisplayName, DisplayVersion, InstallDate

# Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | 
# Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
  # Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name

<#
.SYNOPSIS
    Lists all installed software on the system.

.DESCRIPTION
    This script retrieves installed software information from Windows registry locations
    and displays or exports the results. It can filter by architecture (32/64-bit) and
    output either to console or CSV file.

.PARAMETER Architecture
    Specifies which software architecture to list:
    - "All" (default): Both 32-bit and 64-bit software
    - "32": Only 32-bit software
    - "64": Only 64-bit software

.PARAMETER OutputFormat
    Specifies the output format:
    - "Console" (default): Displays formatted table in console
    - "CSV": Exports to 'software_list.csv' in current directory

.EXAMPLE
    .\swList.ps1
    Lists all installed software in console

.EXAMPLE
    .\swList.ps1 -Architecture 32 -OutputFormat CSV
    Exports only 32-bit software to CSV

.OUTPUTS
    Displays or exports software list with the following properties:
    - DisplayName: Application name
    - DisplayVersion: Software version
    - Publisher: Software publisher/vendor
    - InstallDate: Installation date
    - InstallLocation: Installation directory path
#>

param(
    [ValidateSet("All", "32", "64")]
    [string]$Architecture = "All",
    
    [ValidateSet("Console", "CSV")]
    [string]$OutputFormat = "Console"
)

$software = @()

# Get 32-bit software if requested
if ($Architecture -in "All", "32") {
    $software += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
        Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, InstallLocation
}

# Get 64-bit software if requested
if ($Architecture -in "All", "64") {
    $software += Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
        Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, InstallLocation
}

# Filter and sort the results
$software = $software | 
    Where-Object DisplayName -ne $null |
    Sort-Object -Property DisplayName, DisplayVersion

# Output based on selected format
if ($OutputFormat -eq "CSV") {
    $software | Export-Csv -Path "software_list.csv" -NoTypeInformation
    Write-Host "Results exported to software_list.csv"
} else {
    $software | Format-Table -AutoSize
}

# $InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall" |
# Sort-Object @{Expression = "DisplayName"; Descending = $false }

# $Properties = @('DisplayName', 'DisplayVersion', 'InstallDate')
# $Properties = @('Name', 'Version', 'Description', 'InstallDate')
# $headers = $Values -join ","
# write-host $headers
# foreach ($obj in $InstalledSoftware) {
#   # foreach ($prop in $Properties) {
#     PSCustomObject $item = $obj.GetType()
#     write-host $obj
#     write-host $item
#   #   write-host $obj.GetValue($prop) -NoNewline
#   #   if ($prop -ne $Properties[-1]) {
#   #     write-host "," -NoNewline;
#   #   }
#   # }
#   # write-host
# }
# # TODO export to CSV
# # $newarr | Export-Csv output.csv -NoTypeInformation