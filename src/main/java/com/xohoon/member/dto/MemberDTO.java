package com.xohoon.member.dto;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberDTO {
    private Long id;
    private String email;
    private String password;
    private LocalDateTime createdDate;
    private LocalDateTime modifiedDate;

	/*
	 * public User toEntity(){ return User.builder() .id(id) .email(email)
	 * .password(password) .build(); }
	 */
    @Builder
    public MemberDTO(Long id, String email, String password) {
        this.id = id;
        this.email = email;
        this.password = password;
    }
}
