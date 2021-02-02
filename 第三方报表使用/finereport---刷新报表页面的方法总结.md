# finereport---刷新报表页面的方法总结



## 1. 描述

在报表应用中，我们经常会用到报表页面的刷新，比如分页、分析、填报预览中有数据更新时需要定时刷新，填报报表中填报成功后需要刷新，决策报表中某个报表块需要定时的刷新等等，都会用到刷新。下面对这些刷新方法进行总结。

 

## 2. 各种刷新方法总结



### 2.1 手动刷新

含义：手动点击浏览器刷新按钮

适用范围：所有报表应用中

缺点：重新加载速度可能较慢，参数栏参数会初始化，需要重新填写，用户体验较差。



### 2.2 location.reload() 

含义：刷新整个报表页面，和手动点击浏览器的刷新功能是一样的

适用范围：所有报表应用中

缺点：跟手动刷新一样，重新加载速度可能较慢，参数栏参数会初始化，需要重新填写，用户体验较差。

示例：[填报成功自动刷新](http://help.finereport.com/doc-view-620.html)



### 2.3 window.open(location.href,"_self") 

含义：在当前窗口打开当前页面地址，还是和重新加载一样

适用范围：所有报表应用中

缺点：跟上面一样，重新加载速度可能较慢，参数栏参数会初始化，需要重新填写，用户体验较差。

示例：[填报成功/失败转向](http://help.finereport.com/doc-view-617.html)



### 2.4 contentPane.parameterCommit()

含义：重新提交参数栏参数，报表块刷新，参数栏不会刷新

适用范围：具有参数栏的所有报表中(包括使用了参数栏隐藏）

缺点：报表必须设置参数栏。

示例：[自动查询](http://help.finereport.com/doc-view-409.html)



### 2.5 contentPane.gotoPage(1)

含义：跳转到报表第 1 页，不管报表此时是处于第 1 页，都会再加载一次,参数栏不会刷新

适用范围：分页报表，填报报表

缺点：无（没有参数栏也可使用）

示例：[自定义翻页按钮](http://help.finereport.com/doc-view-928.html)

注：此方法可以使用三个参数 gotoPage(pn, para, noCache),跳转到指定页，重新提交参数，有无缓存，使用较灵活



### 2.6 this.options.form.getWidgetByName("report0").gotoPage(1)

含义：获取决策报表中名为 report0 的报表块，跳转到第 1 页，跟上面意义相同

适用范围：决策报表

缺点：无

示例：[JS 实现决策报表内报表块局部刷新/翻页](http://help.finereport.com/doc-view-1304.html)

注：此方法可以使用三个参数 gotoPage(pn, para, noCache),跳转到指定页，重新提交参数，有无缓存，使用较灵活



### 2.7 contentPane.refreshAllSheets()

含义：刷新填报或分析报表中所有的sheet,不会刷新参数栏

适用范围：填报报表，分析报表

缺点：如果有多个 sheet 填报，会刷新所有的 sheet，可能导致数据丢失

示例：[填报成功自动刷新](http://help.finereport.com/doc-view-620.html)



### 2.8 contentPane.reloadCurLGPPane()

含义：刷新填报或分析报表中当前 sheet,不会刷新参数栏，也不会影响其他 sheet 数据

适用范围：填报报表，分析报表

缺点：无

示例：[多sheet应用](http://help.finereport.com/doc-view-547.html)



### 2.9 contentPane.loadContentPane()

含义：加载报表内容块，也会刷新页面，如果参数栏有参数，会提交参数栏参数

适用范围：分页报表，填报报表，分析报表

缺点：如果是在填报报表或分析报表中，会刷新所有的 sheet 数据



### 2.10 globalForm.loadContentPane()

含义：加载报表内容块，也会刷新页面

适用范围：决策报表

缺点：无