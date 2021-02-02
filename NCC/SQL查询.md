#### SQL查询

```java
1.
import nc.itf.uap.IUAPQueryBS;

IUAPQueryBS uapService = ServiceLocator.find(IUAPQueryBS.class);


String sql = " select code from org_orgs where pk_org = ? and pk_group = ? ";
			SQLParameter para = new SQLParameter();
			para.addParam(pk_org);
			para.addParam(pk_group);
			String orgCode = (String)uapService.executeQuery(sql,
					para, new ColumnProcessor());

此类只适用于后端代码,不适用于client端
```

```java
2.
 BaseDAO baseDao = new BaseDAO();
 String sql =  " (dr is null or dr = 0) and  pk_financeorg <>'~' and    pk_customer ='"+bill.getParentVO().getCcustomerid()+"'";
List<Customer> list = baseDao.retrieveByClause(CustomerVO.class,sql);

returnVOs=list.toArray(new CustomerVO [list.size()]);
String   pk_financeorg  = returnVOs[0].getPk_financeorg();


String   pk_financeorg  = list.get(0).getPk_financeorg();


```

```java
3.
SqlBuilder sqlBuilder = new SqlBuilder();
				sqlBuilder1.append("Select c2.pk_financeorg from bd_customer c1,  bd_customer c2 where ");
				sqlBuilder1.append(" c1.pk_customer_main=c2.pk_customer ");
/**sqlBuilder1.append("pk_material", "1001ZZ100000006JSN97");
==>pk_material=1001ZZ100000006JSN97;*/
				sqlBuilder1.append(" and ");
				sqlBuilder1.append(" 					     c1.pk_customer='"+bill.getParentVO().getCcustomerid()+"'");
 				List<CustomerVO> pk_financeorgList = (List)basedao.executeQuery(sqlBuilder1.toString(), new ColumnListProcessor());
```





##### dao查询：

```java
public PsndocAggVO getPsndocAggVOS(String id) throws BusinessException {
		PsndocAggVO aggvo = new PsndocAggVO();
		String psndocsql = " select * from bd_psndoc where id ='"+id+"' ";
		List<PsndocVO>  psndoclist = (List<PsndocVO>) new BaseDAO().executeQuery(psndocsql, new BeanListProcessor(PsndocVO.class));
		if(psndoclist!=null && psndoclist.size()>0){
			
			PsndocVO psndocvo = psndoclist.get(0);
			aggvo.setParentVO(psndocvo);
			
			String pk_psndoc = psndocvo.getPk_psndoc();
			StringBuffer sb  = new StringBuffer();
			sb.append(" select hi_psnjob.* ");
			sb.append("  from hi_psnjob ");
			sb.append("  left join hi_psnorg on hi_psnorg.pk_psndoc = hi_psnjob.pk_psndoc  and hi_psnorg.pk_psnorg = hi_psnjob.pk_psnorg ");
			sb.append(" where hi_psnjob.begindate = ");
			sb.append("   (select max(begindate)  ");
			sb.append("  from hi_psnjob ");
			sb.append("    where pk_psndoc = '"+pk_psndoc+"' ");
			sb.append("  and ismainjob = 'Y'  ) ");
			sb.append("  and hi_psnjob.pk_psndoc = '"+pk_psndoc+"' ");
			sb.append("   and hi_psnjob.lastflag = 'Y' ");
			sb.append("   and hi_psnorg.lastflag = 'Y' ");
			sb.append("   and hi_psnjob.ismainjob = 'Y' ");
			Logger.error("查询对应工作信息 + " + sb.toString());
			List<PsnJobVO>  psnjoblist = (List<PsnJobVO>) getBaseDAO().executeQuery(sb.toString(), new BeanListProcessor(PsnJobVO.class));

```

```java
	public PsnJobVO getPsndocJobVO4Part(String pk_psndoc, String pk_group, String pk_org, String pk_dept) throws DAOException {
		String sql = "select * from hi_psnjob where pk_psndoc = ? and pk_group = ? and pk_org = ? and pk_dept = ? and ismainjob = 'N' and endflag = 'N'";
		SQLParameter param = new SQLParameter();
		param.addParam(pk_psndoc);
		param.addParam(pk_group);
		param.addParam(pk_org);
		param.addParam(pk_dept);
		List<PsnJobVO> jobvos = (List<PsnJobVO>)getBaseDAO().executeQuery(sql, param, new BeanListProcessor(PsnJobVO.class));
		return jobvos != null && jobvos.size() > 0 ? jobvos.get(0): null;
	}
```

```java
//返回一条数据
HrRelationDeptVO hrRDVO = getHrRDVO(deptSaveVO,resultPK);
 			BaseDAO dao = new BaseDAO();
 			String sql = "select   pk_relation_dept   from hr_relation_dept where pk_dept='"+deptSaveVO.getDeptvo().getPk_dept()+"' ";
 			String pk_relation_dept = (String)dao.executeQuery(sql, new ColumnProcessor());
 			hrRDVO.setPk_relation_dept(pk_relation_dept);
 			dao.updateVO(hrRDVO);
```

