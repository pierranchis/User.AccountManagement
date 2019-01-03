<#
############################################################################################################
# Created by Pierranchis                         #    Description: Queries defined Searchbase and returns  #
# Get Locked AD Accounts                         #                 locked accounts                         #
# Created: 01/03/2019                            #                                                         #
############################################################################################################
#>

# Import Powershell AD Module
Import-Module activedirectory

# Variables
 $SearchBase=
  "OU Path location 01",
  "OU Path location 02",
  "OU Path location 03"

# Search defined OU's for locked accounts. Ask which to unlock. Unlock mentioned accounts. 
Do 
 {
    $SearchBase | foreach { Search-ADAccount -LockedOut -SearchBase $_} | Select-Object -Property SamAccountName,Name,LastLogonDate,LockedOut | Format-Table -AutoSize
    $UserInput = Read-Host -Prompt "Is there an account needing to be unlocked? (y/n)"
    if ($UserInput -like "y") 
        { 
         Read-Host “Enter the Terminal or account to unlock” | Unlock-ADAccount -ErrorAction:SilentlyContinue -WarningAction:SilentlyContinue
        }

    else {}
 }
Until ($UserInput -like "n")
