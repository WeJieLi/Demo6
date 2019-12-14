package com.great.springboot.servlet;


import com.great.springboot.entity.MenuInf;
import com.great.springboot.service.UserService;
import com.great.springboot.util.MD5Utils;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class LoginServlet extends HttpServlet
{
	public void Login(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("进入AdminServlet服务器");
		String admin = request.getParameter("admin");
		String pass = request.getParameter("password");
		request.getSession().setAttribute("admin",admin);
		System.out.println("管理员账号："+admin);
		System.out.println("管理员密码："+pass);

		ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserService userService = (UserService) ac.getBean("userService");

		Map map1=userService.Login(admin, MD5Utils.md5(pass));
		//执行数据库查询  用账号去密码
		//发送来的密码和查询出来密码 做一个匹配  是否密码一致
		String path;
		if(null==map1){
			System.out.println("staffError");
			path="jsp/loginError.jsp";
		}else{
			Map<String, List<MenuInf>> map=userService.selectMenu(admin);
			System.out.println(map);
			System.out.println("depts"+map1);
			path="jsp/main.jsp";
			request.setAttribute("menu",map);
			request.setAttribute("username",map1.get("ADMIN_NAME"));
			request.setAttribute("pass",pass);
		}
		try
		{
			request.getRequestDispatcher(path).forward(request,response);
		} catch (ServletException e)
		{
			e.printStackTrace();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
	}
}
