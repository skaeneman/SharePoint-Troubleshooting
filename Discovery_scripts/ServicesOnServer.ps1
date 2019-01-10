Add-PSSnapin microsoft.sharepoint.powershell -ErrorAction SilentlyContinue
$services = new-object system.collections.sortedlist
$servers = (get-spfarm).servers
foreach ($server in $servers)
{
    foreach($service in $server.serviceinstances)
    {
        if ($service.status = "Online")
        {
            $s = $service.typename
            if ($services.contains($s))
            {
                $serverlist = $services[$s]
                $servername = $server.name
                $services[$s] = "$serverlist - $servername"
            }
            else
            {
                $services[$s] = $server.name
            }
        }
    }
}
$services |out-file -width 500 c:\temp\servicesOnServer.csv
