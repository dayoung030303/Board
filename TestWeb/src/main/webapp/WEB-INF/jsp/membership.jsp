<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
	<meta charset="UTF-8">
	<title>MEMBERSHIP PAGE</title>
	</head>
	<h1>회원가입</h1>
		<body>
		  <input type = "text" name="id" placeholder="아이디(이메일)"><br/>
		  <input type = "password" name="password" placeholder="password"><br/>
		  <input type = "password" name="password확인" placeholder="password확인"><br/>
		  <p>
		  	<input value="회원가입" type="submit" name="login">
		  </p>
		  <form>
		 	<input type="button" value="뒤로가기" onclick="history.back()">
		  </form>
		</body>
</html>