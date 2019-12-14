package com.great.springboot.entity;

import org.springframework.stereotype.Component;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

@Component
public class User {

	private int userId;
	private String userName;
	private String userNum;
	private String state;
	private String registerDate;
	private String score;
	private String uploadNum;
	private String downloadNum;
	@Pattern(regexp = "^1(3|4|5|7|8)\\d{9}$",message = "手机号码格式错误")
	@NotBlank(message = "手机号码不能为空")
	private String phone;
	@Email(message = "邮箱格式错误")
	private String email;


	public int getUserId()
	{
		return userId;
	}

	public void setUserId(int userId)
	{
		this.userId = userId;
	}

	public String getUserName()
	{
		return userName;
	}

	public void setUserName(String userName)
	{
		this.userName = userName;
	}

	public String getUserNum()
	{
		return userNum;
	}

	public void setUserNum(String userNum)
	{
		this.userNum = userNum;
	}

	public String getState()
	{
		return state;
	}

	public void setState(String state)
	{
		this.state = state;
	}

	public String getRegisterDate()
	{
		return registerDate;
	}

	public void setRegisterDate(String registerDate)
	{
		this.registerDate = registerDate;
	}

	public String getScore()
	{
		return score;
	}

	public void setScore(String score)
	{
		this.score = score;
	}

	public String getUploadNum()
	{
		return uploadNum;
	}

	public void setUploadNum(String uploadNum)
	{
		this.uploadNum = uploadNum;
	}

	public String getDownloadNum()
	{
		return downloadNum;
	}

	public void setDownloadNum(String downloadNum)
	{
		this.downloadNum = downloadNum;
	}
}
