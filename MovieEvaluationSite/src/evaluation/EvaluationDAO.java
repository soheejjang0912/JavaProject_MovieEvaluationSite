package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
			return pstmt.executeUpdate(); //성공시 1 반환
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn != null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try{if(pstmt != null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try{if(rs != null)rs.close();}catch (Exception e) {e.printStackTrace();}
		}
		return -1; //데이터 베이스 오류
	}
}
