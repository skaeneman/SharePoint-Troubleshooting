++++++++++++++++++++++++++++++++
find users in a site collection
++++++++++++++++++++++++++++++++


use WSS_Content
SELECT dbo.Webs.SiteId, dbo.Webs.Id, dbo.Webs.FullUrl, dbo.Webs.Title, dbo.UserInfo.tp_ID,
dbo.UserInfo.tp_DomainGroup, dbo.UserInfo.tp_SiteAdmin, dbo.UserInfo.tp_Title, dbo.UserInfo.tp_Email
FROM dbo.UserInfo INNER JOIN 
dbo.Webs  with (nolock)ON dbo.UserInfo.tp_SiteID = dbo.webs.SiteId
WHERE FullUrl like 'sites/SomeSite%'
