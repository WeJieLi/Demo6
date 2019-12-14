<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/12/8
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>添加角色</title>
	<link rel="stylesheet" href="../layuiadmin/layui/css/layui.css" media="all">
	<link rel="stylesheet" href="../layui/css/layui.css" media="all">
	<script src="../js/jquery-3.4.1.js"></script>

</head>
<body>

<div class="layui-form" lay-filter="layuiadmin-form-role" id="layuiadmin-form-role" style="padding: 20px 30px 0 0;">
	<div class="layui-form-item">
		<label class="layui-form-label">角色</label>
		<div class="layui-input-block">
			<input type="text" name="role" lay-verify="required" placeholder="请输入角色名称" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">权限范围</label>
		<div class="layui-input-block">
			<div class="demo-tree-more"  id="test12"></div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">具体描述</label>
		<div class="layui-input-block">
			<textarea type="text" name="descr" lay-verify="required" autocomplete="off"
			          class="layui-textarea"></textarea>
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<button class="layui-btn" lay-submit lay-filter="LAY-user-role-submit" id="LAY-user-role-submit">提交</button>
	</div>
</div>

<script src="../layuiadmin/layui/layui.js"></script>
<script>
	layui.config({
		base: '../layuiadmin/' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'form'], function () {
		var $ = layui.$
			, form = layui.form;
	});

</script>
<script src="../layui/layui.js" charset="utf-8"></script>
<script>
	layui.use(['tree', 'util'], function () {
		var tree = layui.tree;


		$.post("/Demo6/TreeData.action", function (data) {//请求数据
			//渲染
			console.log("data"+data);
			tree.render({
				elem: '#test12'
				, data: data
				, showCheckbox: true  //是否显示复选框
				, id: 'demoId1'
				, isJump: true //是否允许点击节点时弹出新窗口跳转
			});
		});
	});
</script>
</body>
</html>
