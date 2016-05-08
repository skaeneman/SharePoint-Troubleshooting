
--shows what site has the event receiver
use WSS_Content_SecurePortal_DB3
select EventReceivers.Assembly, webs.fullurl from EventReceivers with (nolock)
inner join Webs on EventReceivers.WebId = webs.Id
where ASSEMBLY='Microsoft.Office.Project.Server.PWA,Version=12.0.0.0,Culture=neutral,PublicKeyToken=71e9bce111e9429c'

--shows what lists have the event receiver
use WSS_Content_SecurePortal_DB3
select EventReceivers.Assembly, AllLists.tp_Title
from EventReceivers with (nolock)
inner join AllLists on EventReceivers.WebId = AllLists.tp_WebId
where ASSEMBLY='Microsoft.Office.Project.Server.PWA,Version=12.0.0.0,Culture=neutral,PublicKeyToken=71e9bce111e9429c'
