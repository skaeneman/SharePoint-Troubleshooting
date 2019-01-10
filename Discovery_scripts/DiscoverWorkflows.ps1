Add-PSSnapin Microsoft.SHarePoint.Powershell -erroraction SilentlyContinue
 
#create a CSV file 
"URL,List,Workflow" > "c:\Workflows.csv" #Write the Headers in to a text file 
 
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
        If ($site.readlocked -eq $false)
{
        foreach($web in $site.allWebs) 
            { write-host "Scaning Site" $web.title "@" $web.URL 
            $lists = $web.lists 
            ForEach($list in $lists)
                { 
                $workflows= $list.WorkflowAssociations;
                foreach($wf in $workflows)   
                {
                if($wf.Name -notlike "*Previous Version*")        
                {
                $web.Url + "," + $list.Title +"," + $wf.name >> c:\Workflows.csv  #append the data 
 
                    } 
                    }
                }   
            }
        }
    }
}
Write-host  "Report Generated at c:\workflows.csv" -foregroundcolor green 
