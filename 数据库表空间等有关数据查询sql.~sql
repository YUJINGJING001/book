--查询表空间使用大小情况
SELECT 
  a.tablespace_name 表空间名称, 
  total 表空间大小M,
  total - free 已使用M, 
  free 空闲M, 
  round((total - free) / total * 100, 2) 使用占比,
  max_size 最大块M
FROM (
  SELECT tablespace_name
    , round(SUM(bytes) / 1024 / 1024) AS total
  FROM dba_data_files
  GROUP BY tablespace_name
)a,
 (
    SELECT tablespace_name
      , round(SUM(bytes) / 1024 / 1024) AS free,round(max(bytes)/1024/1024) as max_size
    FROM dba_free_space
    GROUP BY tablespace_name
  ) b
  where a.tablespace_name = b.tablespace_name
ORDER BY (total - free) / total DESC;
--资源使用情况
select resource_name 资源名称,MAX_UTILIZATION 自上次启动以来的峰值,INITIAL_ALLOCATION 初始值,LIMIT_VALUE 最大值 from v$resource_limit;



--当前游标使用情况
select machine,count(*) num_curs 
from v$open_cursor o, v$session s
where user_name = 'HMISLJ' and o.sid=s.sid
group by  machine
order by  num_curs desc;

--查看ORACLE最大游标数
show parameters open_cursors;
--查看当前打开的游标数目
select count(*) from v$open_cursors;


--数据库备份情况
SELECT DECODE(os_backup.backup + rman_backup.backup, 0, 'FALSE', 'TRUE') backup
FROM (SELECT COUNT(*) backup FROM gv$backup WHERE status = 'ACTIVE') os_backup,
(SELECT COUNT(*) backup
FROM gv$session
WHERE status = 'ACTIVE'
AND client_info like '%rman%') rman_backup;





select * from dba_free_space;
select * from dba_data_files;

select * from v$session where username = 'HMISLJ';
select * from v$open_cursor where user_name = 'HMISLJ';

select * from gv$backup
select * from gv$session;

select * from v$resource_limit;



