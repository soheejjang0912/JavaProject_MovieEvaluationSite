<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	//이메일 인증을 하면 그에대한 처리 페이지
	
	request.setCharacterEncoding("UTF-8");
	String code = null; 
	if(request.getParameter("code") != null){
		code = request.getParameter("code");
	}
	UserDAO userDAO = new UserDAO();
	String userID = null; 
	if(session.getAttribute("userID") != null){ //로그인 되어있는지 확인
		 userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	} 
	String userEmail = userDAO.getUserEmail(userID); //사용자의 이메일 주소 가져와서
	boolean isRight = (new SHA256().getSHA256(userEmail).equals(code))?true : false; //사용자의  코드값이 일치한지 체크
	if(isRight == true){
		userDAO.setUserEmailChecked(userID); 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증에 성공했습니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 코드입니다..');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>