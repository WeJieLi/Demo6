<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/10/23
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
	String cssPath = request.getContextPath() + "/css/";
	String jsPath=application.getContextPath()+"/js/";
	String jspPath=application.getContextPath()+"/jsp/";
	String layui=application.getContextPath()+"/layui/";
%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>后台管理  </title>
	<link rel="stylesheet" href=<%=cssPath+"main.css"%>>
	<link rel="stylesheet" href=<%=layui+"css/layui.css"%>>
	<script src=<%=jsPath+"jquery-3.4.1.js"%>></script>
	<script src=<%=layui+"layui.js"%>></script>
	<script src=<%=jsPath+"main.js"%>></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<div  class="layui-logo" >后台管理</div>

		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item">
				<a href="javascript:">
					<img src="http://t.cn/RCzsdCq" class="layui-nav-img">
					${requestScope.username}
				</a>
				<dl class="layui-nav-child">
					<dd><a onclick="passModify()">修改密码</a></dd>
				</dl>
			</li>
			<li class="layui-nav-item"><a href="/Demo6/backlogin.action">退出登录</a></li>



			<div id="myModal2" class="modal22" >
				<!-- 弹窗内容 -->
				<input type="hidden" id="staff" value="${requestScope.staff}">
				<input type="hidden" id="pass" value="${requestScope.pass}">
				<div class="modal-content22" align="center" >
					<table cellspacing="15px" class="search_panel_info" style="width: 200px;height: 300px;">
						<tr>
							<th colspan="2" style="text-align: center;font-size: 30px">密码修改</th>
						</tr>
						<tr>
							<td style="text-align: right">账号：</td>
							<td><span>${requestScope.staff}</span> </td>
						</tr>
						<tr>
							<td style="text-align: right">初始密码：</td>
							<td><input type="password" class="field" id="pass1" minlength="3" maxlength="12" placeholder="旧密码"> </td>
						</tr>
						<tr>
							<td style="text-align: right">新密码：</td>
							<td><input type="password" class="field" id="pass2" minlength="3" maxlength="12" placeholder="新密码(3~12个字符)"> </td>
						</tr>
						<tr>
							<td style="text-align: right">再次确认：</td>
							<td><input type="password" class="field" id="pass3" minlength="3" maxlength="12" placeholder="新密码(3~12个字符)"> </td>
						</tr>
						<tr>
							<td style="text-align:right">
								<input class="btn" type="button" value="修改" onclick="passchangw()">
							</td>
							<td style="text-align:right">
								<input class="btn" type="button" value="返回" onclick="return3()">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</ul>
	</div>

	<div class="layui-side layui-bg-black">
		<div class="layui-side-scroll">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<ul class="layui-nav layui-nav-tree"  lay-filter="test" >
				<c:forEach items="${requestScope.menu}" begin="0" step="1" var="i">
					<li class="layui-nav-item ">
						<a>${i.key}</a>
						<dl class="layui-nav-child">
							<c:forEach items="${i.value}" begin="0" step="1" var="j">
								<dd><a href="${j.MENUURL}"  target="page-view">${j.MENU2NAME}</a></dd>
							</c:forEach>
						</dl>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="layui-body">
		<div >
			<iframe src="" frameborder="0" name="page-view" id="myiframe" style="width: 100%;height: 100%;">
			</iframe>
		</div>
	</div>
	<div class="layui-footer">
		<!-- 底部固定区域 -->
		@ cykj.com - 传一科技
	</div>
</div>
<script>
	// $(function () {
	// 	$("#myiframe").html("/Demo6/jsp/iframe.jsp");
	// });
	//JavaScript代码区域
	layui.use('element', function(){
		var element = layui.element;


	});



</script>
</body>
</html>
