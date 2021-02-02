--查看哪些用户连接
SELECT s.Osuser Os_User_Name,Decode(Sign(48 - Command),1,To_Char(Command),
'Action Code #' || To_Char(Command)) Action,
p.Program Oracle_Process, Status Session_Status, s.Terminal Terminal,
s.Program Program, s.Username User_Name,
s.Fixed_Table_Sequence Activity_Meter, '' Query, 0 Memory,
0 Max_Memory, 0 Cpu_Usage, s.Sid, s.Serial# Serial_Num
FROM V$session s, V$process p
WHERE s.Paddr = p.Addr
AND s.TYPE = 'USER'
ORDER BY s.Username, s.Osuser;


--根据v.sid查看对应连接的资源占用等情况
SELECT n.NAME, v.VALUE, n.CLASS, n.Statistic# FROM V$statname n, V$sesstat v
WHERE v.Sid = &sid
AND v.Statistic# = n.Statistic#
ORDER BY n.CLASS, n.Statistic#；
select *  from  V$process;
select type from V$session;

--查询耗资源的进程（top session）
SELECT s.Schemaname Schema_Name,Decode(Sign(48 - Command),
1, To_Char(Command), 'Action Code #' || To_Char(Command)) Action,Status Session_Status, s.Osuser Os_User_Name, s.Sid, p.Spid,s.Serial# Serial_Num, Nvl(s.Username, '[Oracle process]') User_Name,
s.Terminal Terminal, s.Program Program, St.VALUE Criteria_Value
FROM V$sesstat St, V$session s, V$process p
WHERE St.Sid = s.Sid
AND St.Statistic# = To_Number('38')
AND ('ALL' = 'ALL' OR s.Status = 'ALL')
AND p.Addr = s.Paddr
and s.Schemaname = 'HMISLJ'
ORDER BY St.VALUE DESC, p.Spid ASC, s.Username ASC, s.Osuser ASC;
