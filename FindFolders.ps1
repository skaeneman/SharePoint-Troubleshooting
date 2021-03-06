# This PowerShell script will list all folders within a web application

Add-PSSnapin Microsoft.Sharepoint.PowerShell -ErrorAction SilentlyContinue

################## UPDATE WITH YOUR WEB APPLICATION ######################################

$myWebApp = "https://WebApp.domain.com"

################## DO NOT UPDATE ANYTHING BELOW THIS LINE ################################

try{

$webApp = Get-SPWebApplication -Identity $myWebApp

foreach ($site in $webApp.Sites)
{
    foreach ($web in $site.Allwebs)
    {
        $webUrl = $web.Url
        
        foreach ($list in $web.Lists)
        {            
            if(($list.BaseType -eq "DocumentLibrary") -and ($list.Hidden -eq $false) -and ($list.Title -notlike "Style Library"))
                {
                      foreach($folder in $list.Folders)
                      {
                        $folderUrl = $folder.Folder.Url
                        "$webUrl" +"/" + "$folderUrl"
                       
                      }
                }
        }#ends $list
    }#ends $web
    
    $web.Dispose()
}#ends $site

}#ends try
Catch [System.Exception]
{
    $_.Exception.toString()
}

$site.Dispose()
