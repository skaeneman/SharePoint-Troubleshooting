
# This PowerShell script will remove any user that has the custom Security Token Service (STS)
# claims of “i:0ǻ.t|sts.XXXXXXXX.com|win.UserName" or “i:0ǻ.t|sts.XXXXXXXX.com|pass.UserName" from a site collection.

# ** IMPORTANT: RUN THE SCRIPT LIKE THIS TO GET A LOG REPORT **
#  .\remove_STS_users.ps1 > D:\STS_Users_2_Delete.txt

add-pssnapin microsoft.sharepoint.powershell -EA 0

##########################################################################

#Enter the site collection URL
$siteCol = "http://webApp.domain.com"

#Enter the string to search on that the user names have that should be removed
#This will remove both the .win and .pass accounts for STS accounts
$filter = "i:0ǻ.t|sts.XXXXXXXXXXX.com|"

#Enter path to create log file (don't give it a file name, just do "d:\")
$csvPath = "D:\"
#####################DO NOT EDIT ANYTHING BELOW THIS LINE #################

$site = New-Object Microsoft.SharePoint.SPSite($siteCol)
$web = $site.OpenWeb()
$usersToDelete = @()

#loops through webs and adds any user containing the $filter object into the array for deletion
foreach ($user in $web.SiteUsers)
{
    if ($user.LoginName.ToLower().Contains($filter))
    {
        $usersToDelete += $user.LoginName
    }
}

#removes users from site collection that are in the array
foreach ($user in $usersToDelete)
{
    "Removing user: " + $user
     $web.SiteUsers.Remove($user)
}

$web.Update();