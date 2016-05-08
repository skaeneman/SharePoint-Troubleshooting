select tp_Title as 'Title', webs.FullUrl, 
tp_WebId as 'Web', tp_FeatureId as 'FeatureId',
tp_itemcount as 'Item Count', 
tp_ServerTemplate as 'Template',tp_Description as 'Description'
from AllLists with (nolock)
inner join Webs on AllLists.tp_WebId = webs.Id
where tp_FeatureId like '75A0FEA7-%'
order by tp_WebId desc