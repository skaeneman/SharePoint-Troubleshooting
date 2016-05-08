Select 
	s.session_id,
	s.login_name,
	s.host_name,
	c.auth_scheme
from
sys.dm_exec_connections c
inner join
sys.dm_exec_sessions s
on c.session_id = s.session_id
