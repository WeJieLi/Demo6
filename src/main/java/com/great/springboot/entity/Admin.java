package com.great.springboot.entity;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.stereotype.Service;

@Service
public class Admin
{
	@NotEmpty(message = "登录名不能为空！")
	private String admin;
	@NotEmpty(message = "密码不能为空!")
	private String password;
	private String name;
	private String sex;
	private String addTime;
	private String state;
	private String role;

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getAdmin()
	{
		return admin;
	}

	public void setAdmin(String admin)
	{
		this.admin = admin;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getSex()
	{
		return sex;
	}

	public void setSex(String sex)
	{
		this.sex = sex;
	}

	public String getAddTime()
	{
		return addTime;
	}

	public void setAddTime(String addTime)
	{
		this.addTime = addTime;
	}

	public String getState()
	{
		return state;
	}

	public void setState(String state)
	{
		this.state = state;
	}

	public String getRole()
	{
		return role;
	}

	public void setRole(String role)
	{
		this.role = role;
	}
}
