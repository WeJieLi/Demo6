<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/12/8
  Time: 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>角色管理</title>
	<link rel="stylesheet" href="../layuiadmin/layui/css/layui.css" media="all">
	<link rel="stylesheet" href="../layuiadmin/style/admin.css" media="all">
	<script src="../js/jquery-3.4.1.js"></script>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-form layui-card-header layuiadmin-card-header-auto">
			<div class="layui-form-item">
				<div class="layui-inline">
					角色筛选
				</div>
				<div class="layui-inline">
					<select id="rolename" name="rolename" lay-search lay-filter="LAY-user-adminrole-type">

					</select>
				</div>
			</div>
		</div>
		<div class="layui-card-body">
			<div style="padding-bottom: 10px;">
				<button class="layui-btn layuiadmin-btn-role" data-type="add">添加</button>
			</div>

			<table id="demo" lay-filter="demo"></table>

		</div>
	</div>
</div>
<script type="text/html" id="buttonTpl">
	{{#  if(d.check == true){ }}
	<button class="layui-btn layui-btn-xs">已审核</button>
	{{#  } else { }}
	<button class="layui-btn layui-btn-primary layui-btn-xs">未审核</button>
	{{#  } }}
</script>
<script type="text/html" id="barDemo">
<%--	<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>--%>

	{{#  if(d.ROLE_NAME == '超级管理员'){ }}
	<a class="layui-btn layui-btn-disabled layui-btn-xs"><i class="layui-icon layui-icon-edit"></i>编辑</a>
	<a class="layui-btn layui-btn-disabled layui-btn-xs"><i class="layui-icon layui-icon-delete"></i>删除</a>
	{{#  } else { }}
	<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
			class="layui-icon layui-icon-delete"></i>删除</a>
	{{#  } }}
</script>
<script src="../layuiadmin/layui/layui.js"></script>
<script>
	function selectRender(form) {
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
	}


	layui.config({
		base: '../layuiadmin/' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'useradmin', 'table'], function () {
		var $ = layui.$
			, form = layui.form
			, table = layui.table;


		selectRender(form);

		//搜索角色
		form.on('select(LAY-user-adminrole-type)', function (data) {
			//执行重载
			console.log(data.value);
			table.reload('testReload', {
				where: {
					rolename: data.value
				}
			});
		});
		//表格加载
		table.render({
			elem: '#demo'
			, url: '/Demo6/RoleSearch.action' //数据接口
			, page: true //开启分页
			, limit: 10
			, limits: [5, 10, 20, 30, 40]
			, id: 'testReload'
			//,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
			// , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
			// 	title: '提示'
			// 	, layEvent: 'LAYTABLE_TIPS'
			// 	, icon: 'layui-icon-tips'
			// }]
			, cols: [[ //表头
				{type: 'numbers', title: '序号', align: 'center'}
				, {field: 'ROLE_NAME', title: '角色', align: 'center'}
				, {field: 'ROLE_MSG', title: '具体描述', align: 'center'}
				, {fixed: 'right', title: '操作', toolbar: '#barDemo', align: 'center'}
			]]
		});

		//监听行工具事件查看、删除、新增
		table.on('tool(demo)', function (obj) {//注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data;//获得当前行数据
			console.log(data.ROLE_NAME);
			if (obj.event === 'detail') {
				layer.msg('用户名：' + data.ROLE_NAME + ' 的查看操作');
			} else if (obj.event === 'del') {
				layer.confirm('真的删除行么', function (index) {
					$.ajax({
						url: "",
						data: "userId=" + data['userId'],
						type: "Post",
						dataType: "json",
						success: function (data) {
							console.log(data);
							if (data.code == 200) {
								obj.del();
								return layer.msg(data.msg);
							}

						},
						error: function (data) {
							layer.msg("连接异常！");
						}
					});
					layer.close(index);
				});
			} else if (obj.event === 'edit') {
				layer.open({
					type: 2
					, title: '修改角色'
					, content: 'treeEdit.jsp'
					, area: ['500px', '480px']
					, btn: ['确定', '取消']
					,success:function (layero,index) {
						var body = layer.getChildFrame('body', index);
						// 取到弹出层里的元素，并把编辑的内容放进去
						body.find("#role").val(data.ROLE_NAME);  //设置子窗口指定元素的值
						body.find("#msg").val(data.ROLE_MSG);
						// 记得重新渲染表单
						form.render();
					}
					, yes: function (index, layero) {
						var iframeWindow = window['layui-layer-iframe' + index]
							, submit = layero.find('iframe').contents().find("#LAY-user-role-submit");
						//监听提交
						iframeWindow.layui.form.on('submit(LAY-user-role-submit)', function (data) {
							var field = data.field; //获取提交的字段
							//提交 Ajax 成功后，静态更新表格中的数据
							$.ajax({
								type: "POST",//提交的方式基本上用post
								url: "/Demo6/addRole.action",//提交的地址
								data: "field=" + JSON.stringify(field) + "&type=edit",//提交的数据
								dataType: "Text",//希望返回的数据类型
								async: true,//异步操作
								success: function (msg) {//成功的方法  msg为返回数据
									layer.msg("修改成功!");
									$("#role").remove();
									selectRender(form);
									table.reload('testReload');
									layer.close(index); //关闭弹层
								},
								error: function () {//错误的方法
									alert("服务器正忙!")
								}
							});

						});

						submit.trigger('click');
					}
				});
			}

		});

		//事件
		var active = {
			add: function () {
				layer.open({
					type: 2
					, title: '添加新角色'
					, content: 'roleform.jsp'
					, area: ['500px', '480px']
					, btn: ['确定', '取消']
					, yes: function (index, layero) {
						var iframeWindow = window['layui-layer-iframe' + index]
							, submit = layero.find('iframe').contents().find("#LAY-user-role-submit");

						//监听提交
						iframeWindow.layui.form.on('submit(LAY-user-role-submit)', function (data) {
							var field = data.field; //获取提交的字段

							//提交 Ajax 成功后，静态更新表格中的数据
							$.ajax({
								type: "POST",//提交的方式基本上用post
								url: "/Demo6/addRole.action",//提交的地址
								data: "field=" + JSON.stringify(field),//提交的数据
								dataType: "Text",//希望返回的数据类型
								async: true,//异步操作
								success: function (msg) {//成功的方法  msg为返回数据
									layer.msg(msg);
									$("#rolename").remove();
									selectRender(form);
									table.reload('testReload');
									layer.close(index); //关闭弹层
								},
								error: function () {//错误的方法
									alert("服务器正忙!")
								}
							});

						});

						submit.trigger('click');
					}
				});
			}
		};

		$('.layui-btn.layuiadmin-btn-role').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});
	});
</script>
</body>
</html>
