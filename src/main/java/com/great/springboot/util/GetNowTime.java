package com.great.springboot.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class GetNowTime
{


	public static String getDate(){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date(System.currentTimeMillis());
		String newDate = formatter.format(date);
		return newDate;
	}

	public static String getTime(){
		SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
		Date date = new Date(System.currentTimeMillis());
		String nowTime = formatter.format(date);
		return nowTime;
	}


	public static void main(String[] args)
	{
		System.out.println(getDate());
		System.out.println(getTime());
	}
}
