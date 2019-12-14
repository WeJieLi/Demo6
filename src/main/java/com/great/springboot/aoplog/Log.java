package com.great.springboot.aoplog;

import java.lang.annotation.*;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD,ElementType.PARAMETER})
public @interface Log
{
	/** 要执行的操作类型  比如：增加操作 **/
	public String operationType() default "";

	/** 要执行的具体操作  比如：添加用户 **/
	public String operationName() default "";

	public String abc() default "";


}
