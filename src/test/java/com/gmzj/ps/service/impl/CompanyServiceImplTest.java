package com.gmzj.ps.service.impl;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gmzj.entity.Cemetery;
import com.gmzj.entity.CemeteryExample;
import com.gmzj.entity.Page;
import com.gmzj.service.impl.CemeteryServiceImpl;
import com.gmzj.util.PageData;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-config.xml"})
public class CompanyServiceImplTest {
	@Autowired
	ApplicationContext ctx;
	
//	@Test
	public void testCompany() throws Exception{
		CemeteryServiceImpl service =(CemeteryServiceImpl) ctx.getBean(CemeteryServiceImpl.class);
		List<Cemetery> list = service.findCompanys(new CemeteryExample());
		System.out.println(list.size());
	}
	
	@Test
	public void testCompanyPage() throws Exception{
		CemeteryServiceImpl service =(CemeteryServiceImpl) ctx.getBean(CemeteryServiceImpl.class);
		Page page = new Page();
		List<Cemetery> list = service.listPage(page);
		System.out.println(list.size());
	}
}
