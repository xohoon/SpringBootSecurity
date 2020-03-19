package com.xohoon.dto;

import java.time.LocalDateTime;

import com.xohoon.domain.entity.MemberEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberDto {
	private Long id;
	private String email;
	private String password;
	private LocalDateTime createdDate;
	private LocalDateTime modifiedDate;

	public MemberEntity toEntity() {
		return MemberEntity.builder().id(id).email(email).password(password).build();
	}

	@Builder
	public MemberDto(Long id, String email, String password) {
		this.id = id;
		this.email = email;
		this.password = password;
	}
}