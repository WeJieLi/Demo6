function passModify() {
	$("#myModal2").css("display", "block");
}

layui.use(['form', 'layedit', 'laydate'], function () {
	var form = layui.form
		, layer = layui.layer
		, layedit = layui.layedit
		, laydate = layui.laydate;

	//日期
	laydate.render({
		elem: '#date'
	});
	laydate.render({
		elem: '#date1'
	});

	//创建一个编辑器
	var editIndex = layedit.build('LAY_demo_editor');

	//自定义验证规则
	form.verify({
		title: function (value) {
			if (value.length < 5) {
				return '标题至少得5个字符啊';
			}
		}
		, pass: [
			/^[\S]{6,12}$/
			, '密码必须6到12位，且不能出现空格'
		]
		, content: function (value) {
			layedit.sync(editIndex);
		}
	});

	//监听指定开关
	form.on('switch(switchTest)', function (data) {
		layer.msg('开关checked：' + (this.checked ? 'true' : 'false'), {
			offset: '6px'
		});
		layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
	});

	//监听提交
	form.on('submit(demo1)', function (data) {
		layer.alert(JSON.stringify(data.field), {
			title: '最终的提交信息'
		})
		return false;
	});

	//表单赋值
	layui.$('#LAY-component-form-setval').on('click', function () {
		form.val('example', {
			"username": "贤心" // "name": "value"
			, "password": "123456"
			, "interest": 1
			, "like[write]": true //复选框选中状态
			, "close": true //开关状态
			, "sex": "女"
			, "desc": "我爱 layui"
		});
	});

	//表单取值
	layui.$('#LAY-component-form-getval').on('click', function () {
		var data = form.val('example');
		alert(JSON.stringify(data));
	});

});
var pass3;
function passhangw() {
	var pass1 = $("#pass1").val();
	var pass2 = $("#pass2").val();
	 pass3 = $("#pass3").val();
	var pass = $("#pass").val();
	if (pass !== pass1) {
		alert("旧密码有误！请重新输入！")
	} else if (pass1 === pass2) {
		alert("新旧密码不能相同！")
	} else if (pass2 !== pass3) {
		alert("两次密码不一致！请重新输入！")
	}else{
		passchange();
		return3();
	}
}

function return3() {
	$("#pass1").val("");
	$("#pass2").val("");
	$("#pass3").val("");
	$("#myModal2").css("display", "none");
}

function passchange() {
	$.ajax({
		type: "POST",//提交的方式基本上用post
		url: "StaffBusinessServlet",//提交的地址
		data: "methodName=passchange&pass=" + pass3,//提交的数据
		dataType: "text",//希望返回的数据类型
		async: true,//异步操作
		success: function (msg) {//成功的方法  msg为返回数据
			if (eval(msg) === 1) {
				alert("修改成功！");
			} else {
				alert("修改失败！")
			}
		},
		error: function () {//错误的方法
			alert("服务器正忙!")
		}
	});
}