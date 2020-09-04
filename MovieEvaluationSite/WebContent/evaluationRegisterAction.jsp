<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return; 
	}
	 
	String movieName = null;
	String directorName = null;
	int movieYear = 0;
	String seasonDivide = null;
	String movieDivide = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	String totalScore = null;
	String storyScore = null;
	String visualScore = null;
	String actingScore = null;
	 
	if(request.getParameter("movieName") != ""){
		movieName = request.getParameter("movieName");
	}
	if(request.getParameter("directorName") != ""){
		directorName = request.getParameter("directorName");
	}
	if(request.getParameter("movieYear") != ""){
		try{
			movieYear = Integer.parseInt(request.getParameter("movieYear"));
		}catch (Exception e){
			System.out.println("강의 연도 데이터 오류");
		}
	}
	if(request.getParameter("seasonDivide") != ""){
		seasonDivide = request.getParameter("seasonDivide");
	}
	if(request.getParameter("movieDivide") != ""){
		movieDivide = request.getParameter("movieDivide");
	}
	if(request.getParameter("evaluationTitle") != ""){
		evaluationTitle = request.getParameter("evaluationTitle");
	}
	if(request.getParameter("evaluationContent") != ""){
		evaluationContent = request.getParameter("evaluationContent");
	}
	if(request.getParameter("totalScore") != ""){
		totalScore = request.getParameter("totalScore");
	}
	if(request.getParameter("storyScore") != ""){
		storyScore = request.getParameter("storyScore");
	}
	if(request.getParameter("visualScore") != ""){
		visualScore = request.getParameter("visualScore");
	}
	if(request.getParameter("actingScore") != ""){
		actingScore = request.getParameter("actingScore");
	}
	
	if(movieName == null || directorName == null || movieYear == 0 || seasonDivide == null || movieDivide == null || evaluationTitle == null || evaluationContent == null || totalScore == null || storyScore == null || visualScore == null || actingScore == null ||
			evaluationTitle.equals("") || evaluationContent.equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	
	int result = evaluationDAO.write(new EvaluationDTO(0, userID,
			movieName, directorName, movieYear, seasonDivide, movieDivide, 
			evaluationTitle, evaluationContent, totalScore, storyScore, 
			visualScore, actingScore, 0));
	
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('등록 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else{
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('등록에 성공했습니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return; 
	}
%>