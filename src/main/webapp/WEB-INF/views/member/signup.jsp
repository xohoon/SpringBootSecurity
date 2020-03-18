<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IEH 회원가입 페이지</title>
</head>
<body>
<h3>회원가입</h3>
<!-- 
<input type="checkbox" style="width:30px; height: 30px; border:2px solid #fff; border-radius:4px;  no-repeat; -webkit-appearance: none; cursor: pointer; background-color:rgba(0,0,0,.2);">
<input type="checkbox" checked="checked" style="width: 30px; height: 30px; border:2px solid #fff; border-radius:4px; no-repeat; -webkit-appearance: none; cursor: pointer; background-color:rgba(0,0,0,.2); background: url(../../images/checked.png)no-repeat; background-size:100% 100%;">
 -->
<div id="join_form" style="width:535px">
	회원님의 타입을 정해주세요 <input type="radio" id="type1" name="type" value="1">고용인
   	<input type="radio" id="type2" name="type" value="2">구직인
   <input type="hidden" id="secretCode">
   <input type="text" id="name" placeholder="이름" class="form-control" style="width:300px;"><br>
   <input type="email" id="mail" placeholder="인증받을 이메일" class="form-control" style="width:300px; float:left;">
   <input type="button" id="send_mail" value="발송 및 중복확인" class="btn btn-success" style="float:left;"><br>
   <input type="text" id="mailCode" placeholder="인증번호" class="form-control" style="width:300px; float:left;">
   <input type="button" id="mailCodeBtn" value="인증" class="btn btn-info" style="float:left;"><br>
   <input type="checkbox" id="CodeCheck" onclick="return false;" style="margin: -12px 0 0 10px;">
<br>
   <input type="password" id="password"  placeholder="비밀번호" class="form-control" style="width:300px;"><br>
   <input type="password" id="password2"  placeholder="비밀번호 확인" class="form-control" style="width:300px;">
   <font id="pin_check" size="2" color="red"></font><br>
   <input type="text" id="phone" placeholder="휴대폰 번호" max="99999999999" maxlength="11" class="form-control" onkeyup="SetNum(this);" style="width:300px;"><br>
   <input type="button" id="joinBtn" value="가입하기" class="btn btn-primary">
</div>
</body>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- jquery & bootstrap js -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/static/js/jquery-3.1.1.min.js"></script>
<!-- 
<script type="text/javascript" src="/static/js/member/signup.js"></script>
 -->
 
<script>
$(document).ready(function() {
	console.log("jspFile?");
	pass_key();
});
var mail_reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
var password_reg = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
var blank_reg = new RegExp('\\s');
var mailCode1 = "";
var mailCode2 = "";

// 공백 및 null 값 확인
function isNullOrBlank(value) {
	if (typeof value == "undefined" || value == null || value == "" || blank_reg.test(value)) {
		return true;
	} else {
		return false;
	}
}

// 숫자만 입력가능
function SetNum(obj) {
	val = obj.value;
	re=/[^0-9]/gi;
	obj.value = val.replace(re,"");
}

$('#send_mail').on('click', function() {
	var mail = $('#mail').val();
	console.log(">>??"+mail);
	if(isNullOrBlank(mail)) {
		alert("이메일은 공백을 포함할 수 없습니다.");
		return false;
	}else if(mail_reg.test(mail) == false) {
		alert("올바른 이메일 형식이 아닙니다. 확인해 주세요.");
		return false;
	}else {
		alert("인증번호가 전송되었습니다. 잠시만 기다려주세요.");
	}
	$.ajax({
		type : 'POST',
		url : '/member/mailSend',
		dataType : "JSON",
		data : {
			mail : mail
		},
		success : function(result, data) {
			if(String(result.check) == "overlap") {
				alert('중복된 이메일입니다.');
			}else {
				var mailCode1 = String(result.check);
				console.log(">>인증번호" + mailCode1);
				$('#secretCode').val(mailCode1);
				alert('메일로 인증번호가 전송되었습니다.');	
			}
		},
		error : function(data) {
			console.log("error" + data);
		}
	});
});

$('#mailCodeBtn').on('click', function() {
	var mail = $('#mail').val();
	mailCode2 = $('#mailCode').val();
	mailCode1 = $('#secretCode').val();
 	if(mailCode1 != "" && mailCode1 == mailCode2) {
		alert("인증이 완료되었습니다.");
		$("#CodeCheck").prop("checked", true);
	}else {
		alert("인증번호를 다시 확인해주세요.");
	}
	
});

function pass_key() {
	$("#password2").keyup(function() {
		var pw1 = $('#password').val();
		var pw2 = $('#password2').val();
		if(pw1 == pw2) {
			$('#pin_check').text('');
			$('#pin_check').html("일치");
			document.getElementById("pin_check").setAttribute("color", "blue");
		}else {
			$('#pin_check').text('');
			$('#pin_check').html("불일치");
			document.getElementById("pin_check").setAttribute("color", "red");
		}
	});
}
/*
 * 2차 비밀번호 설정시 Code
function sec_pass_key() {
	$("#second_password2").keyup(function() {
		var pw1 = $('#second_password').val();
		var pw2 = $('#second_password2').val();
		if(pw1 == pw2) {
			$('#pin_check2').text('');
			$('#pin_check2').html("일치");
			document.getElementById("pin_check2").setAttribute("color", "blue");
		}else {
			$('#pin_check2').text('');
			$('#pin_check2').html("불일치");
			document.getElementById("pin_check2").setAttribute("color", "red");
		}
	});
}
*/
$('#joinBtn').on('click', function() {
	var name = $('#name').val();
	var mail = $('#mail').val();
	var password = $('#password').val();
	var phone = $('#phone').val();
	var type = $(':radio[name="type"]:checked').val();
	type = Number(type);
	if(!type) {
		alert("회원님의 타입을 선택해 주세요");
		return false;
	}else if(!name) {
		alert("이름을 입력해주세요");
		return false;
	}else if($("input:checkbox[id='CodeCheck']").is(":checked") == false) {
		alert("메일 인증을  완료해주세요.");
		return false;
	}else if(isNullOrBlank(password)) {
		alert("비밀번호는 공백을 포함 할 수 없습니다.");
		return false;
	}
	/* 
	else if(password_reg.test(password) == false) {
		alert('비밀번호는 영문,숫자,특수문자 각 최소 1자 이상 8~15 자 입니다.');
		return false;
	}
	 */
	else if($('#pin_check').text() != "일치"){
		console.log("conde"+$('#pin_check').text());
		alert("비밀번호를 일치시켜주세요");
		return false;
	}else if(isNullOrBlank(phone)) {
		alert("휴대전화 번호는 -기호 없이 나란히 입력해주세요.");
		return false;
	}else if(phone.length != 11) {
		alert("휴대전화번호를 총 11자리입니다.");
		return false;
	}else {
		console.log(type+">>"+name+">>"+mail+">>"+password+">>"+phone);
		$.ajax({
			type : 'POST',
			url : '/member/signup',
			dataType : "JSON",
			data : {
				type : type,
				name : name,
				mail : mail,
				password : password,
				phone : phone
			},
			success : function(result, data) {
				console.log("success" + result.url);
				location.href="/main";
			},
			error : function(data) {
				console.log("error");
			}
		});
	}
});
</script>
</html>