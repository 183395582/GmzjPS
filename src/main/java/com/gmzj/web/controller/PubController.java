package com.gmzj.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.gmzj.service.PubService;

@Controller
@Scope("prototype")
@RequestMapping("pub/")
public class PubController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PubService<?> service;
	
	@RequestMapping(value="showMapPage", method = RequestMethod.GET)
	public ModelAndView showMapPage(String region, String point) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("point", point);
		mv.addObject("region", region);
		mv.setViewName("comm/baiduMap");
		return mv;
    }
	
	
}
