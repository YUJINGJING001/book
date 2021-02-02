--��ѯ��ռ�ʹ�ô�С���
SELECT 
  a.tablespace_name ��ռ�����, 
  total ��ռ��СM,
  total - free ��ʹ��M, 
  free ����M, 
  round((total - free) / total * 100, 2) ʹ��ռ��,
  max_size ����M
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
--��Դʹ�����
select resource_name ��Դ����,MAX_UTILIZATION ���ϴ����������ķ�ֵ,INITIAL_ALLOCATION ��ʼֵ,LIMIT_VALUE ���ֵ from v$resource_limit;



--��ǰ�α�ʹ�����
select machine,count(*) num_curs 
from v$open_cursor o, v$session s
where user_name = 'HMISLJ' and o.sid=s.sid
group by  machine
order by  num_curs desc;

--�鿴ORACLE����α���
show parameters open_cursors;
--�鿴��ǰ�򿪵��α���Ŀ
select count(*) from v$open_cursors;


--���ݿⱸ�����
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



