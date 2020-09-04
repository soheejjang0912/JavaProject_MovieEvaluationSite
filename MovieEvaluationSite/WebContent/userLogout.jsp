<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	session.invalidate();//클라이언트의 세션정보 모두 파기
%>

<script>
	location.href = 'index.jsp';
</script>