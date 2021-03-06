package com.gmzj.web.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gmzj.util.DateEditor;
import com.gmzj.entity.CemType;
import com.gmzj.entity.Page;
import com.gmzj.service.CemTypeService;
import com.gmzj.web.exception.BusinessException;

@Controller
@RequestMapping("/cemType")
public class CemTypeController {
	protected final Logger logger = LoggerFactory.getLogger(this.getClass()); 

	@Autowired
	private CemTypeService service;

	/**
	 * 初始化jsp中select选项
	 * @param model
	 */
	@ModelAttribute
	public void init(Model model) {
		//model.addAttribute("stats", CemType.ComStat.values());
	}

	@RequestMapping(method = RequestMethod.GET)
	public String list(Model model, Page page, CemType cemtype) throws Exception {
		page.setParm(cemtype);
		List<CemType> list = service.listPage(page);
		model.addAttribute("contentModel", list);
		model.addAttribute("page", page);
		model.addAttribute("searchModel", cemtype);
		return "cemtype/list";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String showCreateForm(Model model) {
		setCommonData(model);
		model.addAttribute("cemtype", new CemType());
		model.addAttribute("op", "墓型信息新增");
		return "cemtype/edit";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String create(CemType cemtype, RedirectAttributes redirectAttributes) throws Exception {
		service.insert(cemtype);
		redirectAttributes.addFlashAttribute("msg", "新增成功");
		return "redirect:/cemtype/";
	}

	@RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
	public String showUpdateForm(@PathVariable("id") int id, Model model) throws Exception {
		setCommonData(model);
		model.addAttribute("cemtype", service.findCemTypeByKey(id));
		model.addAttribute("op", "墓型信息修改");
		return "cemtype/edit";
	}

	@RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
	public String update(CemType cemtype, Model model) throws Exception {
		int num = service.update(cemtype);
		if (num != 1) throw new BusinessException("修改失败");
		model.addAttribute("msg", "修改成功");
		return "cemtype/edit";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(int id, Model model) throws Exception {
//		int num = service.delete(id);
		int num = 0;
		if (num != 1) throw new BusinessException("删除失败");
		model.addAttribute("msg", "删除成功");
		return "redirect:/cemtype/";
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
