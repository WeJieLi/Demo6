<%--
  Created by IntelliJ IDEA.
  User: 14506
  Date: 2019/12/7
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>管理员管控</title>
	<link rel="stylesheet" href="../layuiadmin/layui/css/layui.css" media="all">
	<link rel="stylesheet" href="../layuiadmin/style/admin.css" media="all">
	<script src="../layuiadmin/layui/layui.js"></script>
	<script src="../js/jquery-3.4.1.js"></script>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-form layui-card-header layuiadmin-card-header-auto">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">文档搜索</label>
					<div class="layui-input-block">
						<input type="text" name="title" id="title" placeholder="请输入文档标题" autocomplete="off"
						       class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<button class="layui-btn layuiadmin-btn-admin" lay-submit lay-filter="LAY-user-back-search">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
			</div>
		</div>

		<div class="layui-card-body">
			<table id="demo" lay-filter="demo"></table>
		</div>
	</div>
</div>

<script type="text/html" id="barDemo">
	{{#  if(d.FILE_STATE == '已审核'){ }}
	<a  lay-event="check"><input type="checkbox" value="55" id="check1" checked name="open" lay-skin="switch"  lay-filter="switchTest" lay-text="通过|待审核"></a>

	{{#  } else { }}
	<a  lay-event="check"><input type="checkbox" id="check1" name="open" lay-skin="switch"  lay-filter="switchTest" lay-text="通过|待审核"></a>

	{{#  } }}

</script>
<script type="text/html" id="del">
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>

</script>

<script>

	layui.use('table', function () {
		var table = layui.table;
		var form=layui.form;
		//第一个实例
		table.render({
			elem: '#demo'
			, url: '/Demo6/FileSearch.action' //数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10, 20, 30, 40]
			, id: 'testReload'
			, cols: [[ //表头
				{type: 'numbers', title: '序号', align: 'center'}
				, {field: 'FILE_ID',title: '文档ID', align: 'center',hide:true,width:0}
				, {field: 'FILE_TITLE', title: '文档标题', align: 'center',hidden:true}
				, {field: 'FILE_UPLOAD_USER', title: '上传人', align: 'center'}
				, {field: 'FILE_UPLOAD_DATE', title: '上传时间', align: 'center'}
				, {field: 'FILE_DOWN_SCORE', title: '下载积分', align: 'center'}
				, {field: 'FILE_TYPE', title: '文档类型', align: 'center'}
				, {field: 'FILE_DOWN_TIMES', title: '下载次数', align: 'center'}
				, {field: 'FILE_STATE', title: '审核状态', align: 'center'}
				, {fixed: 'right', title: '审核', toolbar: '#barDemo', align: 'center'}
				, {fixed: 'right', title: '删除', toolbar: '#del', align: 'center'}
			]]
		});

		//监听行工具事件查看、删除、新增
		table.on('tool(demo)', function (obj) {//注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data;//获得当前行数据
			var check;
			if (obj.event === 'check') {
				// form.on('switch(switchTest)', function(data){
				// 	layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
				// 		offset: '6px'
				// 	});
				// 	layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
				// });
				// 	if($("#check1").checked) {
				// 		check='已审核';
				//
				// 	}else {check='未审核';}

					// layer.msg($("#check1").checked)
				// 	$.post("/Demo6/FileCheck.action",{}, function (data) {
				// 		layer.msg(data);
				// 		//重新渲染select
				// 		table.reload('testReload')
				//
				//
				// });

			} else if (obj.event === 'del') {
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
						table.reload('demo');
						layer.msg('已删除');
					});
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
		base: '../layuiadmin/' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'useradmin', 'table'], function () {
		var $ = layui.$
			, form = layui.form
			, table = layui.table;
		//下拉框动态赋值
		$.post("/Demo6/queryRole.action", function (data) {
			console.log(data);
			if (data != undefined && data != null && data != "") {
				var html = "<option ></option>";
				for (var i = 0; i < data.length; i++) {
					html += "<option value=" + data[i] + ">" + data[i] + "</option>";
				}
				$("#role").append(html);
			}                //重新渲染select
			form.render();
		});
		//监听搜索
		form.on('submit(LAY-user-back-search)', function (data) {
			var field = data.field;
			//执行重载
			console.log("监听搜索");
			table.reload('testReload', {
				page: {
					curr: 1 //重新从第 1 页开始
				}
				, where: {
					title: $('#title').val()
				}
			});
		});



		form.on('switch(switchTest)', function(data){
			console.log(fileID);
			var check;
			if(this.checked) {check='已审核';}else {check='未审核';}
			// $.post("/Demo6/queryRole.action",{}, function (data) {
			// 	layer.msg(data);
			// 	//重新渲染select
			// 	table.reload('testReload')
			// });

		});




		//事件
		var active = {
			add: function () {
				layer.open({
					type: 2
					, title: '添加管理员'
					, content: 'adminform.jsp'
					, area: ['420px', '420px']
					, btn: ['确定', '取消']
					, yes: function (index, layero) {
						var iframeWindow = window['layui-layer-iframe' + index]
							, submitID = 'LAY-user-back-submit'
							, submit = layero.find('iframe').contents().find('#LAY-user-back-submit');

						//监听提交
						iframeWindow.layui.form.on('submit(LAY-user-back-submit)', function (data) {
							var field = data.field; //获取提交的字段
							console.log(field);
							//提交 Ajax 成功后，静态更新表格中的数据
							$.ajax({
								type:"POST",//提交的方式基本上用post
								url:"/Demo6/addAdmin.action",//提交的地址
								data:"field="+JSON.stringify(field),//提交的数据
								dataType:"Text",//希望返回的数据类型
								async: true,//异步操作
								success:function (msg) {//成功的方法  msg为返回数据
									layer.msg(msg);
									table.reload('testReload');
									layer.close(index); //关闭弹层
								},
								error:function () {//错误的方法
									alert("服务器正忙!")
								}
							});
						});

						submit.trigger('click');
					}
				});
			}
		};
		$('.layui-btn.layuiadmin-btn-admin').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});
	});
</script>
</body>
</html>
