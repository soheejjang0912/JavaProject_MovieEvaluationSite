package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {

	public int write(EvaluationDTO evaluationDTO) {
		String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationDTO.getUserID());
			pstmt.setString(2, evaluationDTO.getMovieName());
			pstmt.setString(3, evaluationDTO.getDirectorName());
			pstmt.setInt(4, evaluationDTO.getMovieYear());
			pstmt.setString(5, evaluationDTO.getSeasonDivide());
			pstmt.setString(6, evaluationDTO.getMovieDivide());
			pstmt.setString(7, evaluationDTO.getEvaluationTitle());
			pstmt.setString(8, evaluationDTO.getEvaluationContent());
			pstmt.setString(9, evaluationDTO.getTotalScore());
			pstmt.setString(10, evaluationDTO.getStoryScore());
			pstmt.setString(11, evaluationDTO.getVisualScore());
			pstmt.setString(12, evaluationDTO.getActingScore());
			return pstmt.executeUpdate(); //������ 1 ��ȯ
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn != null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)rs.close();}catch (Exception e) {e.printStackTrace();}
		}
		return -1; //������ ���̽� ����
	}
	
//�˻����� ��ȯ
	public ArrayList<EvaluationDTO> getList (String movieDivide, String searchType, String search, int pageNumber){
		if(movieDivide.equals("��ü")) {
			movieDivide = "";
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		String SQL = ""; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; //Ư���� ������ ������ ���Ŀ� ���� ����� ó���ϱ� ����
		try {
			if(searchType.equals("�ֽż�")) {
				SQL = "SELECT * FROM EVALUATION WHERE movieDivide LIKE ? AND "
						+ "CONCAT(movieName, directorName, evaluationTitle, evaluationContent)"
						+ "LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + "," + pageNumber * 5 + 6;
			}else if(searchType.equals("��õ��")) {
				SQL = "SELECT * FROM EVALUATION WHERE movieDivide LIKE ? AND "
						+ "CONCAT(movieName, directorName, evaluationTitle, evaluationContent)"
						+ "LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + "," + pageNumber * 5 + 6;
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + movieDivide + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			while(rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14) //�ڷ����� �߸��ᵵ ��ü�� �������� �����Ұ�!
				);
				evaluationList.add(evaluation);
			} 
		}catch(Exception e) {
			e.printStackTrace();
		}finally { //���� ���� ���Ŀ��� ������ �ڿ����� ���� ���������μ� ������ ������ ���� �ʰ� ���־����
			try{if(conn != null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)rs.close();}catch (Exception e) {e.printStackTrace();}
		}
		return evaluationList;
	}
	
}
