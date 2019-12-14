<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/11/19
  Time: 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
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
		<label class="layui-form-label">账号</label>
		<div class="layui-input-inline">
			<span>${sessionScope.user.("USERNAME")}</span>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">用户名</label>
		<div class="layui-input-inline"><span></span>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">积分</label>
		<div class="layui-input-inline"><span></span>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">注册时间</label>
		<div class="layui-input-inline"><span></span>
		</div>
	</div>

	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="LAY-user-front-submit" id="LAY-user-front-submit" value="确认">
	</div>
</div>

<script>
	layui.config({
		base: '../layuiadmin/' //静态资源所在路径
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
