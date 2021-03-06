<#
    Description:  This script will locate disabled user accounts and remove them 
    from the Active Directory security group "ProjectServerUsers"
#>

Import-Module ActiveDirectory
$timeStamp = get-date -Format mm-dd-yyyy__hh_mm_ss
$filePath = 'D:\EPM2010_Disabled_User_Report\EPM2010_Disabled_User_Report_'+$timeStamp+'.txt'
 
# writes to logfile 
Get-ADGroupMember "ProjectServerUsers" |  where {$_.ObjectClass -eq "user"} | Get-ADUser | where-object  {$_.Enabled -eq $false} | Out-File -FilePath $filePath -Append 


# gets security group, filters on users and excludes other groups in the container, gets users where the "Enabled" property is false.
# loops through disabled users and removes them.
Get-ADGroupMember "ProjectServerUsers" |  where {$_.ObjectClass -eq "user"} | Get-ADUser | where-object  {$_.Enabled -eq $false} | ForEach-Object {$member = $_.SamAccountName; remove-adgroupmember -Identity "ProjectServerUsers" -Member $member -Confirm:$false}
