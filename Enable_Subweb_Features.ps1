<#
    This PowerShell script will enable the "Team Collaboration Lists" 
    feature on all SharePoint 2010 subsites under a particular site collection.
#>

# tracks all objects used
Start-SPAssignment -Global

Add-PSSnapin Microsoft.SharePoint.PowerShell -erroraction SilentlyContinue

############# EDIT THE BELOW VARIABLES FOR YOUR ENVIRONMENT ################

# Use this to find other feature names:   get-spfeature | select displayname
$feature = "TeamCollab"
$web = "http://exxxxxxxxxxxxxxr"

##################### DO NOT EDIT ANYTHING BELOW THIS LINE #################

$spWeb = Get-SpWeb -Limit All -site $web

            foreach ($subSite in $spWeb)
            {
                    #gets sub sites
                    $isFeatureEnabled = get-spfeature -Limit All -Web $subSite.Url | Where-Object {$_.DisplayName -eq $feature}
                    
                    if ($isFeatureEnabled -eq $null)
                    {
                       Write-Host -ForegroundColor "yellow" "activating feature" $feature "on: " $subSite.Url
                       Enable-SPFeature $feature -Url $subSite.Url -confirm:$false
                       $subSite.Dispose()
                    }
                
                    else
                    {
                        Write-Host -ForegroundColor "green" "feature" $feature "is already enabled on:" $subSite.Url
                        $subSite.Dispose()
                    }                 
            }
   
 # disposes of objects            
 Stop-SPAssignment -Global
 