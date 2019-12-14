<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/11/19
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

	String jsPath = application.getContextPath() + "/js/";
	String layui = application.getContextPath() + "/layuiadmin/";
%>
<html>
<head>
	<title>Title</title>
	<link rel="stylesheet" href="<%=layui+"layui/css/layui.css"%>" media="all">
	<link rel="stylesheet" href="<%=layui+"style/admin.css"%>" media="all">
	<script src=<%=jsPath + "jquery-3.4.1.js"%>></script>
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
					<label class="layui-form-label">用户名</label>
					<div class="layui-input-block">
						<input type="text" name="username" id="username" placeholder="请输入" autocomplete="off"
						       class="layui-input">
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
<%--			<div style="padding-bottom: 10px;">--%>
<%--				<div class="layui-upload">--%>
<%--					<button type="button" class="layui-btn layui-btn-normal" id="test8">选择文件</button>--%>
<%--					<button type="button" class="layui-btn" id="test9">开始上传</button>--%>
<%--					<button class="layui-btn layuiadmin-btn-useradmin" data-type="add">添加</button>--%>
<%--				</div>--%>
<%--			</div>--%>
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
	<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
	<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
	layui.use('table', function () {
		var table = layui.table;
		//第一个实例
		table.render({
			elem: '#demo'
			, url: '/Demo6/UserSearch.action' //数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10, 20, 30, 40]
			, id: 'testReload'
			, defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
				title: '提示'
				, layEvent: 'LAYTABLE_TIPS'
				, icon: 'layui-icon-tips'
			}]
			, cols: [[ //表头
				{field: 'userId', title: '序号', fixed: 'left', align: 'center'}
				, {field: 'userName', title: '用户名', align: 'center'}
				, {field: 'registerDate', title: '注册时间', align: 'center'}
				, {field: 'score', title: '积分', align: 'center'}
				, {field: 'uploadNum', title: '上传文档数', align: 'center'}
				, {field: 'downloadNum', title: '下载文档数', align: 'center'}
				, {field: 'state', title: '状态', align: 'center'}
				, {fixed: 'right', title: '操作', toolbar: '#barDemo', align: 'center'}
			]]

		});

		//监听行工具事件查看、删除、新增
		table.on('tool(test)', function (obj) {//注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data;//获得当前行数据
			console.log(data['userId']);
			if (obj.event === 'detail') {
				layer.msg('用户名：' + data.userName + ' 的查看操作');
			} else if (obj.event === 'del') {
				layer.confirm('真的删除行么', function (index) {
					$.ajax({
						url: "/Demo6/userDelete.action",
						data: "userId=" + data['userId'],
						type: "Post",
						dataType: "json",
						success: function (data) {
							console.log(data);
							if (data.code == 200) {
								obj.del();
								//方法 1
								// table.reload('testReload', {
								// 	page: {
								// 		curr: $(".layui-laypage-em").next().html()  //主要代码行
								// 	}
								// 	, where: {
								// 		date1: $('#date1').val(),
								// 		date2: $('#date2').val(),
								// 		username: $('#username').val()
								// 	}
								// }, 'data');

								//方法2
								// layui.table.reload('testReload',{page:{curr:$(".layui-laypage-em").next().html()}})  ; //这行时在当前页刷新表格的写法

							// ,done:function(res,curr,count){
							// 	// 当前页为最后一页时， 清空这一页的数据需要手动跳转到前一页
							// 		if(curr>1 && res.data.length == 0){
							// 			var pageValue = curr - 1;
							// 			table.reload(tableId2,{
							// 				page:{curr:pageValue},// 修改页码
							// 				data:table2Data
							// 			});
							// 		}
							// 	}
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
				layer.prompt({
					formType: 3
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
					date1: $('#date1').val(),
					date2: $('#date2').val(),
					username: $('#username').val()
				}
			}, 'data');
		});

		//事件
		// var active = {
		// 	add: function () {
		// 		layer.open({
		// 			type: 2
		// 			, title: '添加用户'
		// 			, content: 'userform.jsp'
		// 			, maxmin: true
		// 			, area: ['500px', '450px']
		// 			, btn: ['确定', '取消']
		// 			, yes: function (index, layero) {
		// 				var iframeWindow = window['layui-layer-iframe' + index]
		// 					, submitID = 'LAY-user-front-submit'
		// 					, submit = layero.find('iframe').contents().find('#' + submitID);
		// 				//监听提交
		// 				iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
		// 					var field = data.field; //获取提交的字段
		//
		// 					//提交 Ajax 成功后，静态更新表格中的数据
		// 					//$.ajax({});
		// 					table.reload('LAY-user-front-submit'); //数据刷新
		// 					layer.close(index); //关闭弹层
		// 				});
		//
		// 				submit.trigger('click');
		// 			}
		// 		});
		// 	}
		// };
		//
		// $('.layui-btn.layuiadmin-btn-useradmin').on('click', function () {
		// 	var type = $(this).data('type');
		// 	active[type] ? active[type].call(this) : '';
		// });


	});


	// layui.use('upload', function () {
	// 	var $ = layui.jquery
	// 		, upload = layui.upload;
	// 	//选完文件后不自动上传
	// 	upload.render({
	// 		elem: '#test8'
	// 		, url: '/Demo6/fileupload.action'
	// 		, auto: false
	// 		, accept: 'file' //普通文件
	// 		, exts: 'txt|mmp'
	// 		//,multiple: true
	// 		, bindAction: '#test9'
	// 		, done: function (json) {
	// 			console.log(json);
	// 			if (json.code == 0) {
	// 				return layer.msg("上传失败！")
	// 			}
	// 			if (json.code > 0) {
	// 				return layer.msg("上传成功！")
	// 			}
	// 		}
	// 	});
	// });
</script>
</body>
</html>
