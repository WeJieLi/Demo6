<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/11/17
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String jsPath=application.getContextPath()+"/js/";
	String layui=application.getContextPath()+"/layui/";
%>
<html>
<head>
	<title>Title</title>
	<link rel="stylesheet" href=<%=layui+"css/layui.css"%>>
	<script src=<%=jsPath+"jquery-3.4.1.js"%>></script>
	<script src=<%=layui+"layui.js"%>></script>
</head>
<body>
<div class="layui-form">
	<table id="demo" lay-filter="test"></table>
</div>
</body>
<script type="text/html" id="toolbarDemo">
	<div class="layui-btn-container">
		<button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
		<button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
		<button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
	</div>
</script>
<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>

	layui.use('table', function(){
		var table = layui.table;
		//第一个实例
		table.render({
			elem: '#demo'
			,height: 312
			,url: '/Demo/UserServlet?methodName=UserSearch' //数据接口
			,page: true //开启分页
			//,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
			,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
			title: '提示'
			,layEvent: 'LAYTABLE_TIPS'
			,icon: 'layui-icon-tips'
		}]
			,cols: [[ //表头
				{field: 'RN', title: '序号', width:80, sort: true, fixed: 'left'}
				,{field: 'USERNAME', title: '用户名', width:80}
				,{field: 'STATE', title: '状态', width:80, sort: true}
				,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
			]]
		});
		//监听行工具事件
		table.on('tool(test)', function(obj){
			var data = obj.data;
			console.log(data);
			if(obj.event === 'del'){
				layer.confirm('真的删除行么', function(index){
					obj.del();
					layer.close(index);
				});
			} else if(obj.event === 'edit'){
				layer.prompt({
					formType: 2
					,value: data.email
				}, function(value, index){
					obj.update({
						email: value
					});
					layer.close(index);
				});
			}
		});
	});
</script>
</html>
