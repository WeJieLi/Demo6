package com.great.springboot.entity;

public class Dept
{
	private int USERID;
	private String USERNAME;
	private String USERNUM;
	private String STATE;
	private String REGISTERDATE;
	private String SCORE;
	private String UPLOADNUM;
	private String DOWNLOADNUM;

	public int getUSERID()
	{
		return USERID;
	}

	public void setUSERID(int USERID)
	{
		this.USERID = USERID;
	}


	public String getUSERNAME()
	{
		return USERNAME;
	}

	public void setUSERNAME(String USERNAME)
	{
		this.USERNAME = USERNAME;
	}

	public String getUSERNUM()
	{
		return USERNUM;
	}

	public void setUSERNUM(String USERNUM)
	{
		this.USERNUM = USERNUM;
	}

	public String getSTATE()
	{
		return STATE;
	}

	public void setSTATE(String STATE)
	{
		this.STATE = STATE;
	}

	public String getREGISTERDATE()
	{
		return REGISTERDATE;
	}

	public void setREGISTERDATE(String REGISTERDATE)
	{
		this.REGISTERDATE = REGISTERDATE;
	}

	public String getSCORE()
	{
		return SCORE;
	}

	public void setSCORE(String SCORE)
	{
		this.SCORE = SCORE;
	}

	public String getUPLOADNUM()
	{
		return UPLOADNUM;
	}

	public void setUPLOADNUM(String UPLOADNUM)
	{
		this.UPLOADNUM = UPLOADNUM;
	}

	public String getDOWNLOADNUM()
	{
		return DOWNLOADNUM;
	}

	public void setDOWNLOADNUM(String DOWNLOADNUM)
	{
		this.DOWNLOADNUM = DOWNLOADNUM;
	}

	@Override
	public String toString()
	{
		return "Dept{" + "USERID=" + USERID + ", USERNAME='" + USERNAME + '\'' + ", USERNUM='" + USERNUM + '\'' + ", STATE='" + STATE + '\'' + ", REGISTERDATE='" + REGISTERDATE + '\'' + ", SCORE='" + SCORE + '\'' + ", UPLOADNUM='" + UPLOADNUM + '\'' + ", DOWNLOADNUM='" + DOWNLOADNUM + '\'' + '}';
	}
}
