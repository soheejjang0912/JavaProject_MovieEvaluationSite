package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class ex_DatabaseUtil { 

	public static Connection getConnection() { //�ٸ� ���̺귯�������� ����� �� �ְ� static dao ���� ��밡��
		try {
			String dbURL = "jdbc:mysql://localhost:3306/TUTORIAL?serverTimezone=Asia/Seoul&useSSL=false";
			String dbID = "root"; //�ְ� ���� id�� �α��� �� �� �ְ�
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null; //���� �߻��� null
	}
}
