package com.great.springboot.servlet;//package great.servlet;
//
//import great.controller.MyController;
//
//import javax.servlet.ServletConfig;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.File;
//import java.io.IOException;
//import java.io.InputStream;
//import java.lang.reflect.Field;
//import java.lang.reflect.Method;
//import java.lang.reflect.Parameter;
//import java.net.URL;
//import java.util.*;
//
//@WebServlet(name = "MyDisptcherServlet",urlPatterns = "/MyDisptcherServlet")
//public class MyDisptcherServlet extends HttpServlet
//{
//	protected final String CONTEXT_CONFIG_LOCATION = "contextConfigLocation";
//	protected final String SCAN_PACKAGES = "scan.package";
//
//	protected  Properties properties = null;
//
//	protected Set<String> classNames = new HashSet<String>();
//
//	protected Map<String, Object> ioc = new HashMap<String, Object>();
//
//	protected Map<String, Method> handlerMapping = new HashMap<String, Method>();
//	@Override
//	public void init(ServletConfig config) throws ServletException {
//
//		doLoadConfig(config.getInitParameter(CONTEXT_CONFIG_LOCATION));
//
//		doScaner(properties.getProperty(SCAN_PACKAGES));
//
//		doInstance();
//
//		initHandlerMapping();
//	}
//	// 导入配置文件
//	private void doLoadConfig(String location){
//		InputStream inputStream = null;
//		properties = new Properties();
//		try
//		{
//			location = location.replace("classpath:", "/");
//			inputStream = getClass().getClassLoader()
//					.getResourceAsStream(location);
//			properties.load(inputStream);
//		} catch (IOException e)
//		{
//			e.printStackTrace();
//		}finally
//		{
//			if(null!=inputStream){
//				try
//				{
//					inputStream.close();
//				} catch (IOException e)
//				{
//					e.printStackTrace();
//				}
//			}
//		}
//	}
//	//扫描
//	private void doScaner(String scanPackage){
//		URL url = getClass().getClassLoader().getResource( "/" +
//				scanPackage.replaceAll("\\.", "/"));
//
//		File dir = new File(url.getFile());
//		if(dir.exists()){
//			File[] flies = dir.listFiles();
//			if(flies != null && flies.length > 0){
//				for (File file : flies) {
//					if(file.isDirectory()){
//						//如果有3层呢？还是用scanPackage?
//						doScaner(scanPackage + "." + file.getName());
//					}else{
//						classNames.add(scanPackage + "." + file.getName().replace(".class", ""));
//						System.out.println(classNames);
//					}
//				}
//			}
//		}
//	}
//	//生成实例放到map
//	private void doInstance(){
//		try {
//			if(classNames.size() > 0){
//				for (String className : classNames) {
//					Class<?> clazz = Class.forName(className);
//					MyController myController = clazz.getAnnotation(MyController.class);
//					if(myController != null){
//						String name = myController.value();
//						if("".equals(name)){
//							name = lowerFirstChar(clazz.getSimpleName());
//						}
//						ioc.put(name, clazz.newInstance());
//					}
//				}
//			}
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		} catch (IllegalAccessException e) {
//			e.printStackTrace();
//		} catch (InstantiationException e) {
//			e.printStackTrace();
//		}
//
//	}
//	//类名首字母小写
//	private String lowerFirstChar(String name){
//		return name != null && name.length() > 1 ?
//				name.substring(0, 1).toLowerCase() + name.substring(1) :
//				name;
//	}
//
//	private void initHandlerMapping(){
//		if(!ioc.isEmpty()){
//			for (Map.Entry<String, Object> entry : ioc.entrySet()) {
//				Class<?>  clazz = entry.getValue().getClass();
//				String baseUrl = null;
//				MyRequestMapping myRequestMapping = clazz.getAnnotation(MyRequestMapping.class);
//				if(myRequestMapping != null){
//					baseUrl = myRequestMapping.value();
//
//				}
//				if(null == baseUrl) {
//					baseUrl = "";
//				}
//				Method[] methods = clazz.getMethods();
//				for (Method method : methods) {
//					myRequestMapping = method.getAnnotation(MyRequestMapping.class);
//					if(myRequestMapping != null){
//						handlerMapping.put(baseUrl + myRequestMapping.value(), method);
//						System.out.println(baseUrl + myRequestMapping.value());
//						System.out.println(method);
//					}
//				}
//			}
//		}
//	}
//
//	private void doDispatch(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException{
//		Object result = null;
//		try {
//
//			//如：/JX190618Card/StaffBusinessServlet
//			String url = request.getRequestURI();
//			//如：/JX190618Card
//			String contextPath = request.getContextPath();
//			url = url.replace(contextPath, "");
////			url = url.replace("MyDisptcherServlet", "");
//			System.out.println("URL="+url);
//			Method method = handlerMapping.get(url);
//			if(method == null){
//				response.getWriter().write("404 not found");
//				return ;
//			}
//
//			if(method.getParameterCount() == 0){
//				//通过该方法所属类的简称获取执行对象，执行方法并返回执行结果
//				result = method.invoke(ioc.get(lowerFirstChar(method.getDeclaringClass().getSimpleName())));
//			}else{
//				//获取参数类型
//				Class<?>[] params = method.getParameterTypes();
//				//获取参数名
//				Parameter[] paramNames = method.getParameters();
//
//				Object[] paramValues = new Object[params.length];
//				for (int i = 0; i < params.length; i++) {
//					if(params[i] == HttpServletRequest.class){
//						paramValues[i] = request;
//					}else if(params[i] == HttpServletResponse.class){
//						paramValues[i] = response;
//					}else if(params[i] == String.class){
//						String value = Arrays.toString(request.getParameterValues(paramNames[i].getName()))
//								.replaceAll("\\[|\\]", "").replaceAll(",\\s", ",");
//						paramValues[i] = value;
//					}else{
//						Object obj = params[i].newInstance();
//						//得某个类的所有声明的字段
//						Field[] fileds = params[i].getDeclaredFields();
//						//将request中：参数-值 转成map
//						Map<String, String[]> parameterMap = request.getParameterMap();
//						boolean isAccess = false;
//						for (Field filed : fileds) {
//							for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
//								if(filed.getName().equals(entry.getKey())){
//									if(!filed.isAccessible()){
//										filed.setAccessible(true);
//										isAccess = true;
//									}
//									String value = Arrays.toString(request.getParameterValues(entry.getKey()))
//											.replaceAll("\\[|\\]", "").replaceAll(",\\s", ",");
//
//									filed.set(ioc.get(lowerFirstChar(filed.getDeclaringClass().getSimpleName())), value);
//									if(isAccess){
//										filed.setAccessible(false);
//									}
//									break;
//								}
//							}
//						}
//
//						paramValues[i] = obj;
//
//					}
//				}
//
//				result =  method.invoke(ioc.get(lowerFirstChar(method.getDeclaringClass().getSimpleName())), paramValues);
//			}
//
//			if(method.getReturnType() != void.class){
//				response.getWriter().write(result.toString());
//				System.out.println("result.toString()"+result.toString());
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//	}
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
//	{
//		doDispatch(request, response);
//	}
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
//	{
//		doDispatch(request, response);
////		request.getRequestDispatcher("/backlogin.jsp").forward(request,response);
//	}
//}
