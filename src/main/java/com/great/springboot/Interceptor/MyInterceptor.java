package com.great.springboot.Interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyInterceptor implements HandlerInterceptor
{


	@Override
	public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception
	{
		String url= httpServletRequest.getRequestURI();
		Object object=httpServletRequest.getSession().getAttribute("admin");
		System.out.println("进入拦截，session中的用户名为："+object);
		if(url.endsWith("/Login.action")||null!=object||url.endsWith("/backlogin.action")){
			return true;
		}
		if(null==object){
			httpServletRequest.getRequestDispatcher("/jsp/backlogin.jsp").forward(httpServletRequest,httpServletResponse);
		}
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception
	{

	}

	@Override
	public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception
	{

	}
}