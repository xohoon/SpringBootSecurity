package com.xohoon.config;

import java.util.ArrayList;

import javax.security.sasl.AuthenticationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

@Component
public class UserAuthenticationProvider implements AuthenticationProvider{
	
	@Autowired
	UserService userService;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException{
		String email = authentication.getName();
		String password = (String) authentication.getCredentials();
		
		MemberVO memberVO = userService.authenticate(email, password);
		if(userVO == null) {
			throw new BadCredentialsException("Login Error");
		}
		userVO.setPassword(null);
		ArrayList<SimpleGrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
		
		return new UsernamePasswordAuthenticationToken(userVO, null, authorities);
	}
	
	@Override
	public boolean supports(Class authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}