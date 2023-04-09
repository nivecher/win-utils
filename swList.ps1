# $InstalledSoftware = Get-WmiObject -Class Win32_Product |
# Select-Object -Property Name, Version, Description, InstallDate, Vendor |
# Sort-Object DisplayName, DisplayVersion, InstallDate

# Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | 
# Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
  # Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name

Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, InstallLocation |
Sort-Object -Property DisplayName, DisplayVersion | Export-Csv -Path output32.csv

Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, InstallLocation |
Sort-Object -Property DisplayName, DisplayVersion | Export-Csv -Path output64.csv

Get-Content .\output32.csv, .\output64.csv | Set-Content .\output.csv

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