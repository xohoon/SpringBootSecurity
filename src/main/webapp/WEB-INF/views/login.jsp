<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8" />
<title>Login</title>
</head>
<body>
	login
	<form th:action="@{/login}" method="post">
		name: <input type="text" name="username" id="username" th:value="${username}" /><br />
		p w: <input type="password" name="password" id="password" /><br />
		<div th:if="${logout}">You have been logged out successfully1</div>
		<input type="submit" value="sign in" />
	</form>
	<a href="/registration">registration</a>
</body>
</html>
