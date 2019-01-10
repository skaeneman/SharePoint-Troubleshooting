
# Idea from more: http://www.sharepointdiary.com/2013/01/find-and-replace-old-link-urls-in-quick.html#ixzz3SnHjHieN
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 
  
#Create CSV File
"Site,Type,QuicklaunchTitle,QuicklaunchURL" > "c:\Quicklaunch-hardcoded.csv"
   
#Iterate through webs 
$farm=Get-SPWebApplication
Foreach ($webapplicationname in $farm)
{
$webapplication = Get-SPWebApplication -Identity $webapplicationname
$webappsites = $webapplication.sites
foreach ($sitecollectionurl in $webappsites)
{
$site = Get-SPSite -Identity $sitecollectionurl
if ($site.readlocked -eq $false)
{
Foreach ($web in $site.allwebs)
{
write-host "Scanning Site " $web.url
#Get the Quick Launch Bar Nodes 
$QuickLaunchNodes = $Web.Navigation.QuickLaunch  
#For Top Navigation use: $Web.Navigation.TopNavigationBar . TOp Nav may or May not have child nodes 
  
 #Iterate through each Parent nodes of Quick launch 
 foreach ($parentNode in $QuickLaunchNodes) 
 {  
    if($parentNode.Url -like '*http*') #if you want to match Link text, use: $parentNode.Title 
 { 
           
 $web.url +",Parent Quicklaunch,"+ $parentnode.title +","+ $parentnode.url >> c:\Quicklaunch-hardcoded.csv  
    } 
 #Get the Child Nodes 
 $childNodes = $parentNode.Children 
   
 #Iterate through child nodes 
 foreach ($childNode in $childNodes) 
  { 
         if($childNode.Url -like '*http*') 
   { 
          $web.url +",Child Quicklaunch,"+ $childnode.title +","+ $childnode.url >> c:\Quicklaunch-hardcoded.csv  
   } 
     } 
 }  
}

$Web.Dispose() 
}
$site.dispose()
}
}

