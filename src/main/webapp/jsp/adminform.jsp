<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/12/7
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>添加管理员</title>
	<link rel="stylesheet" href="../layuiadmin/layui/css/layui.css" media="all">
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-form-admin" id="layuiadmin-form-admin" style="padding: 20px 30px 0 0;">
	<div class="layui-form-item">
		<label class="layui-form-label">登录名</label>
		<div class="layui-input-inline">
			<input type="text" name="admin" lay-verify="required" placeholder="请输入登录名" autocomplete="off" class="layui-input">
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">姓名</label>
		<div class="layui-input-inline">
			<input type="text" name="name" lay-verify="name" placeholder="请输入姓名" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">角色</label>
		<div class="layui-input-inline">
			<select id="rolename" name="rolename" lay-search lay-filter="LAY-user-adminrole-type" class="layui-input">
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">性别</label>
		<div class="layui-input-block">
			<input type="radio" name="sex" value="男" title="男" checked="">
			<input type="radio" name="sex" value="女" title="女">
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">审核状态</label>
		<div class="layui-input-inline">
			<input type="checkbox" lay-filter="switch" value="已审核" name="state" lay-skin="switch" lay-text="通过|待审核">
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="LAY-user-back-submit" id="LAY-user-back-submit" value="确认">
	</div>
</div>

<script src="../layuiadmin/layui/layui.js"></script>
<script>
	layui.config({
		base: '../layuiadmin/' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'form'], function(){
		var $ = layui.$
			,form = layui.form ;
		//下拉框动态赋值
		$.post("/Demo6/queryRole.action", function (data) {
			console.log(data);
			if (data != undefined && data != null && data != "") {
				var html = "<option ></option>";
				for (var i = 0; i < data.length; i++) {
					html += "<option value=" + data[i] + ">" + data[i] + "</option>";
				}
				$("#rolename").append(html);
			}                //重新渲染select
			form.render();
		});
	})
</script>
</body>
</html>
