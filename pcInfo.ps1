<#
.SYNOPSIS
    Displays basic system information about the computer.

.DESCRIPTION
    This script retrieves and displays essential computer information including:
    - Computer name
    - Manufacturer
    - System family/model
    - System type (32-bit/64-bit)
    - Operating system name and version

.OUTPUTS
    CsName          - Computer name
    CsManufacturer  - System manufacturer (e.g., Dell, HP, Lenovo)
    CsSystemFamily  - System family (e.g., Latitude, ThinkPad)
    CsModel         - Specific model number
    CsSystemType    - Architecture type (x64/x86)
    OsName          - Windows edition
    OsVersion       - Windows version number
#>

# Get computer info
Get-ComputerInfo CsName, CsManufacturer, CsSystemFamily, CsModel, CsSystemType, OsName, OsVersion