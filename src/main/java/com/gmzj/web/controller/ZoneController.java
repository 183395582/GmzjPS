package com.gmzj.web.controller;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gmzj.util.DateEditor;
import com.gmzj.entity.Cemetery;
import com.gmzj.entity.CemeteryExample;
import com.gmzj.entity.Zone;
import com.gmzj.entity.Page;
import com.gmzj.service.CemeteryService;
import com.gmzj.service.ZoneService;
import com.gmzj.web.exception.BusinessException;

@Controller
@RequestMapping("/zone")
public class ZoneController {
	protected final Logger logger = LoggerFactory.getLogger(this.getClass()); 

	@Autowired
	private ZoneService service;
	
	@Autowired
	private CemeteryService cemeteryService;

	/**
	 * 初始化jsp中select选项
	 * @param model
	 */
	@ModelAttribute
	public void init(Model model) throws Exception {
		//model.addAttribute("stats", Zone.ComStat.values());
		model.addAttribute("cemeterys", cemeteryService.findCemeterys(new CemeteryExample()));
	}

	@RequestMapping(method = RequestMethod.GET)
	public String list(Model model, Page page, Zone zone) throws Exception {
		page.setParm(zone);
		List<Zone> list = service.listPage(page);
		model.addAttribute("contentModel", list);
		model.addAttribute("page", page);
		model.addAttribute("searchModel", zone);
		return "zone/list";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String showCreateForm(Model model) {
		setCommonData(model);
		model.addAttribute("cemetery", new Cemetery());
		model.addAttribute("zone", new Zone());
		model.addAttribute("op", "园区信息新增");
		return "zone/edit";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String create(Zone zone, RedirectAttributes redirectAttributes) throws Exception {
		service.insert(zone);
		redirectAttributes.addFlashAttribute("msg", "新增成功");
		return "redirect:/zone/";
	} 

	@RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
	public String showUpdateForm(@PathVariable("id") int id, Model model) throws Exception {
		setCommonData(model);
		Zone zone = service.findZoneByKey(id);
		model.addAttribute("cemetery", cemeteryService.findCemeteryByKey(zone.getCemId()));
		model.addAttribute("zone", zone);
		model.addAttribute("op", "园区信息修改");
		return "zone/edit";
	}

	@RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
	public String update(Zone zone, Model model) throws Exception {
		int num = service.update(zone);
		if (num != 1) throw new BusinessException("修改失败");
		model.addAttribute("msg", "修改成功");
		return "zone/edit";
	}
	

	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(int id, Model model) throws Exception {
//		int num = service.delete(id);
		int num = 0;
		if (num != 1) throw new BusinessException("删除失败");
		model.addAttribute("msg", "删除成功");
		return "redirect:/zone/";
	}

	private void setCommonData(Model model) {
	}
	
	/**
	 * 视图数据类型转换
	 */
	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
	    binder.registerCustomEditor(Date.class, new DateEditor()); //对于需要转换为Date类型的属性，使用DateEditor进行处理  
	}
}
