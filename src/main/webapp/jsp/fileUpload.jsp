<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/12/5
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String layui=application.getContextPath()+"/layui/";

%>
<html>
<head>
	<title>文档上传</title>
	<link rel="stylesheet" href="../layuiadmin/layui/css/layui.css" media="all">
	<link rel="stylesheet" href="../layui/css/layui.css" media="all">
	<script src="../layuiadmin/l{ayui/layui.js"></script>
</head>
<body>

<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<div class="layui-form-item">
		<label class="layui-form-label">文章标题</label>
		<div class="layui-input-inline">
			<input type="text" name="title" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">发布人</label>
		<div class="layui-input-inline">
			<input type="text" name="author" lay-verify="required" placeholder="请输入号码" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">文章内容</label>
		<div class="layui-input-inline">
			<textarea name="content" lay-verify="required" style="width: 400px; height: 150px;" autocomplete="off" class="layui-textarea"></textarea>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">标签</label>
		<div class="layui-input-inline">
			<select name="label" lay-verify="required">
				<option value="">请选择标签</option>
				<option value="美食">美食</option>
				<option value="新闻">新闻</option>
				<option value="八卦">八卦</option>
				<option value="体育">体育</option>
				<option value="音乐">音乐</option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">发布状态</label>
		<div class="layui-input-inline">
			<input type="checkbox" lay-verify="required" lay-filter="status" name="status" lay-skin="switch" lay-text="已发布|待修改">
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
	</div>
</div>

<script>
	layui.config({
		base: '../layuiadmin/' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'form'], function(){
		var $ = layui.$
			,form = layui.form;

		//监听提交
		form.on('submit(layuiadmin-app-form-submit)', function(data){
			var field = data.field; //获取提交的字段
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引

			//提交 Ajax 成功后，关闭当前弹层并重载表格
			//$.ajax({});
			parent.layui.table.reload('LAY-app-content-list'); //重载表格
			parent.layer.close(index); //再执行关闭
		});
	})
</script>
</body>
</html>
