package com.great.springboot.entity;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;

@Component
public class PageSearch
{
	private int start;
	private BigDecimal count;
	private List list;

	public int getStart()
	{
		return start;
	}

	public void setStart(int start)
	{
		this.start = start;
	}

	public BigDecimal getCount()
	{
		return count;
	}

	public void setCount(BigDecimal count)
	{
		this.count = count;
	}

	public List  getList()
	{
		return list;
	}

	public void setList(List list)
	{
		this.list = list;
	}

	public PageSearch(int start, BigDecimal count, List list)
	{
		this.start = start;
		this.count = count;
		this.list = list;
	}

	public PageSearch()
	{
	}
}
