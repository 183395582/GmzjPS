package com.gmzj.web.bind.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 
 * 该注解用于绑定请求参数（JSON字符串）
 * 
 *
 */
@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface RequestJsonParam {

	/**
	 * 指定请求参数的前缀和暴露到模型对象的名字供视图使用
	 * http://localhost:8080/springmvc/formmodel/map1?map['0']=123&map["1"]=234
	 * public String map1(@FormModel("map") MapWapper<String, Integer> map)
	 * 
	 * http://localhost:8080/springmvc/formmodel/map2?map['0'].password=123&map['0'].username=123&map["1"].username=234
	 * public String map2(@FormModel("map") MapWapper<Integer, UserModel> map)
	 */
	
	/**
	 * 用于绑定的请求参数名字
	 */
	String value() default "";
	
	/**
	 * 是否必须，默认是
	 */
	boolean required() default true;

}
