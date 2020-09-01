package user;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.ex_DatabaseUtil;

public class ex_prac_UserDAO {
	//실질적으로 데베와 연동되는, 내용을 기록하고 가져오는 역할을 함
	//데이터 접근 객체
	
	public int join(String userID, String userPassword) {
		String SQL = "INSERT INTO USER VALUES (?, ?)";
		try {
			Connection conn = ex_DatabaseUtil.getConnection();
			//PreparedStatement는 물음표에 내용을 넣어 줌
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			return pstmt.executeUpdate(); //명령어를 수행한 결과 반환 /인서트 구문을 실행해서 나온 결과를 반환
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
}
