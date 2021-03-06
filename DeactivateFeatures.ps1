 ###############################################################################################
# This PowerShell script will read from an XML file and DEACTIVATE site collection and site features.
###############################################################################################

###############################################################################################
# loads PowerShell Snapin Microsoft.SharePoint.PowerShell
###############################################################################################

Write-Host -ForegroundColor Yellow "Enabling SharePoint PowerShell cmdlets..."
If ((Get-PsSnapin |?{$_.Name -eq "Microsoft.SharePoint.PowerShell"})-eq $null)
{
	Add-PsSnapin Microsoft.SharePoint.PowerShell | Out-Null
}
Start-SPAssignment -Global | Out-Null

###############################################################################################
# Creates function
###############################################################################################

Function DeactivateFeatures{

###############################################################################################
# Prompts for XML location and reads user input
###############################################################################################

$xmlFileLocation = Read-Host "Enter full path of XML file (ex. C:\ConfigFile.XML)"
if(!(Test-Path -Path $xmlFileLocation))
  {
   Write-Host -ForegroundColor Red $xmlFileLocation "does not exist! Stopping Script";break
  }
  else {Write-Host -ForegroundColor Yellow "Loading XML file from:" $xmlFileLocation}
	   
#loads xml file object
[xml]$configFile = (Get-Content $xmlFileLocation)

###############################################################################################
# Dectivates the Features listed in the XML file for sites and webs,  Below are Feature DisplayNames
#
# PublishingSite = SharePoint Server Publishing Infrastructure
# BaseSite = SharePoint Server Standard Site Collection features 
# PremiumSite = SharePoint Server Enterprise Site Collection features
# Reporting = Reporting
# OpenInClient  =  Open Documents in Client Applications by Default 
# DocumentSet = Document Sets
# DocId = Document ID Service
#
# PublishingWeb = SharePoint Server Publishing
# BaseWeb = SharePoint Server Standard Site features
# PremiumWeb = SharePoint Server Enterprise Site features
# TeamCollab = Team Collaboration Lists
###############################################################################################

# gets web application info from the XML file
$webApplication = @($configFile.Features.WebApplication)| where {$_.WebApp -ne $null}

# gets list of site collection features to deactivate from the XML file
$siteColFeatures = @($configFile.Features.SiteFeatures)| where {$_.Reporting -ne $null}

# loads Site Collection features from the XML file into an array
$siteColFeaturesArray = @($siteColFeatures.SharePointServerPublishingInfrastructure; 
					     $siteColFeatures.SharePointServerStandardSiteCollectionfeatures;
					     $siteColFeatures.SharePointServerEnterpriseSiteCollectionfeatures;
					     $siteColFeatures.Reporting;
					     $siteColFeatures.OpenDocumentsinClientApplicationsbyDefault;
					     $siteColFeatures.DocumentSets;
					     $siteColFeatures.DocumentIDService)
			  
# gets list of site features to deactivate from the XML file
$siteFeatures = @($configFile.Features.WebFeatures)| where {$_.SharePointServerPublishing -ne $null}			  

# loads Site features from the XML file into an array
$siteFeaturesArray = @($siteFeatures.SharePointServerPublishing;
					   $siteFeatures.SharePointServerStandardSitefeatures;
					   $siteFeatures.SharePointServerEnterpriseSitefeatures;
					   $siteFeatures.TeamCollaborationLists)

# gets web application object
$webApp = Get-SPWebApplication $webApplication.WebApp | where {$_.Name -ne $null}

# iterates through web application and finds site collections
foreach ($site in $webApp.sites)
{		
	Write-Host ""
	# iterates through features in the array
	foreach($feature in $siteColFeaturesArray)
	{
	 #checks to see if the feature is already enabled on each site collection
	 $isSiteFeatureEnabled = Get-SPFeature -Limit ALL -Site $site | Where-Object {$_.DisplayName -eq $feature}
	
	 # deactivates any feature in the array that is not already enabled
	 if ($isSiteFeatureEnabled -ne $null)
       {
         Write-Host -ForegroundColor Cyan "Deactivating Site Collection feature" $feature "on: " $site.Url
         Disable-SPFeature $feature -Url $site.Url -confirm:$false
         $site.Dispose()
       }
       else
          {
            Write-Host -ForegroundColor "green" "Site Collection feature" $feature "is already deactivated on:" $site.Url
            $site.Dispose()
          }  	 
		  
	}#ends $feature foreach

###############################################################	
#  Deactivates Site level features
###############################################################

	foreach($web in $site.AllWebs)
	{		
	Write-Host ""
	# iterates through features in the array
	foreach($webFeature in $siteFeaturesArray)
	{		
	 # checks to see if the feature is already enabled on each site (web)
	 $isWebFeatureEnabled = Get-SPFeature -Limit ALL -web $web | Where-Object {$_.DisplayName -eq $webFeature}
	
	 # activates any feature in the array that is not already enabled
	 if ($isWebFeatureEnabled -ne $null)
       {
         Write-Host -ForegroundColor Cyan "Deactivating Site feature" $webFeature "on: " $web.Url
         Disable-SPFeature $webFeature -Url $web.Url -confirm:$false
         $web.Dispose()
       }
       else
          {
            Write-Host -ForegroundColor "green" "Site feature" $webFeature "is already deactivated on:" $web.Url
            $web.Dispose()
          }  	 
		  
	}#ends $webFeature foreach	
  }#ends $web foreach
		
}#ends $site foreach
	

}#ends function
Stop-SPAssignment -Global | Out-Null

#calls function
DeactivateFeatures 
