package util;

import java.security.MessageDigest;

public class SHA256 { //회원가입 이후 이메일 인증
	
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256"); //실제로 사용자가 입력한 값을 sha256으로 알고리즘 적용할 수 있도록
			byte[] salt = "HELLO! This is Salt.".getBytes(); //단순히 하면 해커에 의해 해킹 될 수 있어 솔트값 넣어줌
			digest.reset();
			digest.update(salt);
			byte[] chars = digest.digest(input.getBytes("UTF-8"));
			for(int i =0; i < chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) result.append("0");
				result.append(hex);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
	
}
