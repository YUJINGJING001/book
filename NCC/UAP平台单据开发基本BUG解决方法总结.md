# UAP平台单据开发基本BUG解决方法总结

## 1.问题1

```
在个人的nc系统做增删改查出现的错误信息:
原因：接口未注册
Component: nc.itf.zmprj02.ISsssMaintain,Detail Message: The tx component: nc.itf.zmprj02.ISsssMaintain is not found in jndi  please deploy it!} jndiName: nc.itf.zmprj02.ISsssMaintain meta: null
```

第一种是NC内部用户产生的 ，可用下面的解决办法

第二种就是：不是同一个模块的有些接口之间不允许调用 的也会报上面的错。或者不是同一个模块通过new对象和继承的方式也会报上面的错。对应不同模块允许调的接口可以用下面 的方法解决：

NCLocator.getInstance.lookup(接口.class);进行调用



解决办法：

```xml
1.在NCHome的modules下的项目的INF的.ump配置文件增加如下配置：

<?xml version="1.0" encoding='gb2312'?>
<module name="zmprj02">
  <public>
	<component remote="true" singleton="true"  tx="CMT">
	  <interface>nc.itf.zmprj02.ISsssMaintain</interface>
	  <implementation>nc.impl.zmprj02.SsssMaintainImpl</implementation>
	  <extension class="nc.uap.ws.deploy.OxbWSExtensionProcessor">
			<address>/nc.itf.zmprj02.ISsssMaintain</address>
	</extension>
	</component>
	
  </public
  <private>
  </private>
</module> 
2.重新部署即可
```

## 2.问题2 数据库已经存在名称为xxx的组件。无法发布，请修改当前要修改的组件或者有以下问题

![1](F:\图片存档\1111.png)

```sql
到数据执行以下删除命令：
delete md_component where resmodule = 'xxx';
```



## 3.问题3：NC页面做单据的增删改查的时候 "xxxx"."ccc"标识符无效解决方案

```sql
1.检查数据库是否存在该字段，检查主表接口映射是否有该字段
2.如果没有，删除元数据和库表然后就发布更新元数据
3.重启服务器

如果上述任然不能执行，那就在相应的表中增加缺少的字段，然后发布元数据，生成java代码，生成sql脚本
执行sql语句
//增加字段sql语句
alter table  表名  add (字段  字段类型)  [ default  '输入默认值']  [null/not null]  ;
```

## 4.问题4：ARAP如果打不开 用以下方法解决

```js
 前端代码打包下载地址：http://pan.yonyou.com/s/MXOWtGGhTe0　密码：oefv　过期时间：2019-05-31 
    
    出盘收付前端盘时，src下的common文件夹去掉。
    本地开发环境需要全部的文件，另外需要更改以下配置，用于测试工作流相关功能：
        ssccommon: path.resolve(process.cwd(), './src/sscrp/public/common/'),
        base: path.resolve(process.cwd(), './src/common/less/base'),
        widgetsless: path.resolve(process.cwd(), './src/sscrp/public/common/less/widgets'),
        uapbd: path.resolve(process.cwd(), './src/uapbd'),
```

**图片详情**

![](F:\图片存档\APRP.png)

## 5.eclipse对项目没有编译的问题解决方案

```
1.project--->clean--->选择右边那个   作用:可以清除项目缓存，然后重新编译项目
2.remove 掉JRE System Libreary  然后重新加载
3.更换项目空间 -->切换刚才更换的空间 重新clean编译加载
```

## 6,问题5 部署组件

```
报错信息：
Component: nccloud.pubitf.zmprj.expense.decostbill.IDecostBill4Cloud,Detail Message: The tx component: nccloud.pubitf.zmprj.expense.decostbill.IDecostBill4Cloud is not found in jndi please deploy it!} jndiName: nccloud.pubitf.zmprj.expense.decostbill.IDecostBill4Cloud meta: null
```

**解决方法**

