<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/11/19
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String layui = application.getContextPath() + "/layuiadmin/";
%>
<html>
<head>
	<title>Title</title>
	<link rel="stylesheet" href="<%=layui+"layui/css/layui.css"%>" media="all">
	<link rel="stylesheet" href="<%=layui+"style/admin.css"%>" media="all">
	<script src=<%=layui + "layui/layui.js"%>></script>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-form layui-card-header layuiadmin-card-header-auto">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">注册时间</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" id="date1" placeholder="yyyy-MM-dd">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">至</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" id="date2" placeholder="yyyy-MM-dd">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">操作人</label>
					<div class="layui-input-block">
						<input type="text" name="username" id="username" placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<button class="layui-btn layuiadmin-btn-useradmin" id="search" lay-submit
					        lay-filter="LAY-user-front-search">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
			</div>
		</div>

		<div class="layui-card-body">
			<div style="padding-bottom: 10px;">
				<button class="layui-btn layuiadmin-btn-useradmin" data-type="batchdel">删除</button>
				<button class="layui-btn layuiadmin-btn-useradmin" data-type="add">添加</button>
			</div>
			<table id="demo" lay-filter="test"></table>

		</div>
	</div>
</div>
<script>
	layui.use('laydate', function () {
		var laydate = layui.laydate;

		//常规用法
		laydate.render({
			elem: '#date1'
		});
		laydate.render({
			elem: '#date2'
		});
	})
</script>

<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
	layui.use('table', function () {
		var table = layui.table;
		//第一个实例
		table.render({
			elem: '#demo'
			, url: '/Demo6/LogSearch.action' //数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10, 20, 30, 40]
			,id: 'testReload'
			//,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
			, defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
				title: '提示'
				, layEvent: 'LAYTABLE_TIPS'
				, icon: 'layui-icon-tips'
			}]
			, cols: [[ //表头
				{field: 'operate', title: '操作人', align: 'center'}
				, {field: 'affair', title: '操作事项', align: 'center'}
				,{field: 'date', title: '操作日期', align: 'center'}
				, {field: 'time', title: '操作时间', align: 'center'}
			]]
		});

		//监听行工具事件
		table.on('tool(test)', function (obj) {
			var data = obj.data;
			console.log(data);
			if (obj.event === 'del') {
				layer.confirm('真的删除行么', function (index) {
					obj.del();
					layer.close(index);
				});
			} else if (obj.event === 'edit') {
				layer.prompt({
					formType: 2
					, value: data.email
				}, function (value, index) {
					obj.update({
						email: value
					});
					layer.close(index);
				});
			}
		});
	});

	layui.config({
		base: '<%=layui%>' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'useradmin', 'table'], function () {
		var $ = layui.$
			, form = layui.form
			, table = layui.table;

		//监听搜索
		form.on('submit(LAY-user-front-search)', function () {
			//执行重载
			table.reload('testReload', {
				page: {
					curr: 1 //重新从第 1 页开始
				}
				, where: {
					key: {
						date1: $('#date1').val(),
						date2: $('#date2').val(),
						username: $('#username').val()
					}
				}
			}, 'data');
		});

		//事件
		var active = {
			batchdel: function () {
				var checkStatus = table.checkStatus('LAY-user-manage')
					, checkData = checkStatus.data; //得到选中的数据

				if (checkData.length === 0) {
					return layer.msg('请选择数据');
				}

				layer.prompt({
					formType: 1
					, title: '敏感操作，请验证口令'
				}, function (value, index) {
					layer.close(index);

					layer.confirm('确定删除吗？', function (index) {

						//执行 Ajax 后重载
						/*
						admin.req({
						  url: 'xxx'
						  //,……
						});
						*/
						table.reload('LAY-user-manage');
						layer.msg('已删除');
					});
				});
			}
			, add: function () {
				layer.open({
					type: 2
					, title: '添加用户'
					, content: 'userform.jsp'
					, maxmin: true
					, area: ['500px', '450px']
					, btn: ['确定', '取消']
					, yes: function (index, layero) {
						var iframeWindow = window['layui-layer-iframe' + index]
							, submitID = 'LAY-user-front-submit'
							, submit = layero.find('iframe').contents().find('#' + submitID);

						//监听提交
						iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
							var field = data.field; //获取提交的字段

							//提交 Ajax 成功后，静态更新表格中的数据
							//$.ajax({});
							table.reload('LAY-user-front-submit'); //数据刷新
							layer.close(index); //关闭弹层
						});

						submit.trigger('click');
					}
				});
			}
		};

		$('.layui-btn.layuiadmin-btn-useradmin').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});
	});
</script>
</body>
</html>
