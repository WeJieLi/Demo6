<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/12/8
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>Title</title>
	<link rel="stylesheet" href="../layuiadmin/layui/css/layui.css" media="all">
	<link rel="stylesheet" href="../layuiadmin/style/admin.css" media="all">
	<link rel="stylesheet" href="../layuiadmin/style/login.css" media="all">
	<script src="../layui/layui.js" charset="utf-8"></script>
	<script src="../js/jquery-3.4.1.js"></script>

</head>
<body>

<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
	<div class="layadmin-user-login-box layadmin-user-login-header">
		<h2>文档中心</h2>
	</div>
	<div style="text-align: center" >
		<div class="layui-inline" style="width:1000px;text-align: right">
			<a href="userlogin.jsp">登录</a>&nbsp&nbsp&nbsp&nbsp
			<a href="userlogin.jsp">注册</a>
		</div>
		<div class="layui-inline" style="width:1000px;">
			<hr>
		</div>
	</div>
	<div class="layui-card-body">
		<div style="text-align: center;">

			<div class="layui-inline">
				<input type="text" style="width: 900px" name="title" id="title" lay-verify="title" autocomplete="off"
				       placeholder="请输入标题" class="layui-input">
			</div>
			<div class="layui-inline">
				<button class="layui-btn layuiadmin-btn-admin" lay-submit lay-filter="LAY-user-back-search">
					<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
				</button>
			</div>
		</div>
	</div>
	<div style="text-align: center">
		<div class="layui-inline" style="width:1000px">
			<table id="demo" lay-filter="demo"></table>
		</div>
	</div>
	<div class="layui-trans layadmin-user-login-footer">

		<p>© 2019 <a href="http://www.layui.com/" target="_blank">cykj.com</a></p>
		<p>
			<span><a href="" target="_blank">获取授权</a></span>
			<span><a href="" target="_blank">在线演示</a></span>
			<span><a href="" target="_blank">前往官网</a></span>
		</p>
	</div>

</div>

<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-warm" lay-event="down">下载</a>
</script>
<script>
	layui.use('table', function () {
		var table = layui.table;

		//第一个实例
		table.render({
			elem: '#demo'
			, url: '/Demo6/FileSearch.action' //数据接口
			,where: {check:'ok'} //如果无需传递额外参数，可不加该参数
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10, 20, 30, 40]
			, id: 'testReload'
			, cols: [[ //表头
				{type: 'numbers', title: '序号', align: 'center'}
				, {field: 'FILE_TITLE', title: '文档标题', align: 'center'}
				, {field: 'FILE_UPLOAD_USER', title: '上传人', align: 'center'}
				, {field: 'FILE_UPLOAD_DATE', title: '上传时间', align: 'center'}
				, {field: 'FILE_DOWN_SCORE', title: '下载积分', align: 'center'}
				, {field: 'FILE_TYPE', title: '文档类型', align: 'center'}
				, {field: 'FILE_DOWN_TIMES', title: '下载次数', align: 'center'}
				, {fixed: 'right', title: '操作', toolbar: '#barDemo', align: 'center'}
			]]
		});

		//监听行工具事件查看、删除、新增
		table.on('tool(demo)', function (obj) {//注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data;//获得当前行数据
			console.log(data['FILE_TITLE']);
			if (obj.event === 'down') {
				layer.msg("请先登录！");

			}
		});

	});


	layui.config({
		base: '../layuiadmin/' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'user'], function () {
		var $ = layui.$
			, form = layui.form
			, table = layui.table;


		//监听搜索
		form.on('submit(LAY-user-back-search)', function (data) {
			var field = data.field;
			//执行重载
			table.reload('testReload', {
				page: {
					curr: 1 //重新从第 1 页开始
				}
				, where: {
					title: $('#title').val()
				}
			});
		});


	});
</script>
</body>
</html>
