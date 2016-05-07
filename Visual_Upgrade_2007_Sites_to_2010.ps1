#This script will do a visual upgrade on all sites in a web application. 
#Use this script to upgrade the user interface to v4 for SP2010.  Update with your web application name.

$webApp = Get-SPWebApplication "web app here"
foreach ($site in $webApp.sites)
{
    $site.VisualUpgradeWebs()
}