```xml
在ump文件P_Cdf_decostbill60.upm（本人的ump）中配置以下信息
<?xml version="1.0" encoding='gb2312'?>
<module name="zmprj">
  <public>
	<component remote="true" singleton="true"  tx="CMT">
 //配置ICdf_decostbillMaintain的接口以及它的实现类的位置
	  <interface>nc.itf.zmprj.ICdf_decostbillMaintain</interface>
	  <implementation>nc.impl.zmprj.Cdf_decostbillMaintainImpl</implementation>
	</component>
 //配置IDecostBill4Cloud接口的和它的实现类的位置
	<component remote="true" singleton="true"  tx="CMT">
	  <interface>nccloud.pubitf.zmprj.expense.decostbill.IDecostBill4Cloud</interface>
  <implementation>nccloud.pubimpl.zmprj.expense.decostbill.IDecostBill4CloudImpl</implementation>
	</component>
 //"IAppScript4Cloud"接口,"AppScript4CloudImpl"实现类无需修改，公用的
	<component remote="true" singleton="true"  tx="CMT">
	  <interface>nccloud.pub.zmprj.script.IAppScript4Cloud</interface>
	  <implementation>nccloud.pubimpl.zmprj.script.AppScript4CloudImpl</implementation>
	</component>	
  </public> 
</module> 
```

##问题7.cannot read  properties "xxx" of undifind

**原因**

1.在xxxx_card或者xxx_list对应的应用注册配置中设置VO类配置错误

2.前端区域编码对应的NCC页面本地端应用注册页面编码配置错误

**解决方法**

xxx_card

![](F:\图片存档\编码.png)

像xxx_list的同上解决方案

**配置信息一定要前端保持一致**

## 7.问题7:数据可以插入，查询，删除，修改，但是修改没有跳转页面，数据已经插入数据库但是都报“未知的错误”。

**解决方案**

![](F:\图片存档\未知的错误（空指针异常）.png)

## 8.问题8 前端编译报错

**（1）ERROR in ./src/to/to/report/estidetail/index.js**

Module not found: Error: Can't resolve '../../../../scmpub/scmpub/pub/tool/dateFormat' in 'E:\ncpub-multipage-demo-develop1.0-zm\src\to\to\report\estidetail'
 @ ./src/to/to/report/estidetail/index.js 24:18-74
 @ multi ./src/to/to/report/estidetail/index.js

**解决方案**

```
1.根据./src/to/to/report/estidetail/index.js这个路径更改index.js里面的import导入的依赖（不需要可以删除）
2.如果需要则需要从git中添加相应import对应的依赖（推荐）
```

## 9.问题9 xxxcannot read properties "xxx" of undifind 或者 xxx is defind

解决办法

```js
1.检查属性或者方法是否导入
import {xxx} from xxxxx;
2.检查该属性或者方法是否存在
```

## 10.问题10，ClassCastException@xxxxxx

```
1.检查元数据是否和前端模板的属性一致
2.检查VO里面字段的类型是否和元数据的类型一致。
3.低级错误（比如元数据的某个字段的类型是String,最后在VO里面是UFDouble）

以增加字段为例：
原因：增加的字段类型和元数据的类型不一致
解决办法：使增加的字段类型和元数据类型一致

以上原因没有的话，可能是下面的原因：
其他原因：可能是元数据没有升级，没有保证和页面模板配置的字段类型一致。
解决办法：升级元数据
```



## 8.NCCloud前端快速开发按钮步骤。

1.将前端对应模块写好

2.更改/nccloud/src/client/surpport/action后台代码，根据来源编码拷贝到目标编码得到按钮代码

3.检查公共配置commom包下的配置文件是否有按钮相关类的注册信息

4.重启服务器，重启前端

5.点击查询，在应用注册信息里就有第二步匹配的来源编码对应的按钮（比如第二部来源是xxxx_list）

## 11.问题11   NCC页面点击保存按钮后，其他按钮无法正常刷新问题解决方法

