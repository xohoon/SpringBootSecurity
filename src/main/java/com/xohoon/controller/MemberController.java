package com.xohoon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
public class MemberController {
	
	@GetMapping("/login")
	public String login(@ModelAttribute("loginForm") LoginForm loginForm, Model model) {
		
		return "login";
	}

}
