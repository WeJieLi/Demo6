package com.great.springboot.entity;

import java.util.List;

public class Reward
{
	private  String TYPE;
	private  String SCORE;
	private  Dept dept;
	private List<Dept> list;

	public String getTYPE()
	{
		return TYPE;
	}

	public void setTYPE(String TYPE)
	{
		this.TYPE = TYPE;
	}

	public String getSCORE()
	{
		return SCORE;
	}

	public void setSCORE(String SCORE)
	{
		this.SCORE = SCORE;
	}

	public Dept getDept()
	{
		return dept;
	}

	public void setDept(Dept dept)
	{
		this.dept = dept;
	}

	public List<Dept> getList()
	{
		return list;
	}

	public void setList(List<Dept> list)
	{
		this.list = list;
	}
}
