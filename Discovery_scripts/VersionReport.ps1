Add-PSSnapin Microsoft.SHarePoint.Powershell -erroraction SilentlyContinue
 
#Write the CSV Header - Tab Separated 
"Site Collection Name `t Site Name`t Library `t File Name `t File URL `t File Type `t Last Modified `t No. of Versions `t Latest Version Size(MB) `t Versions Size(MB) `t Total File Size(MB)" | out-file c:\VersionSizeReport.csv 
  
#Arry to Skip System Lists and Libraries 
$SystemLists =@("Pages", "Converted Forms", "Master Page Gallery", "Customized Reports", "Form Templates", "List Template Gallery", "Theme Gallery", "Reporting Templates", "Site Collection Images", "Solution Gallery", "Style Library", "Web Part Gallery", "wfpub") 
   
#Get Last Year's Same day! 
$DateFilter=([DateTime]::Now.AddYears(-1)) 
 
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
                #Get only Document Libraries & Exclude Hidden System libraries 
                if ( ($List.BaseType -eq "DocumentLibrary") -and ($List.Hidden -eq $false) -and($SystemLists -notcontains $List.Title) ) 
                { 
                    foreach ($ListItem  in $List.Items) 
                    { 
          #Consider items with 5+ versions And apply Date Filter 
                        if ($ListItem.Versions.Count -gt 50) 
                        { 
          $versionSize=0 
  
                            #Get the versioning details 
                            foreach ($FileVersion in $ListItem.File.Versions) 
                            { 
                                $versionSize = $versionSize + $FileVersion.Size; 
                            } 
       #To Calculate Total Size(MB) 
       $ToalFileSize= [Math]::Round(((($ListItem.File.Length + $versionSize)/1024)/1024),2) 
         
                            #Convert Size to MB 
                            $VersionSize= [Math]::Round((($versionSize/1024)/1024),2) 
         
       #Get the Size of the current version 
       $CurrentVersionSize= [Math]::Round((($ListItem.File.Length/1024)/1024),2) 
  
                            #Log the data to a CSV file where versioning size > 0MB! 
                            if ($versionSize -gt 0) 
                            { 
                                "$($Site.RootWeb.Title) `t $($Web.Title) `t $($List.Title) `t $($ListItem.Name) `t $($Web.Url)/$($ListItem.Url) `t $($ListItem['File Type'].ToString()) `t $($ListItem['Modified'].ToString())`t $($ListItem.Versions.Count) `t $CurrentVersionSize `t $($versionSize) `t $($ToalFileSize)" | Out-File c:\VersionSizeReport.csv -Append
                            } 
                        } 
                    } 
                } 
}
}
            } 
  $Web.Dispose()           
        } 
 $Site.Dispose()           
    } 
   
    #Send message to console 
    write-host "Versioning Report Generated Successfully!"

