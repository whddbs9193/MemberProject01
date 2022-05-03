<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Hammersmith+One&family=Nanum+Gothic&family=Paytone+One&display=swap');
#container{width:450px; margin: 0 auto;}
a{text-decoration: none; color: #6FD262}
/* 상단 - 메인, 서브 타이틀 */
.m_title{font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title{font-family: 'Hammersmith One', sans-serif; font-size: 2em; text-align: center; margin-bottom:30px; color:#6FD262}
/* 중단 - 입력창  */
.f_input{text-align: center; border: 1px solid #ccc; padding: 10px; border-radius: 5px}
.f_input .c_id, .f_input .c_pwd{height: 45px; margin-top: 20px; padding-left: 5px;}
.f_input .f_chk{text-align: left; margin-top: 10px; font-size:0.9em; color: gray;} 
.f_input #btn_login{width: 425px; height: 47px; background: #6FD262; color: white;
font-size: 16px; font-weight: bold; cursor:pointer; margin-top: 25px; margin-bottom:10px; border: 1px solid lightgreen;}
/* 하단 - 비밀번호 찾기, 아이디 찾기, 회원가입 */
.f_a{text-align: center; margin-top: 30px; font-size: 0.9em;}
.f_a a{ color:gray;}
</style>
<script>
	document.addEventListener("DOMContentLoaded",function(){
		let form = document.loginForm;
		
		let btn_login = document.getElementById("btn_login");
		btn_login.addEventListener("click",function(){
			if(!form.id.value){
				alert('아이디를 입력하시오.');
				form.id.focus();
				return;
			}
			if(!form.pwd.value){
				alert('비밀번호를 입력하시오!');
				form.pwd.focus();
				return;
			}
			form.submit();
		})
	})
</script>
</head>
<body>
<div id="container">
	<div class="m_title"><a href="#">EZEN MALL</a></div>
	<div class="s_title">LOGIN</div>
	<form action="memberLoginPro.jsp" method="post" name="loginForm">
		<div class="f_input">
			<div class="f_id"><input type="text" id="id" name="id" class="c_id" placeholder="아이디" size="55"></div>
			<div class="f_pwd"><input type="password" id="pwd" name="pwd" class="c_pwd" placeholder="비밀번호" size="55"></div>
			<div class="f_chk">
				<input type="checkbox" id="chk" class="c_chk" size="55">&nbsp;
				<label for="chk">로그인 상태 유지</label>
			</div>
			<div class="f_submit"><input type="button" value="로그인" id="btn_login"></div>
		</div>
		<div class="f_a">
			<a href="#">비밀번호 찾기</a>&emsp;|&emsp;
			<a href="#">아이디 찾기</a>&emsp;|&emsp;
			<a href="../member/memberJoinForm.jsp">회원가입</a>
		</div>
	</form>
</div>
</body>
</html>