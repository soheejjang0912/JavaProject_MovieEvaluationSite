<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>첫 번쨰 페이지</title>
</head>
<body>
	hello
	<form action="./userJoinAction.jsp" method="post">
	<%-- 포스트는 외부에 데이터가 노출되지않는 방식 , 보안성 뛰어남 --%>	
		<input type = "text" name = "userID">
		<input type = "password" name = "userPassword">
		<input type = "submit" value = "회원가입">
	</form>
</body>
</html>