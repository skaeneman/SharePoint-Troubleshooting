
--USE TO FIND WEBPARTS ON A SPECIFIC SITE
SELECT DISTINCT 
CAST(D.DIRNAME AS varchar) + '/' + CAST(D.LEAFNAME AS varchar) as 'Page URL',
tp_id as webpart,
WP.tp_WebPartTypeId,
WP.tp_DisplayName as 'webpart name',
tp_ZoneID as 'zone'
FROM dbo.Docs D with (nolock)
INNER JOIN dbo.Webs W WITH(NOLOCK) ON D.WebId = W.Id
INNER JOIN dbo.WebParts WP WITH(NOLOCK) ON D.Id = WP.tp_PageUrlID
where FullUrl = 'sites/test'


--USE TO LOCATE THE WEB PARTS ACROSS THE ENTIRE DB
SELECT DISTINCT 
CAST(D.DIRNAME AS varchar) + '/' + CAST(D.LEAFNAME AS varchar) as 'Page URL',
tp_id as webpart,
WP.tp_WebPartTypeId,
WP.tp_DisplayName as 'webpart name',
tp_ZoneID as 'zone'
FROM dbo.Docs D with (nolock)
INNER JOIN dbo.Webs W WITH(NOLOCK) ON D.WebId = W.Id
INNER JOIN dbo.WebParts WP WITH(NOLOCK) ON D.Id = WP.tp_PageUrlID
--where FullUrl = 'sites/test'
where WP.tp_WebPartTypeId = '35DDEF02-016A-70FE-68E1-4FF557C14C38' 