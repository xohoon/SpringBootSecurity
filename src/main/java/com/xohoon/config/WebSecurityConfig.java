package com.xohoon.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{
	
	// 커스텀 인증을 구현하는 클래스 ,, 주입식 Component
	@Autowired
	private UserAuthenticationProvider authenticationProvider;
	
	// Spring Security Config Method
	@Override
	protected void configure (HttpSecurity http) throws Exception {
		http.authorizeRequests() // 차례대로 규칙이 적용되니 우선순위가 중요하다
			.antMatchers("/css/**", "/js/**", "/img/**").permitAll() // 정적 자원에 대해서는 인증 없이 접근 가능
			.antMatchers("/auth/admin/**").hasRole("ADMIN") // 내부적으로 접두어 "ROLE_"가 붙는다 , ROLE_ADMIN 권한이 있어야 접근가능
			.antMatchers("/auth/**").hasAnyRole("ADMIN", "USER") // 내부적으로 접두어 "ROLE_"가 붙는다
			.anyRequest().authenticated(); // 기타 나머지 요청은 인증 사용자만 접근
		
		http.formLogin() // 로그인폼 세팅
			.loginPage("/login") // default
			//인증 처리하는 경로 지정
			.loginProcessingUrl("/authenticate") // 로그인 페이지 form태그에서 action 속성에 지정할 URI, Spring Security에서 요청을 가로채서 인증 루틴을 실행 
			.failureUrl("/login?error") // default
			.defaultSuccessUrl("/home")
			.usernameParameter("email")
			.passwordParameter("password")
			.permitAll(); // 로그인 페이지 접근을 완전 허용
		
		http.logout()
			.logoutUrl("/logout") // default
			.logoutSuccessUrl("/login") // 로그아웃 후 경로 지정
			.permitAll(); // 경로 접근을 허용
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) {
		auth.authenticationProvider(authenticationProvider);
	}
}