**根据个人定义的类修改以下报下的类（“xxx”代表个人定义的包）**

**（1）nccloud.web.zmprj.expense.xxxx.action包**

![](F:\图片存档\刷新1.png)

**(2)nc.impl.pub.ace包**

![](F:\图片存档\刷新3.png)

**（3）nc.impl.zmprj包**

![](F:\图片存档\刷新2.png)

**（4）重启服务器即可**

## 12 问题12  debug调试需要在debugconfigues里面的 UAP对应的xxx_server配置如下信息

```
-Dnc.exclude.modules=${FIELD_EX_MODULES}
-Dnc.runMode=develop
-Dnc.server.location=${FIELD_NC_HOME}
-DEJBConfigDir=${FIELD_NC_HOME}/ejbXMLs
-DExtServiceConfigDir=${FIELD_NC_HOME}/ejbXMLs -Duap.hotwebs=nccloud
-Duap.disable.codescan=false
-Djavax.xml.parsers.DocumentBuilderFactory=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl
-Djavax.xml.parsers.SAXParserFactory=org.apache.xerces.jaxp.SAXParserFactoryImpl
-Xms128M -Xmx512M -XX:NewSize=96M -XX:MaxPermSize=256M
-Dorg.owasp.esapi.resources=${FIELD_NC_HOME}/ierp/bin/esapi
```

```
-Dnc.exclude.modules=${FIELD_EX_MODULES}
-Dnc.runMode=develop
-Dnc.server.location=${FIELD_NC_HOME}
-DEJBConfigDir=${FIELD_NC_HOME}/ejbXMLs
-DExtServiceConfigDir=${FIELD_NC_HOME}/ejbXMLs -Duap.hotwebs=nccloud
-Duap.disable.codescan=false
-Djavax.xml.parsers.DocumentBuilderFactory=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl
-Djavax.xml.parsers.SAXParserFactory=org.apache.xerces.jaxp.SAXParserFactoryImpl
-Xms128M -Xmx512M -XX:NewSize=96M -XX:MaxPermSize=256M
-Dorg.owasp.esapi.resources=${FIELD_NC_HOME}/ierp/bin/esapi
```

# 7.更新脚本步骤（8001）

**条件：轻量端nccloud**

**1.添加或者更改项目组件下  轻量端nccloud/scirpt/item.xml(下面显示的是主表，子表需要搜索)文件   如图所示**

![](F:\图片存档\item.png)

**2.按照图解步骤执行**

![](F:\图片存档\导出预制脚本步骤.png)

**3右键单击Item.xml--->Team--->commit and push 将脚本提到git库，如遇到代码合并冲突，有如下解决方法如下**

```
1.在git中右键单击需要改冲突的项目，选择reset---》弹窗（选择第一个Head ）
2.在git中右键单击需要改冲突的项目,选择showIn--->history-->选择你刚刚提交代码记录的下一条右键单击选择reset(此时你在git staging中会看到刚刚提交的脚本)
3.重新pull,将代码拉下来。
4.将要提交的代码命名后点击commit and push
```

**4.在ncc开发环境抽取sql （详见抽取），将ncc抽取的sql打入8001里面**

## 13.问题13  联查中的单据追溯报错信息："没有查询到有关单据"

解决办法：

```
检查元数据业务映射接口的值的字段是否映射上：（主子表）来源单据类型，来源单据id     是否具备上下游关系
									（三张表的）来源单据类型，来源单据id 成对字段来源单据关系的映射
```

## 14. 问题14   单据保存时报错，报错信息"没有获取到单据号，请检查对应的单据规则"

![](F:\图片存档\1558082037662.png)

**解决方法：**

1.检查单据编码规则是否有配置错误的字段

2.检查单据编码类型是否注册，上游的业务流和审批流是否勾上

**上述模板检查没有问题后还是没有解决，那就执行下面的sql查询对应的单据类型是否存在**：

