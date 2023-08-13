package com.example.project.util;

import java.security.MessageDigest;

public class Util {

	public static boolean empty(Object obj) {

		if (obj == null) {
			return true;
		}

		String str = (String) obj;
		
		return str.trim().length() == 0; // = false -> null이 아닌데(길이가 있는데) 0이랑 같다고 비교했으니까.
	}

	public static String f(String format, Object... args) {
		return String.format(format, args);
	}

	//alert창으로 msg 띄어주고, 뒤로가기.
	public static String jsHistoryBack(String msg) {

		if (msg == null) {
			msg = "";
		}

		return Util.f("""
						<script>
							const msg = '%s'.trim();
							if (msg.length > 0) {
								alert(msg);
							}
							history.back();
						</script>
					""", msg);
	}

	//alert창으로 msg 띄어주고, 전달받은 uri 주소로 보내주기.
	public static String jsReplace(String msg, String uri) {

		if (msg == null) {
			msg = "";
		}

		if (uri == null) {
			uri = "";
		}

		return Util.f("""
						<script>
							const msg = '%s'.trim();
							if (msg.length > 0) {
								alert(msg);
							}
							location.replace('%s');
						</script>
					""", msg, uri);
	}
	
	//암호화.
	public static String sha256(String originalPw) {

		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(originalPw.getBytes("UTF-8"));
			StringBuffer hexString = new StringBuffer();

			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}

			return hexString.toString();

		} catch (Exception ex) {
			return "";
		}
	}
	//임시 비밀번호
	public static String getTempPassword(int length) {
		int index = 0;
		char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f',
				'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };

		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < length; i++) {
			index = (int) (charArr.length * Math.random());
			sb.append(charArr[index]);
		}

		return sb.toString();
	}
}
