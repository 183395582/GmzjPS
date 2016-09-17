package com.gmzj.web.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gmzj.entity.Cemetery;
import com.gmzj.entity.Page;
import com.gmzj.web.exception.BusinessException;
import com.gmzj.service.CemeteryService;

@Controller
@RequestMapping("/company")
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
	public String list(Model model, Page page, Cemetery company) throws Exception {
		page.setParm(company);
		List<Cemetery> list = service.listPage(page);
		model.addAttribute("contentModel", list);
		model.addAttribute("page", page);
		model.addAttribute("searchModel", company);
		return "company/list";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String showCreateForm(Model model) {
		setCommonData(model);
		model.addAttribute("company", new Cemetery());
		model.addAttribute("op", "公司信息新增");
		return "company/edit";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String create(Cemetery company, RedirectAttributes redirectAttributes) throws Exception {
		service.insert(company);
		redirectAttributes.addFlashAttribute("msg", "新增成功");
		return "redirect:/company/";
	}

	@RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
	public String showUpdateForm(@PathVariable("id") int id, Model model) throws Exception {
		setCommonData(model);
		model.addAttribute("company", service.findCompanyByKey(id));
		model.addAttribute("op", "公司信息修改");
		return "company/edit";
	}

	@RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
	public String update(Cemetery company, Model model) throws Exception {
		int num = service.update(company);
		if (num != 1) throw new BusinessException("修改失败");
		model.addAttribute("msg", "修改成功");
		return "company/edit";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(int id, Model model) throws Exception {
//		int num = service.delete(id);
		int num = 0;
		if (num != 1) throw new BusinessException("删除失败");
		model.addAttribute("msg", "删除成功");
		return "redirect:/company/";
	}

	private void setCommonData(Model model) {
	}
}
