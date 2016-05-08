select AllLists.tp_WebId as 'Web', AllLists.tp_FeatureId as 'FeatureId',
AllLists.tp_Title as 'Title', AllLists.tp_ItemCount as 'Item Count', 
AllLists.tp_ServerTemplate as 'Template', AllLists.tp_Description as 'Description',
Webs.FullUrl, Webs.Id
from AllLists with (nolock)
inner join Webs on AllLists.tp_WebId = webs.Id
where AllLists.tp_FeatureId = '448e1394-5e76-44b4-9e1c-169b7a389a1b'
or AllLists.tp_FeatureId = '525dc00c-0745-47c0-8073-221c2ec22f0f'
or AllLists.tp_FeatureId = 'd8d8df90-7b1f-49c1-b170-6f46a94f8c3c'
or AllLists.tp_FeatureId = '60d1e34f-0eb3-4e56-9049-85daabfec68c'
or AllLists.tp_FeatureId = '90014905-433f-4a06-8a61-fd153a27a2b5'
order by tp_WebId desc