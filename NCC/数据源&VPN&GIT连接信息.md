```json
//"./src/zmprj/expense/*/*/index.js"
```



# 1.数据源&VPN&GIT连接信息


## （1）NC56数据源连接信息

```
UAP HOME:home的路径   比如我的：E:\NC65\home
数据源列表：design
数据库类型：ORACLE11G
主机/IP:10.152.0.41
DB/ODBC名称：ncdb
用户名:NCTEST1016
密码：nctest1016
驱动类型：JDBC
OID标志：ZZ
```

## （2）NC65数据源连接信息

```
UAP HOME:home的路径   比如我的：E:\NC65\home
数据源列表：design
数据库类型：ORACLE11G
    主机/IP:111.205.210.36
DB/ODBC名称：ncdb
用户名:bcsycs_20181201
密码：1
驱动类型：JDBC
端口：21521
OID标志：Z
```

##（3）NCC数据源连接信息

```
UAP HOME:home的路径   比如我的：E:\NC65\home
数据源列表：design
数据库类型：ORACLE11G
主机/IP:10.153.252.120/172.20.17.238
DB/ODBC名称：ncdb/orcl
用户名：ncdev/zm_ncdev1
密码：ncdev/zm_ncdev1
驱动类型：JDBC
端口：1521
OID标志：Z

```

## （4）中免vpn地址(用IE浏览器浏览)

```
中免vpn地址为：https://sinfors.cdfg.com.cn
账号为：自己的汉字名称
密码：abcd1234#
```

## （5）用友APN地址

```url
用友vpn地址：https://vpn.yonyou.com
登录用友vpn后输入框内容：https://vpn.yonyou.com/prx/000/http/localhost/welcome/index.html
```



##（6）8001数据库地址

```
 
数据源列表：design
数据库类型：ORACLE11G
主机/IP:172.20.17.238
DB/ODBC名称：orcl
用户名:zm_ncc20190313
密码：zm_ncc20190313
驱动类型：JDBC
端口：1521
OID标志：Z
```

## （7）8001页面测试地址

```http
http://172.20.17.238:8001/nccloud/resources/workbench/public/common/main/index.html#/
```

## （8）1903最新测试库（数据库）和页面访问地址

```
数据源列表：design
数据库类型：ORACLE11G
主机/IP:10.16.1.198
DB/ODBC名称：orcl
用户名: ncc1903_0404
密码：1
驱动类型：JDBC
端口：1521
OID标志：Z


页面访问地址：http://10.16.1.198:8099    
集团用户名/密码：jtadmin/qwer1234
用户与中免模拟正式环境一致
用户预置密码：1234qwer


系统管理员：2
密码：123qwe

```

## （9）1903最新开发库

```
数据源列表：design
数据库类型：ORACLE11G
主机/IP:10.16.1.198
DB/ODBC名称：orcl
用户名: zm_dev
密码：1
驱动类型：JDBC
端口：1521
OID标志：Z
```

## (10)抽取脚本sql

```sql
--抽脚本sql
--应用注册
select * from sm_appregister where source_app_code ='400413402'
--应用注册卡片/列表
select * from sm_apppage where parent_id=(select pk_appregister from sm_appregister where source_app_code ='400413402')
--应用注册-按钮注册
select * from sm_appbutnregister where appid=(select pk_appregister from sm_appregister where source_app_code ='400413402')
--应用注册-页面模板注册
select * from pub_page_templet where appcode='400413402'   --appcode功能注册编码
--页面基本信息
select * from pub_area where templetid in (select pk_page_templet from pub_page_templet where appcode='400413402')
--列表查询信息
select * from pub_query_property where areaid in (select pk_area from pub_area where templetid in (select pk_page_templet from pub_page_templet where appcode='400413402'))
--单据模板
select * from pub_form_property where areaid in (select pk_area from pub_area where templetid in (select pk_page_templet from pub_page_templet where appcode='400413402'))
--菜单注册
select * from sm_appmenuitem where appid =(select pk_appregister from sm_appregister where source_app_code ='400413402')
--打印模板
```

