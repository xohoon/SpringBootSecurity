package com.xohoon.domain.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.xohoon.member.dto.User;

public interface UserRepository extends JpaRepository<User, Long> {
	public User findByUsername(String username);
}