```sql
-1检查- 
SELECT * FROM pub_bcr_elem WHERE ELEMVALUE = 'ZMA3' --查询对应单据类型的所有信息 
SELECT * FROM pub_bcr_nbcr WHERE code = 'ZMA3'--单据编码
SELECT * FROM pub_bcr_RuleBase WHERE nbcrcode = 'ZMA3'--单据编码规则
-2-
在第一条sql对应的所有信息找到pk_billcodebase字段，然后执行以下sql
其他sql查询出来的sql只需要看他有没有数据，没有就导入即可
-3-
第一条sql
SELECT * FROM pub_bcr_elem WHERE Pk_BillCodeBase = 'pk_billcodebase对应的号'
-4-
导出并在相应的数据库中执行sql语句
```

## 15.问题15  解决分页页码前端不显示问题

```sql
-- 		pub_page_templet -- page 妯℃�挎��灏�琛�

-- 		pub_query_templet  -- 妯℃�胯〃
	
-- 		pub_area -- �哄��琛�
		
-- 		pub_query_property -- �ヨ�㈠�哄���
		
-- 		pub_form_property -- 琛ㄥ���哄��� 

select * from pub_page_templet where appcode = 'H9H1A103';
select * from pub_area where templetid = '1001ZZ100000000LCLR9';
--�存�板��椤�
UPDATE pub_area SET pagination='true' WHERE pk_area = '1001ZZ100000000LCLR9';
commit;
```

## 16.问题16  解决抛正常的异常前台无法正常显示

```java
import nc.vo.pubapp.pattern.exception.ExceptionUtils;√

//1.查看 BusinessException引用的jar包是否nc下的即可，如果不是则应该引用nc下的jar包
```

## 17.问题17   解决元数据没有关联不允许或者轻量端禁止查看，请到重量端查看的报错信息

![](F:\图片存档\1561032481967.png)

 **解决方案**

​				**（1）.检查前端应用注册的元数据是否关联，实际是必须关联上的**

![](F:\图片存档\1561031728412.png)

​				**（2）.通过执行sql真正关联元数据，如果已经关联，无需执行此步骤**

```sql
--找到MD_CLASS表中的ID
select * from MD_CLASS where displayname like '%不可计量%'   -- d0a727b1-7f63-42b9-8639-2b7193d1c184   （MD_CLASS表中的ID)
--找到SM_APPREGISTER表中的PK_APPREGISTER
select * from SM_APPREGISTER WHERE code='H9H1A102'
--根据PK_APPREGISTER 更新SM_APPREGISTER表中的MDID
UPDATE SM_APPREGISTER SET MDID='d0a727b1-7f63-42b9-8639-2b7193d1c184'where PK_APPREGISTER in('1001ZZ100000000LCJKO');
```

​	**（3）.检查单据类型管理中是否勾选了轻量化，如果没有请按照下图操作**

![](F:\图片存档\1561031975698.png)

## 18.问题18  环境JVM出错，导致部分单据保存报错！

![](F:\图片存档\22222.png)

**这个自己解决不了的，管理ncchome的负责人解决**

## 19.问题19  card页面删除表体后，点击保存，表体数据重现。

**原因是：保存的时候前台会把删除态（3）和非删除态的数据传到后台，后台如果没有筛选将非删除态数据剔除掉的话，那么后台将删除后的数据当做新数据保存，这样在浏览态进行一次查询的时候，这已经删除的数据就重现了**

**解决方案：后台对不同的状态的数据进行筛选**

```java
			Costbill_b[] bvos = (Costbill_b[])arrayvos[0].getChildrenVO();
		//新建一个集合，将数组转化为一个集合进行迭代！3是删除态的数据
			List<Costbill_b> asList =new ArrayList<>(Arrays.asList(bvos));
			Iterator<Costbill_b> iterator =asList.iterator();
			while(iterator.hasNext()){
				Costbill_b dvo = iterator.next();
				if(dvo.getStatus() == 3){
				//删掉已经删除的数据
					iterator.remove();
				}
```

