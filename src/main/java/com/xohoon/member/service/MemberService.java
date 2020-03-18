package com.xohoon.member.service;

import javax.transaction.Transactional;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import com.xohoon.domain.repository.MemberRepository;
import com.xohoon.member.dto.MemberDTO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberService implements UserDetailsService{
	private MemberRepository memberRepository;
	
	@Transactional
	public Long joinUser(MemberDTO memberDTO) {
		// 비밀번호 암호화
		
	}
}
