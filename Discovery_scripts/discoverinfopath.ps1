Add-PSSnapin Microsoft.SHarePoint.Powershell -erroraction SilentlyContinue
 
#create a CSV file  
"List URL, List Name, Item Count, Last modified, List Type, List Base Template, Form Template URL " > c:\Infopath.csv #Write the Headers in to a text file 
##########################################################################################################
# The following secion iterates through an entire farm. Two closing loops at the end finish out the        #
# For-Each login here                                                                                      #
############################################################################################################
$Farm = Get-SPWebApplication
Foreach ($WebApplicationname in $Farm)
    {
    $WebApplication = Get-SPWebApplication -identity $WebApplicationname
    $WebAppSites = $WebApplication.Sites
    Foreach ($SiteCollectionUrl in $webappsites) 
        {
############################################################################################################
# End farm interative initiation                                                                           #
############################################################################################################
                
        $site = Get-SPSite -identity $SiteCollectionUrl
        If ($site.ReadLocked -eq $false)
        {
        foreach($web in $site.allWebs) 
            { 
            write-host "Scaning Site" $web.title "@" $web.URL 
            $lists = $web.lists 
            ForEach($list in $lists)
            {
   if( $list.BaseType -eq "DocumentLibrary"  -and $list.BaseTemplate -eq "XMLForm")
   {
   #Write data to CSV File 
   $Web.Url + "/" + $List.RootFolder.Url + "," + $list.title + "," + $list.ItemCount + "," + $list.LastItemModifiedDate.ToShortDateString() + "," + $list.BaseType + "," + $list.BaseTemplate + "," + $list.ServerRelativeDocumentTemplateUrl >> c:\Infopath.csv
             
   }
  }
  
     } 
}
 
$web.Dispose()
  }
$site.Dispose()
  }
Write-host  "Report Generated at c:\Infopath.csv" -foregroundcolor green  
