<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%--
    웹 디자인! 프레임 워크를 이용하여 개발한다! 
    1.부트스트랩 : 대표적인 css 프로그램 (CSS,JS - WebContent)
    			프레임 워크이다. 틀이라고 생각하기! 
    		   - css : html이 실제 표시되는 방법(색, 크기, 폰트, 레이아웃..)을 지정하여 꾸며주는 정적언어로 시간적인 표현을 담당.
    		   - js  : 콘텐츠를 바꾸고 움직이는 등 페이지를 동적으로 활성화 시켜주는 역할을 하는 프로그래밍 언어로 웹의 동적 처리를 담당.   
    2.jQuery : 부트스트랩 사용하기 위한 라이브러리가 필요한데 그 중 하나(WebContent-js)
    3.custom.css : 프레임워크의 기본정의를 바꾸고 싶을 때   
--%>

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
	
	<%
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

	%>
		<%-- nav : 메뉴바 네비게이션 바 --%>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="index.jsp">주말엔 명화</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<%-- #navbar가 보였다가 안보였다가 할 수 있게 (작은 화면일때 메뉴버튼 나오게) --%>		
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collaspse navbar-collapse" id="navbar" >
				<ul class = "navbar-nav mr-auto"> <%--목록을 가지는 요소--%>
					<li class = "nav-item active"> <%--목록에 들어가는 요소들--%>
						<a class = "nav-link" href="index.jsp">메인</a> <%-- 특정한 링크로 보내줌 --%>
					</li>
					
					<li class = "nav-item dropdown"> <%-- 아래로 목록나오는 버튼 --%>
						<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
							회원관리
						</a>
						<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID == null) {
%>						
							<a class="dropdown-item" href="userLogin.jsp">로그인</a>
							<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	}else{
%>							
							<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>			
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
			<div class ="alert alert-warning mt-4" role="alert">
				이메일 주소 인증을 하셔야 이용 가능합니다. 인증 메일을 받지 못하셨나요?
			</div>
			<a href="emailSendAction.jsp" class="btn btn-primary">인증메일 다시받기</a>
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