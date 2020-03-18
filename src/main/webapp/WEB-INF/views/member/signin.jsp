<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IEH Login</title>
</head>
<body>
	회원님의 타입을 정해주세요 <input type="radio" id="type1" name="type" value="1">고용인
   	<input type="radio" id="type2" name="type" value="2">구직인
	<input type="text" id="mail" placeholder="E-mail" class="form-control" style="width:300px; float:left;"><br>
	<input type="password" id="password" placeholder="Password" class="form-control" style="width:300px; float:left;"><br>
	<button type="button" id="loginBtn" class="btn btn-primary">로그인</button>
</body>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- jquery & bootstrap js -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/static/js/jquery-3.1.1.min.js"></script>
<!-- 
<script type="text/javascript" src="/static/js/member/signin.js"></script>
 -->

<script>
$(document).ready(function() {
	console.log("jsp???");
});

$('#loginBtn').on('click', function() {
	var type = $(':radio[name="type"]:checked').val();
	type = Number(type);
	mail = $('#mail').val();
	password = $('#password').val();
	console.log(type+"//"+mail);
	$.ajax({
		type : 'POST',
		url : '/member/signin',
		dataType : "JSON",
		data : {
			type : type,
			mail : mail,
			password : password,
		},
		success : function(result, data) {
			console.log("success" + result.login);
			location.href="/main";
		},
		error : function(data) {
			alert("비밀번호가 일치하지 않습니다.");
		}
	});
});
</script>
</html>