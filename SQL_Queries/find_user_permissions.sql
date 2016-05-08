use WSS_DoDIISTeams_Content_DB_Extended

SELECT  dbo.Webs.FullUrl, dbo.Webs.Title, dbo.Roles.RoleId, dbo.Roles.Title AS 'Permissions', 
dbo.UserInfo.tp_Title AS 'User', dbo.userinfo.tp_login AS 'UserId', 
dbo.UserInfo.tp_Email AS 'Email', dbo.Perms.ScopeUrl
FROM dbo.RoleAssignment INNER JOIN 
dbo.Roles  with (nolock)ON dbo.RoleAssignment.SiteId = dbo.Roles.SiteId AND
dbo.RoleAssignment.RoleId = dbo.Roles.RoleId INNER JOIN
dbo.Webs ON dbo.Roles.SiteId = dbo.webs.SiteId AND dbo.roles.WebId = dbo.webs.Id INNER JOIN
dbo.UserInfo ON dbo.RoleAssignment.PrincipalId = dbo.UserInfo.tp_ID INNER JOIN
dbo.Perms ON dbo.RoleAssignment.ScopeId = dbo.Perms.ScopeId

WHERE FullUrl like 'sites/SomeSite%'


--select FullUrl from Webs with (nolock)
--WHERE FullUrl like 'sites/SomeSite%'