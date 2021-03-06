
# This PowerShell script will remove the custom upload page (uploadex.aspx) from SPWeb, and reverts back to the default upload page (upload.aspx), 
# which does not contain the “Destination Folder” field. 


Add-PSSnapin Microsoft.Sharepoint.PowerShell -ErrorAction SilentlyContinue

################## UPDATE WITH YOUR WEB APPLICATION ######################################

$myWebApp = "https://portal.test.local"

################## DO NOT UPDATE ANYTHING BELOW THIS LINE ################################


$webApp = Get-SPWebApplication -Identity $myWebApp

foreach ($site in $webApp.Sites)
{
    foreach ($web in $site.Allwebs)
    {
        
        if ($web.CustomUploadPage -ne "")
        {

            Out-File C:\Users\a-kaenems\Documents\output\WebsWithDestinationFolder_Log.txt -Append -InputObject $web.Url
            
            $web.CustomUploadPage = ""
            $web.Update()
        }
    }
    $web.Dispose()
}
$site.Dispose()