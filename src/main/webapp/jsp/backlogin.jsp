<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/10/14
  Time: 1:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String jsPath=request.getContextPath()+"/js/";
	String imgPath=request.getContextPath()+"/img/";
	String path = request.getContextPath();
	String layui=application.getContextPath()+"/layui/";
%>
<html>
<head>
	<meta charset="UTF-8">
	<title>Title</title>
	<link rel="stylesheet" href=<%=layui+"css/layui.css"%>>
	<script src=<%=jsPath+"jquery-3.4.1.js"%>></script>
	<script src=<%=jsPath+"backlogin.js"%>></script>
	<script src=<%=layui+"layui.js"%>></script>
	<style>

		.code {
			width: 400px;
			margin: 0 auto;
		}
		#canvas {
			float: right;
			display: inline-block;
			border: 1px solid #ccc;
			border-radius: 5px;
			cursor: pointer;
		}

	</style>
</head>

<body style="background-image: url(<%=imgPath+"bg4.jpg"%>)">
<div class="layui-main login" style=" margin-top: 15%;width: 28%;padding: 2%; border-radius: 10px;background-color: rgba(236,255,253,0.87);">
	<form  id="myFrom" action="Login.action" method="post">
		<div class="layui-form-item">
			<label class="layui-form-label">账号：</label>
			<div class="layui-input-inline">
				<input type="text" id="admin" value="admin1" name="admin" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">密码：</label>
			<div class="layui-input-inline">
				<input type="password" value="123" id="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">验证码：</label>
			<div class="layui-input-inline">
				<input type="text" id="code_input" value="1" required lay-verify="required" autocomplete="off" placeholder="请输入验证码" class="layui-input">
			</div>
			<canvas id="canvas" width="100" height="40"></canvas>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" id="mybtn" lay-filter="formDemo">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
		<input type="hidden" name="methodName" value="Login">
	</form>
</div>
</body>

</html>
