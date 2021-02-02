# UAP后端开发API

## 1.校验相关

```java
ShowUpableBillForm editor = (ShowUpableBillForm) this.editor;
// 保存前必填字段校验
editor.getBillCardPanel().dataNotNullValidate();

```

## 2.增删改查相关（数据库交互）

```java
//增删改查（试用client端）
接口 interface = (接口) NCLocator.getInstance().lookup(接口.class.getName());
//查询（试用client端）
(1)IUAPQueryBS query = (IUAPQueryBS) NCLocator.getInstance().lookup(
				IUAPQueryBS.class.getName());
Object executeQuery = query.executeQuery(sql, new ColumnListProcessor());//返回Object

(2)IUAPQueryBS uapService = NCLocator.getInstance().lookup(
				IUAPQueryBS.class);
Map<String, String> pkMap = (Map<String, String>) uapService
				.executeQuery(sb.toString(), new MapProcessorExt("vbatchcode",
						"pk_material"));//返回map   vbatchcode和pk_material是要查询的字段

//private端
BaseDAO baseDao = new BaseDAO();

//产品提供
new VOquery()
```

# 3.Card页面  

事件对象.getBillCardPanel().getBillModel()

## （1）表体相关

**1.获取BillModel对象方法  表体对象.getBillCardPanel().getBillModel()       eg:CardBodyAfterEditEvent 表体对象**

**2.获取BillModel对象方法.下面的 方法**

| 方法                         | 方法说明                                                     | 返回值 |      |
| ---------------------------- | ------------------------------------------------------------ | ------ | ---- |
| getRowCount()                | 获取当前行<br />例如：表体对象.getBillCardPanel().getBillModel().getRowCount() | int    |      |
| addLine(rowCount)            | 根据当前行增行<br />rowCount：当前行   <br />增加行<br />例如：表体对象.getBillCardPanel().getBillModel().addLine(rowCount) | void   |      |
| setValueAt(arg0, arg1, arg2) | arg0:给某行某个字段赋的值<br />arg1:行号<br />arg2:需要赋值的字段<br />例如：<br />String[] split = replaceAll.split(",");<br />表体对象.getBillCardPanel().getBillModel()<br/>					.setValueAt(split[i], i, SaleOrderBVO.VROWNOTE); | void   |      |
|                              |                                                              |        |      |
|                              |                                                              |        |      |
|                              |                                                              |        |      |



# 4.自动排序

```java
SuperVOUtil.sortByAttributeName((SuperVO[]) childrenVO, "code", true);
//参数：code：需要排序的字段 
//true:倒序
//false:升序
```

# 5.工具类相关

```java
//类型转换工具
ValueUtils：通过ObjectValue可以获取到UFdouble,UFdate,UFdatetime等信息

//单据号自动生成规则
1.IBillcodeManage iBillcodeManage = (IBillcodeManage) NCLocator
.getInstance().lookup(IBillcodeManage.class.getName());

String standardCode = null;
standardCode = iBillcodeManage.getBillCode_RequiresNew("单据类型",
"组织", "集团",new  BXHeaderVO()（"单据VO"）);

//获取环境变量
SessionContext.getInstance().getClientInfo()//适用NCC
 AppBsContext.getInstance().get.....//适用nc

 
  // 获取数据源( NC65  )
String oldDataSourceName = InvocationInfoProxy.getInstance()
  .getUserDataSource();
 
// 设置新的数据源( NC65  )
InvocationInfoProxy.getInstance().setUserDataSource("iface");

```

# 6.编辑后事件相关

表体设置一个字段的值后走这一个字段的编辑后事件

eg :// 设置物料编码
					e.getBillCardPanel().getBillModel()
							.setValueAt(value1, i, SaleOrderBVO.CMATERIALVID);
					// 走物料编辑后事件
					afterEvent(e.getBillCardPanel(), value1, i, SaleOrderBVO.CMATERIALVID,
							billform);

