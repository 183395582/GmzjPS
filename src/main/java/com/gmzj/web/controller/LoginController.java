package com.gmzj.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gmzj.entity.User;

/**
 * 登陆控制器
 * @author Edward
 *
 */
@Controller
public class LoginController {
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());  

    @RequestMapping(value = "/login")
    public String showLoginForm(HttpServletRequest req, Model model, @ModelAttribute("userModel") User user, BindingResult result) {
    	String exceptionClassName = (String)req.getAttribute("shiroLoginFailure");
        String error = null;
        if(UnknownAccountException.class.getName().equals(exceptionClassName)) {
            error = "用户名/密码错误";
            result.addError(new FieldError("userModel","password", error));
        } else if(IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
            error = "用户名/密码错误";
            result.addError(new FieldError("userModel","password", error));
        } else if(exceptionClassName != null) {
            error = "其他错误：" + exceptionClassName;
            result.addError(new FieldError("userModel","password", error));
        }
        if(!model.containsAttribute("userModel"))
            model.addAttribute("userModel", new User());
        model.addAttribute("error", error);
        return "login";
    }


}
