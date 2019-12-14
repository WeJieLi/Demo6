<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/11/19
  Time: 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String layui=application.getContextPath()+"/layui/";
%>
<html>
<head>
	<title>Title</title>
	<link rel="stylesheet" href=<%=layui+"css/layui.css"%>>
	<script src=<%=layui+"layui.js"%>></script>
</head>
<body>

<div class="layui-form" lay-filter="layuiadmin-form-useradmin" id="layuiadmin-form-useradmin" style="padding: 20px 0 0 0;">
	<div class="layui-form-item">
		<label class="layui-form-label">用户名</label>
		<div class="layui-input-inline">
			<input type="text" name="username" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">密码</label>
		<div class="layui-input-inline">
			<input type="text" name="score" lay-verify="score" placeholder="请输入积分" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">邮箱</label>
		<div class="layui-input-inline">
			<input type="text" name="email" lay-verify="email" placeholder="请输入邮箱" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item" lay-filter="sex">
		<label class="layui-form-label">选择性别</label>
		<div class="layui-input-block">
			<input type="radio" name="sex" value="男" title="男" checked>
			<input type="radio" name="sex" value="女" title="女">
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="LAY-user-front-submit" id="LAY-user-front-submit" value="确认">
	</div>
</div>

<script>
	layui.config({
		base: '../../../layuiadmin/' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'form', 'upload'], function(){
		var $ = layui.$
			,form = layui.form
			,upload = layui.upload ;
		upload.render({
			elem: '#layuiadmin-upload-useradmin'
			,url: '/Demo5/fileupload.action'
			,accept: 'file'
			,acceptMime: 'file/*'
			,done: function(res){
				$(this.item).prev("div").children("input").val(res.data.src)
			}
		});
	})
</script>
</body>
</html>
