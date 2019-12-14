package com.great.springboot.entity;

import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class MenuInf
{
	private int MENUID;
	private String MENU1NAME;
	private String MENU2NAME;
	private String MENUURL;
	private String MENUFROM;
	private List<Object> list;

	public int getMENUID()
	{
		return MENUID;
	}

	public void setMENUID(int MENUID)
	{
		this.MENUID = MENUID;
	}

	public String getMENU1NAME()
	{
		return MENU1NAME;
	}

	public void setMENU1NAME(String MENU1NAME)
	{
		this.MENU1NAME = MENU1NAME;
	}

	public String getMENU2NAME()
	{
		return MENU2NAME;
	}

	public void setMENU2NAME(String MENU2NAME)
	{
		this.MENU2NAME = MENU2NAME;
	}

	public String getMENUURL()
	{
		return MENUURL;
	}

	public void setMENUURL(String MENUURL)
	{
		this.MENUURL = MENUURL;
	}

	public List<Object> getList()
	{
		return list;
	}

	public void setList(List<Object> list)
	{
		this.list = list;
	}

	public String getMENUFROM()
	{
		return MENUFROM;
	}

	public void setMENUFROM(String MENUFROM)
	{
		this.MENUFROM = MENUFROM;
	}
}
