package com.great.springboot.controller;

import com.google.gson.Gson;

import com.great.springboot.entity.*;
import com.great.springboot.service.UserService;
import com.great.springboot.util.GetNowTime;
import com.great.springboot.util.MD5Utils;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MyController
{
	@Autowired
	private UserService userService;

	@RequestMapping("/sssss/{url}")
	public String matchURL(@PathVariable(value = "url") String path)
	{
		System.out.println("path" + path);
		return path;
	}


	@RequestMapping("/backlogin.action")
	public ModelAndView handleRequest()
	{
		System.out.println("进来了");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("backlogin");
		return modelAndView;
	}


	//管理员登录
	@RequestMapping("/Login.action")
	public String Login(HttpServletRequest request, @Valid Admin admin, BindingResult bindingResult)
	{
		System.out.println("进入AdminServlet服务器");
		StringBuilder sb = new StringBuilder();
		if (bindingResult.hasErrors())
		{
			List<ObjectError> errors = bindingResult.getAllErrors();
			for (ObjectError error : errors)
			{
				sb.append(error.getDefaultMessage()).append(",");
			}
			System.out.println(sb.toString());
			return sb.toString();
		}
		//发送来的密码和查询出来密码 做一个匹配  是否密码一致
		Map map1 = userService.Login(admin.getAdmin(), MD5Utils.md5(admin.getPassword()));
		if (null == map1)
		{
			System.out.println("staffError");
			return "loginError";
		} else
		{
			request.getSession().setAttribute("admin", admin.getAdmin());
			request.getSession().setAttribute("adminName", map1.get("ADMIN_NAME"));
			Map<String, List<MenuInf>> map = userService.selectMenu(admin.getAdmin());
			System.out.println("登录的Admin数据：" + map1);

			request.setAttribute("menu", map);
			request.setAttribute("username", map1.get("ADMIN_NAME"));
		}
		return "main";
	}

	//用户登录
	@RequestMapping("/userLogin.action")
	public String UserLogin(HttpServletRequest request, String username, String pass)
	{
		Map map1 = null;
		if (null != username && pass != null)
		{
			map1 = userService.userLogin(username, MD5Utils.md5(pass));
		}
		//发送来的密码和查询出来密码 做一个匹配  是否密码一致

		if (null == map1)
		{
			System.out.println("登录失败！");
			return "userlogin";
		} else
		{
			request.getSession().setAttribute("user", username);
			request.getSession().setAttribute("username", map1.get("USERNAME"));
			request.setAttribute("username", map1.get("USERNAME"));
			request.setAttribute("score", map1.get("SCORE"));
		}
		return "FileCenter2";
	}

	//文档数据展示
	@RequestMapping("/FileSearch.action")
	@ResponseBody
	public Msg FileSearch(String title,String check,String page, String limit)
	{
		System.out.println("进入方法：UserSearch.action");
		if (title == null)
		{
			title = "";
		}
		int b = Integer.valueOf(limit);
		int a = (Integer.valueOf(page) - 1) * b;
		List<Map<String, String>> files = userService.queryFile(title,check, a, b);
		int count = userService.queryFileCount(title,check);
		Msg msg = new Msg(0, null, count, files);
		return msg;
	}

	//文档审核
	@RequestMapping("/FileCheck.action")
	@ResponseBody
	public String changeFileState(String state,String fileID)
	{
		System.out.println("进入方法：FileCheck.action");

		int count = userService.changeFileState(state,fileID);
		if(count==0){
			return "审核失败！";
		}
		return "审核成功！";
	}

	//用户数据展示
	@RequestMapping("/UserSearch.action")
	@ResponseBody
	public Msg UserSearch(String username, String startDate, String endDate, String page, String limit)
	{
		System.out.println("进入方法：UserSearch.action");
		if (username == null)
		{
			username = "";
		}
		if (startDate == null)
		{
			startDate = "";
		}
		if (endDate == null)
		{
			endDate = "";
		}
		int b = Integer.valueOf(limit);
		int a = (Integer.valueOf(page) - 1) * b;
		List<User> users = userService.queryUser(username, startDate, endDate, a, b);
		int count = userService.queryUserCount(username, startDate, endDate);
		Msg msg = new Msg(0, null, count, users);
		return msg;
	}

	//日志数据展示
	@RequestMapping("/LogSearch.action")
	@ResponseBody
	public Msg LogSearch(String username, String startDate, String endDate, String page, String limit)
	{
		System.out.println("进入方法：LogSearch.action");
		if (username == null)
		{
			username = "";
		}
		if (startDate == null)
		{
			startDate = "";
		}
		if (endDate == null)
		{
			endDate = "";
		}
		int b = Integer.valueOf(limit);
		int a = (Integer.valueOf(page) - 1) * b;
		List<LogInf> logInfs = userService.queryLog(username, startDate, endDate, a, b);
		int count = userService.queryLogCount(username, startDate, endDate);
		Msg msg = new Msg(0, null, count, logInfs);
		return msg;
	}

	//管理员数据展示
	@RequestMapping("/AdminSearch.action")
	@ResponseBody
	public Msg AdminSearch(String name, String admin, String role, String page, String limit)
	{
		System.out.println("进入方法：LogSearch.action");
		if (name == null)
		{
			name = "";
		}
		if (admin == null)
		{
			admin = "";
		}
		if (role == null)
		{
			role = "";
		}
		int b = Integer.valueOf(limit);
		int a = (Integer.valueOf(page) - 1) * b;
		List<Admin> logInfs = userService.queryAdmin(name, admin, role, a, b);
		int count = userService.queryAdminCount(name, admin, role);
		Msg msg = new Msg(0, null, count, logInfs);
		return msg;
	}

	@RequestMapping("/addAdmin.action")
	@ResponseBody
	//管理员添加
	public String addAdmin(String field)
	{
		Gson gson = new Gson();
		HashMap<String, String> map = gson.fromJson(field, HashMap.class);
		String state = map.get("state");
		if (null == state)
		{
			state = "未审核";
		}
		map.put("state", state);
		map.put("date", GetNowTime.getDate());
		System.out.println("添加管理员的map=" + map);
		if (userService.addAdmin(map) != 0)
		{
			if (userService.addAdminRole(map.get("admin"), map.get("rolename")) == 0)
			{
				return "添加失败！";
			}
		} else
		{
			return "添加失败！";
		}

		return "添加成功！";
	}

	@RequestMapping("/RoleSearch.action")
	@ResponseBody
	//角色数据展示
	public Msg RoleSearch(String rolename, String page, String limit)
	{
		System.out.println("进入方法：RoleSearch.action");

		if (rolename == null)
		{
			rolename = "";
		}
		int b = Integer.valueOf(limit);
		int a = (Integer.valueOf(page) - 1) * b;
		List<Map<String, String>> list = userService.queryRoles(rolename, a, b);
		int count = userService.queryRolesCount(rolename);
		Msg msg = new Msg(0, null, count, list);
		return msg;
	}

	@RequestMapping("/queryRoleTree.action")
	@ResponseBody
	//角色数据展示
	public List queryRoleTree(String role)
	{

		return userService.queryRoleTree(role);
	}


	//文件上传
	@RequestMapping("/fileupload.action")
	@ResponseBody
	public Map<String, Object> fileupload(HttpServletRequest request, MultipartFile file)
	{
		System.out.println("开始文件上传");
		String fileName = file.getOriginalFilename();
		String title = fileName.substring(0, fileName.lastIndexOf("."));
		String[] arr = fileName.split("\\.");
		String type = arr[arr.length - 1];
		Map map = new HashMap<String, Object>();
		try
		{
			file.transferTo(new File("F:\\文件上传文件夹\\" + file.getOriginalFilename()));
			userService.uploadFile(title, type, request.getSession().getAttribute("username").toString(), GetNowTime.getDate(), "10");
			map.put("code", 200);
			map.put("msg", "ok");
		} catch (IOException e)
		{
			map.put("code", 0);
			map.put("msg", "error");
			e.printStackTrace();
		}
		return map;
	}

	//	/*
	//	 * 下载方式一：
	//	 * ①获取前台要下载的文件名称
	//	 * ②设置响应类型
	//	 * ③设置下载页显示的文件名
	//	 * ④获取下载文件夹的绝对路径和文件名合并为File类型
	//	 * ⑤将文件复制到浏览器
	//	 */
	//	@RequestMapping("/download")
	//	@ResponseBody
	//	public void download(HttpServletRequest req, HttpServletResponse resp, String filename) throws Exception {
	//		String realPath = req.getServletContext().getRealPath("/download");//获取下载文件的路径
	//		File file = new File(realPath, filename);//把下载文件构成一个文件处理   filename:前台传过来的文件名称
	//
	//		//设置响应类型  ==》 告诉浏览器当前是下载操作，我要下载东西
	//		resp.setContentType("application/x-msdownload");
	//		//设置下载时文件的显示类型(即文件名称-后缀)   ex：txt为文本类型
	//		resp.setHeader("Content-Disposition", "attachment;filename=" + filename);
	//
	//		//下载文件：将一个路径下的文件数据转到一个输出流中，也就是把服务器文件通过流写(复制)到浏览器端
	//		Files.copy(file.toPath(), resp.getOutputStream());//Files.copy(要下载的文件的路径,响应的输出流)
	//	}
	//文件下载
	@RequestMapping("/Download.action")
	public ResponseEntity<byte[]> export(String fileName) throws IOException
	{
		System.out.println("文件下载：" + fileName );
		File file = new File("F:\\文件上传文件夹\\" + fileName);
		HttpHeaders headers = new HttpHeaders();

		// MediaType:互联网媒介类型 contentType：具体请求中的媒体类型信息
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDispositionFormData("attachment", fileName);

		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}


	//删除用户
	@RequestMapping("/userDelete.action")
	@ResponseBody
	public Map<String, Object> userDelete(String userId)
	{
		System.out.println("用户数据删除");
		System.out.println("userId" + userId);
		Map map = new HashMap<String, Object>();
		int num = userService.deleteUser(userId);
		if (num > 0)
		{
			map.put("code", 200);
			map.put("msg", "删除成功！");
		} else
		{
			map.put("code", 0);
			map.put("msg", "删除失败！");
		}
		return map;
	}

	//树形组件数据
	@RequestMapping("/TreeData.action")
	@ResponseBody
	public List<Object> getTree(HttpServletRequest request)
	{
		System.out.println("用户：" + request.getSession().getAttribute("admin").toString());
		List<Object> objects = userService.selectTree(request.getSession().getAttribute("admin").toString());

		return objects;
	}

	@RequestMapping("/queryRole.action")
	@ResponseBody
	public List<String> queryRole()
	{
		System.out.println("进入角色查询");
		return userService.queryRole();
	}

	@RequestMapping("/addRole.action")
	@ResponseBody
	public String addRole(String field)
	{
		System.out.println("添加角色");
		Gson gson = new Gson();
		HashMap<String, String> map = gson.fromJson(field, HashMap.class);
		System.out.println(map);
		List list = new ArrayList();
		//解析获取前台传来的角色名、信息、权限列表
		String role = map.get("role");
		String msg = map.get("descr");
		map.remove("role");
		map.remove("descr");
		System.out.println(map);
		for (String key : map.keySet())
		{
			list.add(map.get(key));
		}
		int roleID = userService.addRole(role, msg);
		System.out.println("roleID=" + roleID);
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("roleID", roleID);
		map1.put("menus", list);
		System.out.println(map1);
		userService.addRoleMenu(map1);
		return "添加成功！";
	}


}
