--find total size of all sites
select SUM(Size /1024/1024) as 'Size in MB'
from Docs with (nolock)
inner join Webs with (nolock) on Docs.WebId = Webs.Id
inner join Sites on webs.SiteId = Sites.Id
where docs.Type <> 1 and (LeafName NOT LIKE '%.stp')
and (LeafName NOT LIKE '%.aspx')
and (LeafName NOT LIKE '%.xfp')
and (LeafName NOT LIKE '%.dwp')
and (LeafName NOT LIKE '%template%')
and (LeafName NOT LIKE '%.inf')
and (LeafName NOT LIKE '%.css')
and (LeafName <>'_webpartpage.htm')