```java
	// 走编辑后事件
	public CardBodyAfterEditEvent afterEvent(BillCardPanel cardPanel, Object value, int row,
			String cellFiled, SaleOrderBillForm billform) {
		CardBodyAfterEditEvent e1 = new CardBodyAfterEditEvent(
				cardPanel, cardPanel
						.getCurrentBodyTableCode(), row, cellFiled, value, null);
		e1.setAfterEditEventState(CardBodyAfterEditEvent.NOTBATCHCOPY);
		BodyAfterEditHandler bodyAfterEditHandler = new BodyAfterEditHandler();
		bodyAfterEditHandler.setBillform(billform);
		bodyAfterEditHandler.handleAppEvent(e1);
		return e1;

	}
```

# 7.NC65参照公共方法

```java
//表体参照获取
UIRefPane panel = (UIRefPane) event.getBillCardPanel()				.getBodyItem(PraybillItemVO.PK_MATERIAL).getComponent();
//获取条件sql（过滤物料为例）
			MaterialMultiVersionRefModel refModel = (MaterialMultiVersionRefModel) panel
					.getRefModel();//强转的时候要与panel.getRefModel()获取的类型一致
			String wherePart = refModel.getWherePart();

//过滤具体在的字段（过滤物料为例）
FilterMaterialRefUtils filter = new FilterMaterialRefUtils((UIRefPane) event
					.getBillCardPanel().getBodyItem(PraybillItemVO.PK_MATERIAL).getComponent());

			filter.filterItemRefByOrg(org);
			filter.filterIsSealedShow(UFBoolean.FALSE)
			filter.filterRefByDiscountflag(UFBoolean.FALSE);

//表头参照获取
UIRefPane panel = (UIRefPane) event.getBillCardPanel()				.getHeadItem(PraybillItemVO.PK_MATERIAL).getComponent();
//....后面获取以及处理同表体剩余部分
```

# 8.NCCloud前端分层体系

![1589259118043](F:\图片存档\1589259118043.png)

![1589259317727](F:\图片存档\1589259317727.png)

![1589259365507](F:\图片存档\1589259365507.png)

# 9.NCCloud后端架构-部署架构

![1589259570246](F:\图片存档\1589259570246.png)

![1589259892148](F:\图片存档\1589259892148.png)

# 10.根据元数据发布原理修改元数据自定义项长度

```sql
修改字段长度
--修改任意字段长度;属性表（元数据）
select id from md_class where defaulttablename='bd_material'--根据表明查找对应的元数据
select * from md_property where displayname='自定义项17' and classid='c7dc0ccd-8872-4eee-8882-160e8f49dfad'
--修改任意字段长度;字段信息表
select *from md_column where tableid ='bd_material' and name='def17'
--用户自定义属性表(自定义自定义项对应的字段)
select code,pk_userdefrule from bd_userdefrule where code = 'material'
select inputlength,showname from bd_userdefitem where pk_userdefrule='1009Z010000000000SK9' and showname ='课题原编码名称' --showname自定义项名称
update bd_userdefitem set inputlength = 400 where pk_userdefrule='1009Z010000000000SK9' and showname ='课题原编码名称'
commit

--根据名称查找对应的元数据
select id,name,displayname from md_component where displayname like '%物料多版本%'
select id,displayname from md_class where componentid = '222af805-9555-4ffb-bd16-9b79e3880663'
```

## 11表

| pub_busiclass | 单据动作管理表   |
| ------------- | ---------------- |
| dap_dapsystem | 应用注册注册模块 |
|               |                  |
|               |                  |

# 12，修改用户密码sql

```sql
select user_code,user_name from sm_user where user_code like '%admin%'

update sm_user sm set sm.user_password=  
 'U_U++--V'||LOWER( RAWTOHEX( UTL_RAW.CAST_TO_RAW( sys.dbms_obfuscation_toolkit.md5(input_string =>  sm.cuserid||'123qwe'/**要设置的密码*/) ) ) ) 
where sm.user_code ='admin1';
```

# 13.接口调用方法

```java
//后台调用
IUAPQueryBS query = (IUAPQueryBS) NCLocator.getInstance().lookup(IUAPQueryBS.class.getName());
//NCC前台用
IYearBusPlan4Cloud service = ServiceLocator.find(IYearBusPlan4Cloud.class);
```

