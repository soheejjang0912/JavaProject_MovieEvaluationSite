package user;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.ex_DatabaseUtil;

public class ex_prac_UserDAO {
	//���������� ������ �����Ǵ�, ������ ����ϰ� �������� ������ ��
	//������ ���� ��ü
	
	public int join(String userID, String userPassword) {
		String SQL = "INSERT INTO USER VALUES (?, ?)";
		try {
			Connection conn = ex_DatabaseUtil.getConnection();
			//PreparedStatement�� ����ǥ�� ������ �־� ��
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			return pstmt.executeUpdate(); //��ɾ ������ ��� ��ȯ /�μ�Ʈ ������ �����ؼ� ���� ����� ��ȯ
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
}