## 20.问题20  错误提示：

```

nc.bs.bd.material.marorg.IMarOrgQueryService.queryAssignOrgByMaterials([Ljava/lang/String;[Ljava/lang/String;)Ljava/util/Map;
```

***错误原因：ncchome上的.Class文件和java源文件不一致。***

**解决方法，编译java源文件，将编译后的.Class文件覆盖原来的jar包上.Class文件**

## 21.问题21  报表相关报错 ：点击显示合计，报某个参数取值失败

![1568876257459](F:\图片存档\1568876257459.png)

***失败的原因是***

​	***1.后台context.setAttribute(key,value)中的key没有储存相应smonth这个字段，所以在取的时候没有获取到该键，进而没有获取到值中***

​	***2.前端只在查询报表的js代码中做了字段的扩展，但是没有在显示合计中做字段的扩展。***

**解决方案：**

​	**后端处理**

​	IQueryCondition的实现类BaseQueryCondition（报表的条件处理类）中再实现一个接口IConditionToContext然后重写	他的方法setInfoToContext(IContext context)

```java
//param是Parameter对象，里面储存报表传的条件信息,Parameter对象全都储存在Parameter[]数组里面，Parameter[]数组其实就是储存在BaseQueryCondition的userContext Map集合中值
Parameter[] params = (Parameter[]) entry.getValue()；
//entry中的key存储的是报表FreeReportContextKey对象中常量，而Parammeter数组对应的键是FreeReportContextKey.KEY_REPORT_PARAM_WEB
context.setAttribute(ICommContextKey.PREX_PARAM + param.getCode(), param.getValue());
```

​	**前端处理**

​	前端的除了查询的js中扩展常量expandSearchVal之中需要smonth之外，需要在显示合计相应js中做查询条件的扩展

## 22.问题22  报表相关报错 ：报表默认的xsls打印数据量大的时候无法打印，但是数据量小的时候可以打印

原因：数据量太大，报表限制的拆分数量太多，、

解决方案，调小报表限制的拆分条数，其他同理 如下图所示

![1568878578175](F:\图片存档\1568878578175.png)

## 23.问题23   UAP相关报错：单据模板初始化拖拽表体bodyvos时把表体所有字段当作一个字段（明细）显示

1.检查元数据主表关联的子表的字段是否设置正确（如下图所示）

![1571217558816](F:\图片存档\1571217558816.png)

2.检查元数据其他地方，比如元数据组件关联的源是不是明细，以及接口映射是否齐全等等

3.以上确定元数据没有问题的话，那就删掉主子表的关联线，然后重新关联，重新配置元数据即可

![1571217793391](F:\图片存档\1571217793391.png)

## 24 .前端问题 ：Module not found: Can't resolve 'react-hot-loader' 解决办法 

### **原因：没有安装相应的组件**

**例子：**

````js
Module not found: Can't resolve 'react-hot-loader' in 'd:\react\react-elementui\
node_modules\element-react\dist\npm\es5\libs\animate'
````

**解决方法**

````
解决办法：

进入项目目录，

cd  d:\react\react-elementui

d:

执行

npm install react-hot-loader@next --save
再启动npm start/npm run dev
````

## 25.接口缺少上下文环境可以使用下面的方法进行赋值

```java
 InvocationInfoProxy.getInstance().setGroupId(ToolUtils.PKGROUP);//集团
		    InvocationInfoProxy.getInstance().setUserId(vos[0].getCreator());//人员
```

## 26.DbVisualier软件乱码解决办法

```http
https://jingyan.baidu.com/article/4b52d702b9759cfc5c774bef.html
```

## 27.查找xxx.bmf出现问题，引用的元数据——签约公司(自定义档案)，未发布！

```
原因：未发布元数据的的id和执行相应脚本的id不一致造成的
解决办法：1.去前端页面删除自定义档案
2.执行对应未发布自定义档案元数据的脚本
```

