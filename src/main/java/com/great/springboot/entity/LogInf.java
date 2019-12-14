package com.great.springboot.entity;

import org.springframework.stereotype.Service;

@Service
public class LogInf
{
	private int ID;
	private String operate;
	private String affair;
	private String date;
	private String time;
	private String object;
	private String change;
	private String score;

	public String getTime()
	{
		return time;
	}

	public void setTime(String time)
	{
		this.time = time;
	}

	public int getID()
	{
		return ID;
	}

	public void setID(int ID)
	{
		this.ID = ID;
	}

	public String getOperate()
	{
		return operate;
	}

	public void setOperate(String operate)
	{
		this.operate = operate;
	}

	public String getAffair()
	{
		return affair;
	}

	public void setAffair(String affair)
	{
		this.affair = affair;
	}

	public String getDate()
	{
		return date;
	}

	public void setDate(String date)
	{
		this.date = date;
	}

	public String getObject()
	{
		return object;
	}

	public void setObject(String object)
	{
		this.object = object;
	}

	public String getChange()
	{
		return change;
	}

	public void setChange(String change)
	{
		this.change = change;
	}

	public String getScore()
	{
		return score;
	}

	public void setScore(String score)
	{
		this.score = score;
	}

	@Override
	public String toString()
	{
		return "LogInf{" + "ID=" + ID + ", operate='" + operate + '\'' + ", affair='" + affair + '\'' + ", date='" + date + '\'' + ", object='" + object + '\'' + ", change='" + change + '\'' + ", score='" + score + '\'' + '}';
	}
}