## （11）前端语法参考文档地址

```http
http://git.yonyou.com/nc-pub/Public_Document/blob/master/%E5%89%8D%E7%AB%AF/%E5%89%8D%E7%AB%AF%E6%A1%86%E6%9E%B6/%E9%AB%98%E9%98%B6%E7%BB%84%E4%BB%B6/%E8%A1%A8%E5%8D%95%E7%BB%84%E4%BB%B6%E7%89%B9%E6%80%A7.md
```

## （12）前端react技术和es6技术资料地址

```http
react技术:    http://huziketang.mangojuice.top/books/react/
es6技术：     http://es6.ruanyifeng.com/#README
```

## (13)1903开发环境基准库(8088)

```
http://10.16.1.198:8088/

对应的数据库地址：
数据库信息：ncc1903_0404_kf/1@10.16.1.198:1521/orcl
系统管理员：2/123qwe
集团管理员：jtadmin/qwer1234
```

## （14）8888测试环境

```http
ip://10.153.252.120:8888  用户名/密码：ncc0428/ncc428
1.数据库信息：
sid:orcl 用户名/密码：ncc0428/ncc428      sys密码：oracle
ip://10.153.252.120:8888
2.应用信息：
安装路径：/data/NCcloud1903_Gold   
远程服务器信息：
ip://10.153.252.120:8888
超级系统管理员：root 密码：123456a!
超级系统管理员：admin/123qwe
3.NCC系统信息：
http://10.153.252.120:8888
admin/1234qwer
```

## (15)7777数据库信息

```http
1.数据库信息：sid:orcl 用户名/密码：ncc7777/ncc7777     sys密码：oracle
         2.应用信息：端口：7777      地址：10.153.252.120   安装路径：/data/NCcloud1903_Gold7777   root/admin密码：123456a!
 

```

## （16）9999数据库及开发环境

```http
测试环境二、
1.数据库信息：sid:orcl 用户名/密码：ncc9999/ncc9999      sys密码：oracle
             2.应用信息：端口：9999     地址：10.153.252.120   安装路径：/data/NCcloud1903_Gold9999   超级系统管理员:root/admin密码：123456a!
        
 系统管理员：admin/1234qwer
```

## (17)远程虚拟机连接信息

```
虚拟机名称: kekaifwq 
虚拟主机IP地址: 10.16.1.198 
是否为核心业务系统: 否 
业务使用范围: 临时及测试业务系统 
管理员名称: administrator 
管理员密码: 6VZ9N!Bj>g 
```

## (18)8666数据库连接信息

```http
http://10.153.252.121:8666/
root账套管理员
root/123456a！
admin系统管理员：admin/1234qwer

数据库信息：10.153.252.120  sid:orcl ncc6666 ncc6666 
```

## （19）9999正式开发环境

```
中免最终正式环境
端口9999 访问地址:http://10.153.252.125:9999
数据库信息：IP 10.153.251.134 SID：nccloud 用户名/密码 cdfncc/Cdfncc0524
只允许做元数据升级及数据库查漏补缺操作。
```

## （20）8888正式测试环境连接信息

```http
目前最新测试环境地址http://10.153.252.123:8888/（后续固定）
对应数据库地址：（10.153.252.120 sid:orcl ncc20190628 ncc20190628）（后续固定）

```



# 2.用友VPN连接和git仓库连接信息

```
用友vpn连接网址:https://vpn.yonyou.com/prx/000/http/localhost/welcome/index.html
账号：yujj2（本人设置）
密码：和你用友邮箱密码相同（本人设置）

--------------------------------------------------------------------------------------------------
git仓库设置网址：git.yonyou.com
用户名：yujj2（同vpn）
密码：同用友vpn密码（本人设置）

特别注意：连接用友git仓库需要先连接用友vpn（登录vpn连接地址即可）
```

