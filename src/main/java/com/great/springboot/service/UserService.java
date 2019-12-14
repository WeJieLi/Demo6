package com.great.springboot.service;

import com.great.springboot.aoplog.Log;
import com.great.springboot.dao.DeptMapper;
import com.great.springboot.entity.Admin;
import com.great.springboot.entity.LogInf;
import com.great.springboot.entity.MenuInf;
import com.great.springboot.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class UserService
{
	@Resource
	private DeptMapper deptMapper;

	@Log(operationType = "1", operationName = "用户登录")
	public Map Login(String admin, String pass)
	{
		return deptMapper.Login(admin, pass);
	}

	@Log(operationType = "0", operationName = "用户登录")
	public Map userLogin(String username, String pass)
	{
		return deptMapper.UserLogin(username, pass);
	}

	@Log(operationType = "1", operationName = "删除用户")
	public int deleteUser(String userId)
	{
		return deptMapper.deleteUser(userId);
	}

	//日志插入
	@Log(operationType = "日志插入", operationName = "日志插入")
	public void addLog(LogInf logInf)
	{
		deptMapper.addLog(logInf);
	}

	//用户表查询
	@Log(operationType = "0", operationName = "用户表查询")
	public List<User> queryUser(String name, String date1, String date2, Integer start, Integer pageSize)
	{
		return deptMapper.queryUser( name, date1, date2, start, pageSize);
	}
	//用户表查询
	@Log(operationType = "查询方法", operationName = "用户表数据数量查询")
	public int queryUserCount(String name,String date1,String date2)
	{
		return deptMapper.queryUserCount( name, date1, date2);
	}

	//管理员表查询
	@Log(operationType = "0", operationName = "管理员表查询")
	public  List<Admin> queryAdmin(String name, String admin,  String role, Integer start, Integer pageSize)
	{
		return deptMapper.queryAdmin( name, admin, role, start, pageSize);
	}
	//管理员表查询
	@Log(operationType = "查询方法", operationName = "管理员表数据数量查询")
	public int queryAdminCount(String name,String admin,String role)
	{
		return deptMapper.queryAdminCount( name, admin, role);
	}
	//添加管理员
	@Log(operationType = "1", operationName = "添加管理员")
	public  int addAdmin(Map map)
	{
		return deptMapper.addAdmin(map);
	}
	@Log(operationType = "0", operationName = "添加管理员权限")
	public  int addAdminRole(String admin,String rolename)
	{
		return deptMapper.addAdminRole(admin,rolename);
	}

	//日志表查询
	@Log(operationType = "0", operationName = "日志表查询")
	public List<LogInf> queryLog(String name,String date1,String date2,Integer start,Integer pageSize)
	{
		return deptMapper.queryLog( name, date1, date2, start, pageSize);
	}
	//日志表查询
	@Log(operationType = "查询方法", operationName = "日志表数据数量查询")
	public int queryLogCount(String name,String date1,String date2)
	{
		return deptMapper.queryLogCount( name, date1, date2);
	}

	//角色表查询
	@Log(operationType = "0", operationName = "角色表查询")
	public  List<Map<String,String>> queryRoles(String role, Integer start, Integer pageSize)
	{
		return deptMapper.queryRoles( role, start, pageSize);
	}

	//角色表查询
	@Log(operationType = "查询方法", operationName = "角色表数据数量查询")
	public int queryRolesCount(String role)
	{
		return deptMapper.queryRolesCount( role);
	}

	@Log(operationType = "0", operationName = "查询菜单")
	public Map<String, List<MenuInf>> selectMenu(String admin)
	{
		List<MenuInf> lis = deptMapper.selectMenu(admin);
		Map<String, List<MenuInf>> map = new HashMap<>();
		for (int i = 0; i < lis.size(); i++)
		{
			MenuInf mi = lis.get(i);
			if (map.containsKey(mi.getMENU1NAME()))
			{
				List<MenuInf> list = map.get(mi.getMENU1NAME());
				list.add(mi);
			} else
			{
				List<MenuInf> list = new ArrayList<>();
				list.add(mi);
				map.put(mi.getMENU1NAME(), list);
			}
		}
		return map;
	}

	//树形结构
	@Log(operationType = "0", operationName = "树形结构")
	public List<Object> selectTree(String admin)
	{
		System.out.println("树形"+admin);
		List<MenuInf> list1 = deptMapper.selectTreeParent(admin);
		List<Object> list = new ArrayList<>();
		if(null!=list1){
			for (MenuInf menuInf : list1)
			{   Map<String, Object> map = new HashMap<>();
				map.put("title",menuInf.getMENU1NAME());
				map.put("id",menuInf.getMENUID());
				map.put("children",queryChild(admin,menuInf.getMENUID()));
				list.add(map);
			}
		}
		return list;
	}

	public  List<Object> queryChild(String admin,int menuid){
		List<MenuInf> list1=deptMapper.selectTreeChild(admin,menuid);
		List<Object> list = new ArrayList<>();
		if(null!=list1){
			for (MenuInf menuInf : list1)
			{Map<String, Object> map = new HashMap<>();
				map.put("title",menuInf.getMENU1NAME());
				map.put("id",menuInf.getMENUID());
				map.put("children",queryChild(admin,menuInf.getMENUID()));
				list.add(map);
			}
		}
		return list;
	}

	//树形结构数据回显
	@Log(operationType = "0", operationName = "树形结构数据回显")
	public  List queryRoleTree(String role){
		System.out.println("----------------------"+role);
		List<Map<String,String>> list1=deptMapper.queryRoleTree(role);
		System.out.println("----------------------"+list1.toString());
		List list = new ArrayList<>();
		if(null!=list1){
			for (Map map : list1)
			{
				System.out.println("==================="+map.get("MENU_ID"));
				List<Map<String,String>> list2=deptMapper.queryRoleTree2(role,map.get("MENU_ID").toString());
				System.out.println("-----------list2-----------"+list2.toString());
				if(null==list2||list2.size()==0){
					list.add(map.get("MENU_ID").toString());
				}
			}
		}
		System.out.println("----------------------"+list.toString());
		return list;
	}

	@Log(operationType = "0", operationName = "角色查询")
	public  List<String> queryRole(){

		return deptMapper.queryRole();
	}


	@Log(operationType = "1", operationName = "添加角色")
	public  int addRole(String role,String msg){
		deptMapper.addRole(role,msg);
		//返回新添加的角色ID
		return queryRolesID( role);
	}
	public  int queryRolesID(String role){

		return deptMapper.queryRolesID(role);
	}

	@Log(operationType = "1", operationName = "添加角色权限")
	//添加角色权限
	public  int addRoleMenu(Map<String,Object> map){

		return deptMapper.addRoleMenu(map);
	}

	//文档上传
	@Log(operationType = "0", operationName = "文档上传")
	public  Integer uploadFile(String title, String type, String user,String date,String score){

		return deptMapper.uploadFile(title,type,user,date,score);
	}

	//文档查询
	@Log(operationType = "0", operationName = "文档查询")
	public  List<Map<String,String>> queryFile( String title, String check,Integer start, Integer pageSize){

		return deptMapper.queryFile(title,check,start,pageSize);
	}
	//文档数量查询
	@Log(operationType = "0", operationName = "文档数量查询")
	public  Integer queryFileCount(String title, String check){

		return deptMapper.queryFileCount(title,check);
	}

	//文档审核
	@Log(operationType = "1", operationName = "文档审核")
	public  Integer changeFileState(String state, String fileID){

		return deptMapper.changeFileState(state,fileID);
	}



}

