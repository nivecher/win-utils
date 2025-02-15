<#
.SYNOPSIS
    Displays disk space usage statistics for all active drives.

.DESCRIPTION
    This script retrieves and displays storage information for all mounted file system drives,
    showing their capacity and usage in gigabytes (GB) and percentage of free space.
    Only drives with used space greater than 0 are included.

.OUTPUTS
    Drive   - Drive letter or mount point
    SizeGB  - Total drive capacity in GB
    UsedGB  - Used space in GB
    FreeGB  - Available space in GB
    PctFree - Percentage of free space available
#>

Get-PSDrive -PSProvider FileSystem | 
    Where-Object { $_.Used -gt 0 } |
    Select-Object -Property @{
        Name = "Drive"; 
        Expression = { $_.Root }
    },
    @{
        Name = "SizeGB";
        Expression = { ($_.Used + $_.Free) / 1GB -as [int] }
    },
    @{
        Name = "UsedGB";
        Expression = { ($_.Used / 1GB) -as [int] }
    },
    @{
        Name = "FreeGB";
        Expression = { ($_.Free / 1GB) -as [int] }
    },
    @{
        Name = "PctFree";
        Expression = { [math]::Round(($_.Free / ($_.Used + $_.Free)) * 100, 2) }
    }