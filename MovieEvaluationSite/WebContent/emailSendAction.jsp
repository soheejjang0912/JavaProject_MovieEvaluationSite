<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport"%> <!-- mail관련 사용하기 위함 -->
<%@ page import="javax.mail.Message"%> 
<%@ page import="javax.mail.Address"%> 
<%@ page import="javax.mail.internet.InternetAddress"%> 
<%@ page import="javax.mail.internet.MimeMessage"%> 
<%@ page import="javax.mail.Session"%> 
<%@ page import="javax.mail.Authenticator"%> 
<%@ page import="java.util.Properties"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.Gmail"%>
<%@ page import="java.io.PrintWriter"%>

<%

	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null){ //세션값이 유효한 상태일 때
		userID = (String) session.getAttribute("userID");//해당하는 세션값 넣어줌
	}
	if(userID == null){//로그인이 안되어있는 상태일 때
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if(emailChecked == true ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 인증 된 회원입니다.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");  
		script.close();
		return;
	}
	
	String host = "http://localhost:8080/MovieEvaluationSite/";
	String from = "codingsohee@gmail.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "주말엔 명화 가입을 위한 이메일 인증 메일입니다!";
	String content = "다음 링크에 접속하여 이메일 인증을 진행하세요." +
		"<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";
	
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	
	
	try{
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF8");
		Transport.send(msg);
	} catch (Exception e){
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	
%>



<!doctype html>

<html>

	<head>  <%-- 일반적으로 헤드 태그에는 css가 들어간다. --%>
		<title>주말엔 명화</title>
		
		<meta http-equiv="Conten-Type" content="text/html; charset=UTF-8">
		<%-- 부트스트랩은 기본적으로 반응형 웹, 모바일ㅡ 데탑으로 봤을때 디자인을 알아서 처리해주는 반응형 웹 프로그램이기 때문에 뷰포트 설정해준다--%>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">	

		<!-- 부트스트랩  css 추가하기  -->
		<link rel="stylesheet" href="./css/bootstrap.min.css">
		<!-- 커스텀  css 추가하기  -->
		<link rel="stylesheet" href="./css/custom.css">
	</head>
	
	<body>
		<%-- nav : 메뉴바 네비게이션 바 --%>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="index.jsp">주말엔 명화</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<%-- #navbar가 보였다가 안보였다가 할 수 있게 (작은 화면일때 메뉴버튼 나오게) --%>		
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collaspse navbar-collapse" id="navbar" >
				<ul class = "navbar-nav mr-auto"> <%--목록을 가지는 요소--%>
					<li class = "nav-item"> <%--목록에 들어가는 요소들--%>
						<a class = "nav-link" href="index.jsp">메인</a> <%-- 특정한 링크로 보내줌 --%>
					</li>
					
					<li class = "nav-item dropdown"> <%-- 아래로 목록나오는 버튼 --%>
						<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
							회원관리
						</a>
						<div class="dropdown-menu" aria-labelledby="dropdown">
							<a class="dropdown-item" href="userLogin.jsp">로그인</a>
							<a class="dropdown-item active" href="userJoin.jsp">회원가입</a>
							<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
						</div>
					</li>	
				</ul>
				
				<form class = "form-inline my-2 my-lg-0"> <%-- 검색창 만들기 --%>
					<input class="form-control mr-sm2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" type = "submit">검색</button>
				</form>
				
			</div>
		</nav>
		
		
		
<%-- 본문 section --%>
		<section class="container mt-4" style="max-width: 560px;"> <%--컨테이너는 반응형으로 특정한 요소가 알아서 작아지는데 도움을 줌--%>
				<div class="alert alert-success mt-4" role="alert">
					이메일 주소 인증 메일이 전송되었습니다. 회원가입시 입력했던 이메일에 들어가서 인증해주세요
				</div>
		</section>
<%-- 본문 section --%>	
		
		
		<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;"><!-- 웹사이트를 개발자가 회사의 정보 출력 -->
			Copyright &copy; SOHEEJJANG0912 All Rights Reserved.
		</footer>
		
		<!-- 제이쿼리 자바스크립트 추가하기  -->
		<script src="./js/jquery.min.js"></script>
		<!-- 파퍼 자바스크립트 추가하기  -->
		<script src="./js/pooper.js"></script>
		<!-- 부트스트랩 자바스크립트 추가하기  -->
		<script src="./js/bootstrap.min.js"></script>
	</body>
</html>