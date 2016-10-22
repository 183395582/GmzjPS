package com.gmzj.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gmzj.entity.Cemetery;
import com.gmzj.entity.CemeteryExample;
import com.gmzj.entity.CemeteryExample.Criteria;
import com.gmzj.entity.Page;
import com.gmzj.service.CemeteryService;
import com.gmzj.web.exception.BusinessException;

@Controller
@RequestMapping("/cemetery")
public class CemeteryController {
	protected final Logger logger = LoggerFactory.getLogger(this.getClass()); 

	@Autowired
	private CemeteryService service;

	/**
	 * 初始化jsp中select选项
	 * @param model
	 */
	@ModelAttribute
	public void init(Model model) {
		model.addAttribute("stats", Cemetery.ComStat.values());
		model.addAttribute("types", Cemetery.ComType.values());
	}

	@RequestMapping(method = RequestMethod.GET)
	public String list(Model model, Page page, Cemetery cemetery) throws Exception {
		page.setParm(cemetery);
		List<Cemetery> list = service.listPage(page);
		model.addAttribute("contentModel", list);
		model.addAttribute("page", page);
		model.addAttribute("searchModel", cemetery);
		return "cemetery/list";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String showCreateForm(Model model) {
		setCommonData(model);
		model.addAttribute("cemetery", new Cemetery());
		model.addAttribute("op", "公司信息新增");
		return "cemetery/edit";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String create(Cemetery cemetery, RedirectAttributes redirectAttributes) throws Exception {
		service.insert(cemetery);
		redirectAttributes.addFlashAttribute("msg", "新增成功");
		return "redirect:/cemetery/";
	}

	@RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
	public String showUpdateForm(@PathVariable("id") int id, Model model) throws Exception {
		setCommonData(model);
		model.addAttribute("cemetery", service.findCemeteryByKey(id));
		model.addAttribute("op", "公司信息修改");
		return "cemetery/edit";
	}

	@RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
	public String update(Cemetery cemetery, Model model) throws Exception {
		int num = service.update(cemetery);
		if (num != 1) throw new BusinessException("修改失败");
		model.addAttribute("msg", "修改成功");
		return "cemetery/edit";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(int id, Model model) throws Exception {
//		int num = service.delete(id);
		int num = 0;
		if (num != 1) throw new BusinessException("删除失败");
		model.addAttribute("msg", "删除成功");
		return "redirect:/cemetery/";
	}

	@ResponseBody
	@RequestMapping(value="/mudata", method = RequestMethod.POST)
	public List ajaxMudata(@RequestParam("prov") String pr,@RequestParam("city") String ct,@RequestParam("dist") String di,
			Model model) throws Exception{
		CemeteryExample example = new CemeteryExample();
		Criteria criteria = example.createCriteria();
		/*if(pr!=""){
			criteria.andProvEqualTo(pr);
		}
		if(ct!=""){
			criteria.andCityEqualTo(ct);
		}
		if(di!=""){
			criteria.andDistEqualTo(di);
		}*/
		
		List<Cemetery> list = service.findCemeterys(example);
		return list;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/getCemeterys", method = RequestMethod.GET)
	public Object getCemeterys(String regionno) throws Exception{
		CemeteryExample example = new CemeteryExample();
		Criteria criteria = example.createCriteria();
		criteria.andRegionnoEqualTo(regionno);
		List<Cemetery> list = service.findCemeterys(example);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("succflag", 0);
		map.put("data", list);
		return map;
	}
	
	private void setCommonData(Model model) {
	}
}
