<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
	<meta charset="UTF-8">
	<title>LOGIN PAGE</title>
	</head>
	<h1>로그인</h1>
		<body>
		  <input type = "text" name="id" placeholder="아이디(이메일)"><br/>
		  <input type = "password" name="password" placeholder="password"><br/>
		  <p>
		  	<input value="로그인" type="submit" name="login">
		  </p>
		  <form>
		  	<input type="button" value="뒤로가기" onclick="history.back()">
		  </form>
		</body>
</html>