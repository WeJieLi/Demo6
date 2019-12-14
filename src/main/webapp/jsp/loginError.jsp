<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/10/14
  Time: 1:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String jspPath=request.getContextPath()+"/jsp/";
%>
<html>
<head>
	<title>错误</title>
</head>
<body>
对不起!密码错误,请返回重新登录!
<a href=<%=jspPath+"backlogin.jsp"%>>返回登录</a>
</body>
</html>
