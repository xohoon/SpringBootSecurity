package com.xohoon.member.service;

import com.xohoon.member.dto.User;

public interface UserService {
	void saveUser(User user, String[] roles);

	User findByUsername(String username);
}
