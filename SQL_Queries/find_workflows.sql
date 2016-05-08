select dirname, leafname
from alldocs
with (nolock)
where dirname like '%servermanagement%'and leafname like '%.xoml'


select * from Webs
where FullUrl like '%servermanagement%'