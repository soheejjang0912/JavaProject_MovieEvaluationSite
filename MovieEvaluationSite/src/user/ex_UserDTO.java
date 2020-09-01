package user;

public class ex_UserDTO { 
	//데베와 연동할때에는 dto, dao만듬
	//패키지 명은 데베와 같이 만든다
	//jsp프로그램 안에서 하나의 데이터 단위를 담기위한 객체
	//데베에서 정의했던 그대로 넣어준다
	
	String userID;
	String userPassword;
	
	public String getUserID() { //현재의 데이터 가져옴
		return userID;
	}
	public void setUserID(String userID) { //데이터를 기록함
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	
}
