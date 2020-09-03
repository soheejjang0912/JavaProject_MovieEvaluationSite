package user;

public class UserDTO {
	//userTable�� 1��1��Ī��Ű��
	
	private String userID;
	private String userPassword;
	private String userEmail;
	private String userEmailHash;
	private Boolean userEmailChecked;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserEmailHash() {
		return userEmailHash;
	}
	public void setUserEmailHash(String userEmailHash) {
		this.userEmailHash = userEmailHash;
	}
	public Boolean getUserEmailChecked() {
		return userEmailChecked;
	}
	public void setUserEmailChecked(Boolean userEmailChecked) {
		this.userEmailChecked = userEmailChecked;
	}
	
	public UserDTO() { 
	}
	
	//������ �����
	public UserDTO(String userID, String userPassword, String userEmail, String userEmailHash,
			Boolean userEmailChecked) {
		super();
		this.userID = userID;
		this.userPassword = userPassword;
		this.userEmail = userEmail;
		this.userEmailHash = userEmailHash;
		this.userEmailChecked = userEmailChecked;
	}
	
	
	
}
