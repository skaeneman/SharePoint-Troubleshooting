select FullUrl, TimeCreated, 
DATEADD(d,DAYLASTACCESSED + 65536, CONVERT (Datetime, '1/1/1899', 101)) as 'last Accessed'
from Webs
where (DayLastAccessed <> 0) 
--enter date as yyyy-mm-dd format
AND (DATEADD(d,DAYLASTACCESSED + 65536, CONVERT (Datetime, '1/1/1899', 101))) <= '2012-01-01 00:00:00'
order by DayLastAccessed desc


--gets the current_timestamp and subtract 180 days to go 6 months back
--Declare @oldSiteDate timestamp
--select @oldSiteDate = (DATEADD(day, datediff(DAY,0,current_timestamp),-180))
--print @oldSiteDate

--gets the current_timestamp and subtract 180 days to go 6 months back
--select (DATEADD(day, datediff(DAY,0,current_timestamp),-180))