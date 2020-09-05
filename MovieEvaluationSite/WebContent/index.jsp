<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
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
		//검색엔진
		request.setCharacterEncoding("UTF-8");
		String movieDivide = "전체";
		String searchType = "최신순";
		String search = "";
		int pageNumber = 0;
		
		if(request.getParameter("movieDivide") != null){
			movieDivide = request.getParameter("movieDivide");
		}
		if(request.getParameter("searchType") != null){
			searchType = request.getParameter("searchType");
		}
		if(request.getParameter("search") != null){
			search = request.getParameter("search");
		}
		if(request.getParameter("pageNumber") != null){
			try{
				pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
			}catch(Exception e){
				System.out.println("검색 페이지 번호 오류");
			}
		}
		
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
		boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
		if (emailChecked == false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'emailSendConfirm.jsp';");
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
				
				<!-- 미니 검색 엔진 -->
				<form action="./index.jsp" method ="get" class = "form-inline my-2 my-lg-0"> <%-- 검색창 만들기 --%>
					<input type="text" name="search" class="form-control mr-sm2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" type = "submit">검색</button>
				</form>
				
			</div>
		</nav>
		
		<%-- 본문 section --%>
		<section class="container"> <%--컨테이너는 반응형으로 특정한 요소가 알아서 작아지는데 도움을 줌--%>
			<%--어떤 내용을 서버로 전달할 수 있도록! //검색창 만드는것임--%>
			<form method="get" action="./index.jsp" class="form-inline mt-3">
				<select name ="movieDivide" class="form-control mx-1 mt-2">
					<option value="전체">전체</option>
					<option value="한국영화" <% if(movieDivide.equals("한국영화")) out.println("selected"); %>>한국영화</option>
					<option value="외국영화" <% if(movieDivide.equals("외국영화")) out.println("selected"); %>>외국영화</option>
					<option value="기타" <% if(movieDivide.equals("기타")) out.println("selected"); %>>기타</option>
				</select>
				
				<select name ="searchType" class="form-control mx-1 mt-2">
					<option value="최신순">최신순</option>
					<option value="추천순" <% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
				</select>
				
				<%-- 사용자 검색 가능하게 --%>
				<input type ="text" name = "search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요." >
				<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
				<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
				<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
			</form>
		
<%
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(movieDivide, searchType, search, pageNumber);
	if(evaluationList != null){
		for(int i = 0; i< evaluationList.size(); i++){ //다음페이지로 넘어가기 위해서 6까지 가져옴
			if(i==5) break;
			EvaluationDTO evaluation = evaluationList.get(i);
	
%>
			
			<!-- 카드 강의평가를 등록해씅ㄹ떄 어떻게 출력이 될지  -->
			<div class="card bg-light mt-3"><!-- 위쪽으로 3 여백 -->
				<div class="card-header bg-light">
					<div class="row">
						<div class="col-8 text-left"><%= evaluation.getMovieName() %>&nbsp;<small><%= evaluation.getDirectorName() %></small></div>
						<div class="col-4 text-right">종합 <span style="color: red;"><%= evaluation.getTotalScore() %></span></div>
					</div>
				</div>
			
			
				<div class="card-body">
					<h5 class="card-title">
						<%= evaluation.getEvaluationTitle() %>&nbsp;<small><%= evaluation.getMovieDivide() %></small>
					</h5>
					<p class="cart-text"><%= evaluation.getEvaluationContent() %></p>
					<div class="row">
						<div class="col-9 text-left">
							스토리<span style="color : red;"><%= evaluation.getStoryScore()%></span>
							영상미<span style="color : red;"><%= evaluation.getVisualScore()%></span>
							연기<span style="color : red;"><%= evaluation.getActingScore()%></span>
							<span style="color: green;">(추천:<%= evaluation.getLikeCount()%>)</span>
						</div>
						
						<div class="col-3 text-right">
							<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
							<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
						
						</div>
					
					</div>		
				</div>
			</div>	
<%
		}
	}
%>
		</section>
		
		<!-- 페이지 처리 -->
		<ul class="pagination justify-content-center mt-3">
			<li class="page-item">		
<%
	if(pageNumber <= 0){
%>
	<a class="page-link disabled">이전</a>
<%
	}else{
%>
	<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(movieDivide, "UTF-8") %>
	&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8")%>
	&pageNunber=<%= pageNumber - 1 %>">이전</a>
<%
	}
%> 
			</li>
	 		
	 		<li>
<%
	if(evaluationList.size() < 6){
%>
	<a class="page-link disabled">다음</a>
<%
	}else{
%>
	<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(movieDivide, "UTF-8") %>
	&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8")%>
	&pageNunber=<%= pageNumber + 1 %>">다음</a>
<%
	}
%> 
	 		
	 		</li>
		
		</ul>
	
		
		<!-- 등록하기 버튼을 눌렀을 때 모달정의하기 -->
		<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelleby="modal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal">평가 등록</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
						<form action="./evaluationRegisterAction.jsp" method ="post">
							<div class="form-row"> <%-- 하나의 행을 여러개로 나눌 때 --%>
								<div class="form-group col-sm-6"> <%-- 일반적으로 하나의 행은 16열 --%>
									<label>영화 이름</label>
									<input type="text" name="movieName" class="form-control" maxlengh="20">
								</div>
								<div class="form-group col-sm-6">
									<label>감독명</label>
									<input type="text" name="directorName" class="form-control" maxlengh="20">
								</div>
							</div>
							
							<div class="form-row">
								<div class="form-group col-sm-4">
									<label>개봉 연도</label>
									<select name="movieYear" class="form-control">
										<option value="2010">2010</option>
										<option value="2011">2011</option>
										<option value="2012">2012</option>
										<option value="2013">2013</option>
										<option value="2014">2014</option>
										<option value="2015">2015</option>
										<option value="2016">2016</option>
										<option value="2017">2017</option>
										<option value="2018">2018</option>
										<option value="2019">2019</option>
										<option value="2020" selected>2020</option>
									</select>
								</div>
							
								<div class="form-group col-sm-4">
									<label>분기</label>
									<select name="seasonDivide" class="form-control">
										<option value="1분기" selected>1분기</option>
										<option value="2분기">2분기</option>
										<option value="3분기">3분기</option>
										<option value="4분기">4분기</option>
									</select>
								</div>
								
								<div class="form-group col-sm-4">
									<label>영화 장르</label>
									<select name="movieDivide" class="form-control">
										<option value="한국영화" selected>한국영화</option>
										<option value="외국영화">외국영화</option>
										<option value="기타">기타</option>
									</select>
								</div> 
							</div>
							
							<div class="form-group">
								<label>제목</label>
								<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
							</div>
							<div class="form-group">
								<label>내용</label>
								<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
							</div>
							
							<div class ="form-row"><%-- 하나의 행을 여러개로 나눌 때 --%>
								<div class ="form-grop col-sm">
									<label>종합</label>
									<select name="totalScore" class="form-control">
										<option value="A" selected>A</option>
										<option value="B">B</option>
										<option value="C">C</option>
										<option value="D">D</option>
										<option value="F">F</option>
									</select>
								</div>
								
								<div class ="form-grop col-sm">
									<label>스토리</label>
									<select name="storyScore" class="form-control">
										<option value="A" selected>A</option>
										<option value="B">B</option>
										<option value="C">C</option>
										<option value="D">D</option>
										<option value="F">F</option>
									</select>
								</div>
								
								<div class ="form-grop col-sm">
									<label>영상미</label>
									<select name="visualScore" class="form-control">
										<option value="A" selected>A</option>
										<option value="B">B</option>
										<option value="C">C</option>
										<option value="D">D</option>
										<option value="F">F</option>
									</select>
								</div>
								
								<div class ="form-grop col-sm">
									<label>연기</label>
									<select name="actingScore" class="form-control">
										<option value="A" selected>A</option>
										<option value="B">B</option>
										<option value="C">C</option>
										<option value="D">D</option>
										<option value="F">F</option>
									</select>
								</div>
								
							</div>
							
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-primary">등록하기</button>
								
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>				
									
		<!-- 신고하기 버튼을 눌렀을 때 모달정의하기 -->
		<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelleby="modal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal"> 신고하기</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class = "modal-body">
						<form action="./reportAction.jsp" method ="post">
							<div class="form-group">
								<label>신고 제목</label>
								<input type="text" name="reportTitle" class="form-control" maxlength="30">
							</div>
							<div class="form-group">
								<label>신고내용</label>
								<textarea name="reportContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
							</div>
							
							
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-danger">신고하기</button>
								
							</div>
							
						</form>
					</div>
				</div>
			</div>
		</div>
		
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