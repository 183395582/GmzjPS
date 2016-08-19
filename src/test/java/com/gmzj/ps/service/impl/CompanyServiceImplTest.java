package com.gmzj.ps.service.impl;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gmzj.entity.Company;
import com.gmzj.entity.CompanyExample;
import com.gmzj.entity.Page;
import com.gmzj.service.impl.CompanyServiceImpl;
import com.gmzj.util.PageData;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-config.xml"})
public class CompanyServiceImplTest {
	@Autowired
	ApplicationContext ctx;
	
//	@Test
	public void testCompany() throws Exception{
		CompanyServiceImpl service =(CompanyServiceImpl) ctx.getBean(CompanyServiceImpl.class);
		List<Company> list = service.findCompanys(new CompanyExample());
		System.out.println(list.size());
	}
	
	@Test
	public void testCompanyPage() throws Exception{
		CompanyServiceImpl service =(CompanyServiceImpl) ctx.getBean(CompanyServiceImpl.class);
		Page page = new Page();
		List<Company> list = service.listPage(page);
		System.out.println(list.size());
	}
}
