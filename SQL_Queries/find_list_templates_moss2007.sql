select tp_webid, tp_Title as Title,  tp_ServerTemplate as TemplateId,
tp_BaseType, tp_description as Desccription 
from AllLists with (nolock)
where tp_ServerTemplate = '430'
order by TemplateId, Title ASC

select * from AllLists