package user;

public class ex_UserDTO { 
	//������ �����Ҷ����� dto, dao����
	//��Ű�� ���� ������ ���� �����
	//jsp���α׷� �ȿ��� �ϳ��� ������ ������ ������� ��ü
	//�������� �����ߴ� �״�� �־��ش�
	
	String userID;
	String userPassword;
	
	public String getUserID() { //������ ������ ������
		return userID;
	}
	public void setUserID(String userID) { //�����͸� �����
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	
}
