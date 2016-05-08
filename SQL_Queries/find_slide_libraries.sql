use Restore_4_DCHC_Test
select AllLists.tp_WebId as 'Web', AllLists.tp_FeatureId as 'FeatureId',
AllLists.tp_Title as 'Title', Webs.FullUrl,
AllLists.tp_ItemCount as 'Item Count', AllLists.tp_ServerTemplate as 'Template', AllLists.tp_Description as 'Description', Webs.Id
from AllLists with (nolock)
inner join Webs on AllLists.tp_WebId = webs.Id
where AllLists.tp_ServerTemplate = '2100'
order by tp_WebId desc

