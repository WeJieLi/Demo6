package com.great.springboot.aoplog;


import com.great.springboot.entity.LogInf;
import com.great.springboot.service.UserService;
import com.great.springboot.util.GetNowTime;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;

@Aspect
@Component
public class LogAspect
{   private HttpServletRequest request;
	@Autowired
	private LogInf logInf ;
	@Autowired
	private UserService userService ;

	//Controller层切点
	@Pointcut("within(com.great.springboot.service.UserService)")
	public void controllerAspect()
	{
	}

	@After("controllerAspect()")
	public void after(JoinPoint joinPoint) throws Throwable
	{
		System.out.println("进入了after方法");
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		//获取传入目标方法的参数值
		Object[] arguments = joinPoint.getArgs();
		Class<?> targetClass = Class.forName(targetName);
		Method[] methods = targetClass.getMethods();
		String operationType = "";
		String operationName = "";
		boolean flag = false;
		for (Method method : methods)
		{
			if (method.getName().equals(methodName))
			{
				Class<?>[] clazzs = method.getParameterTypes();
				if (clazzs.length == arguments.length)
				{
					if (clazzs.length == 0)
					{
						flag = true;
					} else
					{
						for (int i = 0; i < clazzs.length; i++)
						{
							System.out.println(clazzs[i]);
							if (clazzs[i] == arguments[i].getClass())
							{
								flag = true;
								break;
							}
						}
					}

				}
			}
			if (flag)
			{
				operationType = method.getAnnotation(Log.class).operationType();
				operationName = method.getAnnotation(Log.class).operationName();
				break;
			}
		}

		//*========控制台输出=========*//
		System.out.println("=====后置通知开始=====");
		System.out.println("请求方法:" + (joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
		System.out.println("方法类型:" + operationType);
		System.out.println("方法描述:" + operationName);
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		RequestContextHolder.setRequestAttributes(sra, true);
		request = sra.getRequest();
		Object admin=request.getSession().getAttribute("admin");
		if(operationType.equals("1")&&null!=admin){
			logInf.setDate(GetNowTime.getDate());
			logInf.setTime(GetNowTime.getTime());
			logInf.setAffair(operationName);
			logInf.setOperate(admin.toString());
			userService.addLog(logInf);
			System.out.println("日志记录："+logInf.toString());

		}
	}

}
