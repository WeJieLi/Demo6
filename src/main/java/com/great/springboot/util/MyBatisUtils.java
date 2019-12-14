package com.great.springboot.util;


import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class MyBatisUtils
{
	private static SqlSessionFactory sqlSessionFactory;

	static{
		InputStream inputStream=null;
		try
		{
			String resource="SqlMapConfig.xml";
			inputStream= Resources.getResourceAsStream(resource);
			sqlSessionFactory=new SqlSessionFactoryBuilder().build(inputStream);
		}catch(IOException e){
			e.printStackTrace();
		}finally
		{
			try
			{
				if(inputStream!=null){
					inputStream.close();
				}
			} catch (IOException e)
			{
				e.printStackTrace();
			}
		}
	}

	public  static SqlSession getSession(){
		return sqlSessionFactory.openSession();
	}
}
