select tp_Login as 'Group Name',
tp_Email as 'Email',
tp_SiteID as 'SharePoint Site GUID'
from UserInfo
with (nolock)
where tp_DomainGroup = '1'
and tp_Login != 'NT AUTHORITY\authenticated users'
and tp_login != 'DODIIS\domain users'
and tp_Login != 'BUILTIN\administrators'
and tp_Login != 'BUILTIN\users'
and tp_Login NOT LIKE '%domain users%'
and tp_Login NOT LIKE '%US\%'
