--finds site with content type
select * from Webs
where ID like '%CE7717FE-850F-4BEF-889C-B910862D6F70%'


select * from Lists
where tp_Id like '%373B9F5A-2626-4587-BC4A-5CAF67562250%'

select siteid, sys.fn_varbintohexstr(ContentTypeId)
as Id, WebId, ListId, IsFieldId, Class 
from ContentTypeUsage
where (sys.fn_varbintohexstr(ContentTypeId)
like '0x010100C568DB52D9D0A14D9B2FDCC96666E9F2007948130EC3DB064584E219954237AF3900811B4A76698BEE47A78B1BE1D0C0EA95%')
order by ListId desc

select * from ContentTypeUsage
where (sys.fn_varbintohexstr(ContentTypeId)
like '0x010100C568DB52D9D0A14D9B2FDCC96666E9F2007948130EC3DB064584E219954237AF3900811B4A76698BEE47A78B1BE1D0C0EA95%')
