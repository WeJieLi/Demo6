<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/12/11
  Time: 22:09
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
	<meta charset="utf-8">
	<title>忘记密码 - layuiAdmin</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" href=<%=path+"/layuiadmin/layui/css/layui.css"%>>
	<link rel="stylesheet" href=<%=path+"/layuiadmin/style/admin.css"%>>
	<link rel="stylesheet" href=<%=path+"/layuiadmin/style/login.css" %>>
	<script src="<%=jsPath+"jquery-3.4.1.js"%>"></script>
	<style>

		#canvas {
			float: right;
			display: inline-block;
			border: 1px solid #ccc;
			border-radius: 5px;
			cursor: pointer;
		}

	</style>
</head>
<body>
<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
	<div class="layadmin-user-login-main">
		<div class="layadmin-user-login-box layadmin-user-login-header">
			<h2>文档中心登录</h2>
<%--			<p>layui 官方出品的单页面后台管理模板系统</p>--%>
		</div>
		<div class="layadmin-user-login-box layadmin-user-login-body layui-form">
			<form  id="myFrom" action="/Demo6/userLogin.action" method="post">
				<div class="layui-form-item">
					<label class="layadmin-user-login-icon layui-icon layui-icon-cellphone" for="LAY-user-login-cellphone"></label>
					<input type="text" name="username" id="username" lay-verify="required" placeholder="请输入账号" class="layui-input">
				</div>
				<div class="layui-form-item">
					<label class="layadmin-user-login-icon layui-icon layui-icon-cellphone" for="LAY-user-login-cellphone"></label>
					<input type="password" name="pass" id="pass" lay-verify="required" placeholder="请输入密码"  class="layui-input">
				</div>
				<div class="layui-form-item">
					<div class="layui-row">
						<div class="layui-col-xs7">
							<label class="layadmin-user-login-icon layui-icon layui-icon-vercode" for="LAY-user-login-vercode"></label>
							<input type="text" name="vercode" id="LAY-user-login-vercode" lay-verify="required" placeholder="图形验证码" class="layui-input">
						</div>
						<div class="layui-col-xs5">
							<div style="margin-left: 10px;">
								<canvas id="canvas" class="layadmin-user-login-codeimg"></canvas>
							</div>
						</div>
					</div>
				</div>

				<div class="layui-form-item">
					<button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-forget-submit">登录</button>
				</div>
			</form>

		</div>
	</div>

	<div class="layui-trans layadmin-user-login-footer">

		<p>© 2018 <a href="http://www.layui.com/" target="_blank">layui.com</a></p>
		<p>
			<span><a href="http://www.layui.com/admin/#get" target="_blank">获取授权</a></span>
			<span><a href="http://www.layui.com/admin/pro/" target="_blank">在线演示</a></span>
			<span><a href="http://www.layui.com/admin/" target="_blank">前往官网</a></span>
		</p>
	</div>

</div>
<script>
	var show_num;
	// 点击获取验证码
	$(function(){
		show_num = [];
		draw(show_num);
		$("#canvas").on('click',function(){
			draw(show_num);
		});

	});

	function draw(show_num) {
		var canvas_width=$('#canvas').width();
		var canvas_height=$('#canvas').height();
		var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
		var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
		canvas.width = canvas_width;
		canvas.height = canvas_height;
		var sCode = "A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0";
		var aCode = sCode.split(",");
		var aLength = aCode.length;//获取到数组的长度

		for (var i = 0; i <= 3; i++) {
			var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
			var deg = Math.random() * 30 * Math.PI / 180;//产生0~30之间的随机弧度
			var txt = aCode[j];//得到随机的一个内容
			show_num[i] = txt.toLowerCase();
			var x = 10 + i * 20;//文字在canvas上的x坐标
			var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
			context.font = "bold 23px 微软雅黑";

			context.translate(x, y);
			context.rotate(deg);

			context.fillStyle = randomColor();
			context.fillText(txt, 0, 0);

			context.rotate(-deg);
			context.translate(-x, -y);
		}
		for (var i = 0; i <= 5; i++) { //验证码上显示线条
			context.strokeStyle = randomColor();
			context.beginPath();
			context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
			context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
			context.stroke();
		}
		for (var i = 0; i <= 30; i++) { //验证码上显示小点
			context.strokeStyle = randomColor();
			context.beginPath();
			var x = Math.random() * canvas_width;
			var y = Math.random() * canvas_height;
			context.moveTo(x, y);
			context.lineTo(x + 1, y + 1);
			context.stroke();
		}
	}

	function randomColor() {//得到随机的颜色值
		var r = Math.floor(Math.random() * 256);
		var g = Math.floor(Math.random() * 256);
		var b = Math.floor(Math.random() * 256);
		return "rgb(" + r + "," + g + "," + b + ")";
	}
</script>
<script src=<%=path+"/layuiadmin/layui/layui.js"%>></script>
<script>
	layui.config({
		base: <%=path+"/layuiadmin/"%> //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'user'], function(){
		var $ = layui.$
			,form = layui.form;


		//找回密码下一步
		form.on('submit(LAY-user-forget-submit)', function(obj){
			var field = obj.field;
			layer.msg(field);
			console.log(field);
			//请求接口
			form.on('submit(formDemo)', function(data){
				layer.msg(JSON.stringify(data.field));
				return false;
			});

			return false;
		});


	});


</script>
</body>
</html>
