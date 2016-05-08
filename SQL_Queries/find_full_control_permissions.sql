--gets users with full control permissions on a web
select distinct  dbo.webs.fullurl as 'Web Url', dbo.webs.title as 'Web Name', 
dbo.userinfo.tp_title as 'User Name', dbo.userinfo.tp_login as 'User Login', 
dbo.roles.title as 'Permissions', dbo.roles.roleid as 'Role ID', dbo.Webs.id as 'Web ID' 
from dbo.roleassignment with (nolock)
inner join dbo.Roles on dbo.roleAssignment.siteid = dbo.roles.siteid and 
dbo.roleassignment.roleid = dbo.roles.RoleId 
inner join dbo.Webs on dbo.roles.siteid = dbo.webs.siteid and dbo.roles.WebId = dbo.webs.Id 
inner join dbo.UserInfo on dbo.roleassignment.principalid = dbo.userinfo.tp_id
where dbo.roles.title = 'Full Control' and dbo.roles.RoleId = '1073741829' 
and dbo.userinfo.tp_login != 'SHAREPOINT\system' and dbo.userinfo.tp_login != 'SHAREPOINT\administrator'
and dbo.userinfo.tp_login != 'BUILTIN\administrators'
order by dbo.webs.fullurl desc