package com.great.springboot.dao;


import com.great.springboot.entity.Admin;
import com.great.springboot.entity.LogInf;
import com.great.springboot.entity.MenuInf;
import com.great.springboot.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface DeptMapper
{

	//菜单查询
	public  List<MenuInf> selectMenu(String admin);

	//tree菜单数据查询
	public  List<MenuInf> selectFirstMenu();
	public  List<MenuInf> selectChildMenu(int menuid);

	//tree菜单数据查询
	public  List<MenuInf> selectTreeParent(String admin);
	public  List<MenuInf> selectTreeChild(String admin,int menuid);

	//查询角色
	public  List<String> queryRole();

	//删除用户
	public  int deleteUser(String userId);

	//添加用户
	public  int addUser(User user);
	//添加管理员
	public  int addAdmin(Map map);
	//插入管理员对应的权限关系
	public  int addAdminRole(String admin,String rolename);

	//添加角色
	public  int addRole(String role,String msg);
	//查询角色ID
	public  int queryRolesID(String role);

	//查询角色权限关系
	public  int addRoleMenu(Map<String,Object> params);

	//管理员登录验证
	public  Map Login(@Param("admin") String admin, @Param("pass") String pass);

	//用户登录验证
	public  Map UserLogin(@Param("username") String username, @Param("pass") String pass);


	//日志
	public  void addLog(LogInf logInf);

	public  List<User> queryUser(@Param("name") String name, @Param("date1") String date1, @Param("date2") String date2, @Param("start") Integer start, @Param("pageSize") Integer pageSize);

	//查询用户数量
	public  Integer queryUserCount(@Param("name") String name, @Param("date1") String date1, @Param("date2") String date2);
	//日志表管理
	public  List<LogInf> queryLog(@Param("name") String name, @Param("date1") String date1, @Param("date2") String date2, @Param("start") Integer start, @Param("pageSize") Integer pageSize);

	//查询用户数量
	public  Integer queryLogCount(@Param("name") String name, @Param("date1") String date1, @Param("date2") String date2);

	//管理员表管理
	public  List<Admin> queryAdmin(@Param("name") String name, @Param("admin") String admin, @Param("role") String role, @Param("start") Integer start, @Param("pageSize") Integer pageSize);

	//查询管理员数量
	public  Integer queryAdminCount(@Param("name") String name, @Param("admin") String admin, @Param("role") String role);


	//角色表管理
	public  List<Map<String,String>> queryRoles(@Param("role") String role, @Param("start") Integer start, @Param("pageSize") Integer pageSize);

	//查询角色表数量
	public  Integer queryRolesCount(@Param("role") String role);


	//文档表管理
	public  List<Map<String,String>> queryFile(@Param("title") String title, @Param("check") String check,@Param("start") Integer start, @Param("pageSize") Integer pageSize);

	//查询文档表数量
	public  Integer queryFileCount(@Param("title") String title,@Param("check") String check);


	//文档上传
	public  Integer uploadFile(@Param("title") String title, @Param("type") String type,@Param("user") String user,@Param("date") String date,@Param("score") String score);
	//文档审核
	public  Integer changeFileState(@Param("state") String state, @Param("fileID") String fileID);


	public  List<Map<String,String>> queryRoleTree(@Param("role") String role);
	public  List<Map<String,String>> queryRoleTree2(@Param("role") String role, @Param("id") String id);





}
