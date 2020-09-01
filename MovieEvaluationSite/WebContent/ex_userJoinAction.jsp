<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.ex_UserDTO"%> <%-- jsp임포트 방법 --%>
<%@ page import="user.ex_prac_UserDAO"%>
<%@ page import="java.io.PrintWriter"%>  <%-- 자바스크립트 출력 --%>
<%
	request.setCharacterEncoding("UTF-8");//사용자가 보낸 데이터를 위의 형식으로 받아온다
	//받아온 데이터 정의
	String userID = null;
	String userPassword = null;
	if(request.getParameter("userID") != null){//사용자에게 받응 유저 아이디가 존재 하면 데이터가 들어갈 수 있게 해줌
		userID = (String) request.getParameter("userID");
	}if(request.getParameter("userPassword") != null){
		userPassword = (String) request.getParameter("userPassword");
	}
	if(userID == null || userPassword == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();"); //사용자를 원래 화면으로 돌려보냄
		script.println("</script>");
		script.close();
		return;
	}
	//데이터를 잘 입력했을 경우
	ex_prac_UserDAO userDAO = new ex_prac_UserDAO(); //데베와 연동될 수 있게
	int result = userDAO.join(userID, userPassword);
	if (result ==1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원가입에 성공했습니다.');");
		script.println("location.href = 'index.jsp';"); 
		script.println("</script>");
		script.close();
		return;	
	}
%>