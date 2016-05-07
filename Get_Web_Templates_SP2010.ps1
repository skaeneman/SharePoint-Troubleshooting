#Description: This script will find the web template name and ID for all webs in a web applications

###################### UPDATE WITH YOUR WEB APP HERE ###########################
$myWebApp = "http://YourWebApp.domain.com"
###################### DO NOT UPDATE ANYTHIGN BELOW THIS LINE ##################

$webApp = Get-SPWebApplication -Identity $myWebApp
#$webTemplate = Get-SPWebTemplate

foreach($site in $webApp.Sites)
{
    foreach($web in $site.AllWebs)
    {
        Write-Host "Web Url:" $web.Url"," "Web Template:" $web.WebTemplate"," "Web Template ID:" $web.WebTemplateId | Format-List
        
    }#$web
    $web.Dispose()

} #$site
