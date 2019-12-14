package com.great.springboot.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class GetWeek
{
	public static List convertWeekByDate(Date time)
	{
		List list=new ArrayList();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //设置时间格式
		Calendar cal = Calendar.getInstance();
		cal.setTime(time);
		//判断要计算的日期是否是周日，如果是则减一天计算周六的，否则会出问题，计算到下一周去了
		int dayWeek = cal.get(Calendar.DAY_OF_WEEK);//获得传入日期是一个星期的第几天
		if (1 == dayWeek)
		{
			cal.add(Calendar.DAY_OF_MONTH, -1);
		}
		System.out.println("要计算日期为:" + sdf.format(cal.getTime())); //输出要计算日期
		cal.setFirstDayOfWeek(Calendar.MONDAY);//设置一个星期的第一天，按中国的习惯一个星期的第一天是星期一
		int day = cal.get(Calendar.DAY_OF_WEEK);//获得传入日期是一个星期的第几天
		cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);//根据日历的规则，给传入日期减去星期几与一个星期第一天的差值
		String Monday = sdf.format(cal.getTime());
		//System.out.println("所在周星期一的日期：" + Monday);
		cal.add(Calendar.DATE, 1);
		String Tuesday = sdf.format(cal.getTime());
		//System.out.println("所在周星期二的日期：" + Tuesday);
		cal.add(Calendar.DATE, 1);
		String Wednesday = sdf.format(cal.getTime());
		//System.out.println("所在周星期三的日期：" + Wednesday);
		cal.add(Calendar.DATE, 1);
		String Thursday = sdf.format(cal.getTime());
		//System.out.println("所在周星期四的日期：" + Thursday);
		cal.add(Calendar.DATE, 1);
		String Friday = sdf.format(cal.getTime());
		//System.out.println("所在周星期五的日期：" + Friday);
		cal.add(Calendar.DATE, 1);
		String Saturday = sdf.format(cal.getTime());
		//System.out.println("所在周星期六的日期：" + Saturday);
		cal.add(Calendar.DATE, 1);
		String Sunday = sdf.format(cal.getTime());
		//System.out.println("所在周星期日的日期：" + Sunday);
		list.add(Monday);
		list.add(Tuesday);
		list.add(Wednesday);
		list.add(Thursday);
		list.add(Friday);
		list.add(Saturday);
		list.add(Sunday);
		return list;
	}

	public static void main(String[] args)
	{
//		try
//		{
//			Date date=new SimpleDateFormat("yyyy-MM-dd").parse("2019-11-01");
//			List list=convertWeekByDate(date);
//			System.out.println(list.get(0));
//			System.out.println(list.get(6));
//		} catch (ParseException e)
//		{
//			e.printStackTrace();
//		}

		String str = "2019-3-21星期一";
		// 去除中文
		//        Pattern pat = Pattern.compile(REGEX_CHINESE);
		//        Matcher mat = pat.matcher(str);
		//        String string = mat.replaceAll("");
		String REGEX_CHINESE = "[\u4e00-\u9fa5]";
		String string = str.replaceAll(REGEX_CHINESE, "");
		System.out.println(string);
	}


}
