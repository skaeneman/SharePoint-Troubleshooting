Add-PSSnapin Microsoft.SHarePoint.Powershell -erroraction SilentlyContinue
 
#create a CSV file 
"List URL, List Name, Item Count, Last modified, List Type, List Base Template, Versioning Enabled, Major Versions Limit, Minor Versions Enabled, Minor Versions limit, Force Checkout Enabled " > c:\ListDetails.csv #Write the Headers in to a text file 
############################################################################################################
# The following secion iterates through an entire farm. Two closing loops at the end finish out the        #
# For-Each login here                                                                                      #
############################################################################################################
$Farm = Get-SPWebApplication
Foreach ($WebApplicationname in $Farm)
    {
    $WebApplication = Get-SPWebApplication -identity $WebApplicationname
    $WebAppSites = $WebApplication.Sites
    Foreach ($SiteCollectionUrl in $webappsites) 
        {
############################################################################################################
# End farm interative initiation                                                                           #
############################################################################################################
                
        $site = Get-SPSite -identity $SiteCollectionUrl
        If ($site.ReadLocked -eq $false)
        {
        foreach($web in $site.allWebs) 
        { 
            write-host "Scaning Site" $web.title "@" $web.URL 
               foreach($list in $web.lists) 
               { 
                   
       #Write data to CSV File 
                   $Web.Url + "/" + $List.RootFolder.Url + "," + $list.title + "," + $list.ItemCount + "," + $list.LastItemModifiedDate.ToShortDateString() + "," + $list.BaseType + "," + $list.BaseTemplate + "," + $list.Enableversioning + "," + $list.Majorversionlimit + "," + $list.Enableminorversions + "," + $list.majorwithminorversionslimit + "," + $list.forcecheckout >> c:\ListDetails.csv
             
               } 
        } 
    } 
    $site.Dispose() 
  }
 
  }
#Dispose of the site object 
 
Write-host  "Report Generated at c:\Listdetails.csv" -foregroundcolor green  
