package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	//���� ���� ,���� �Լ�����
	//���������� ������ �����Ǵ�, ������ ����ϰ� �������� ������ ��
	
//�α���
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID=?"; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //Ư���� ������ ������ ���Ŀ� ���� ����� ó���ϱ� ����
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) { //next �� ����Ʈ�� �������� ����� 1�྿ �Ѱܼ� �������� ������  true, ������ false
				if(rs.getString(1).equals(userPassword)) {
					return 1; //�α��� ����
				}else {
					return 0; //��й�ȣ Ʋ��
				}
			}
			return -1; //���̵� ����
		}catch(Exception e) {
			e.printStackTrace();
		}finally { //���� ���� ���Ŀ��� ������ �ڿ����� ���� ���������μ� ������ ������ ���� �ʰ� ���־����
			try{if(conn != null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)rs.close();}catch (Exception e) {e.printStackTrace();}
		}
		return -2; //������ ���̽� ����
	}
	
	
	
	
//ȸ������
	public int join(UserDTO user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, false)"; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //Ư���� ������ ������ ���Ŀ� ���� ����� ó���ϱ� ����
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			return pstmt.executeUpdate(); 
		}catch(Exception e) {
			e.printStackTrace();
		}finally { //���� ���� ���Ŀ��� ������ �ڿ����� ���� ���������μ� ������ ������ ���� �ʰ� ���־����
			try{if(conn != null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)rs.close();}catch (Exception e) {e.printStackTrace();}
		}
		return -1; //ȸ������ ���� /���̵� �ߺ�..
	}
	
//Ư�� ȸ���� �̸��� ��ü�� ��ȯ���ִ� �Լ�
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM USER WHERE userID = ?"; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //Ư���� ������ ������ ���Ŀ� ���� ����� ó���ϱ� ����
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally { //���� ���� ���Ŀ��� ������ �ڿ����� ���� ���������μ� ������ ������ ���� �ʰ� ���־����
			try{if(conn != null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)rs.close();}catch (Exception e) {e.printStackTrace();}
		}
		return null; //�����ͺ��̽� ����
	}
	
	
//�̸��� ����	
	public boolean getUserEmailChecked(String userID) {
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?"; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //Ư���� ������ ������ ���Ŀ� ���� ����� ó���ϱ� ����
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getBoolean(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally { //���� ���� ���Ŀ��� ������ �ڿ����� ���� ���������μ� ������ ������ ���� �ʰ� ���־����
			try{if(conn != null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)rs.close();}catch (Exception e) {e.printStackTrace();}
		}
		return false;
	}
	
	
//�̸��� ���� ���ִ� �Լ�	
	public boolean setUserEmailChecked(String userID) {
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?"; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //Ư���� ������ ������ ���Ŀ� ���� ����� ó���ϱ� ����
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally { //���� ���� ���Ŀ��� ������ �ڿ����� ���� ���������μ� ������ ������ ���� �ʰ� ���־����
			try{if(conn != null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)rs.close();}catch (Exception e) {e.printStackTrace();}
		}
		return false; 
	}


}
