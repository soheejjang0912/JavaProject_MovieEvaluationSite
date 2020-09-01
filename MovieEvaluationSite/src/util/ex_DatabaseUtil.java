package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class ex_DatabaseUtil { 

	public static Connection getConnection() { //다른 라이브러리에서도 사용할 수 있게 static dao 에서 사용가능
		try {
			String dbURL = "jdbc:mysql://localhost:3306/TUTORIAL?serverTimezone=Asia/Seoul&useSSL=false";
			String dbID = "root"; //최고 권한 id로 로그인 할 수 있게
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null; //오류 발생시 null
	}
}
