package com.idea.platform.tenant.config.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Description:参数校验工具类
 * @author wgg
 * @date: 2019年10月218日 上午9:49:36
 */
public class VerifyUtil {

	public static boolean check(String str, String regex) {
		boolean flag = false;
		try {
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(str);
			flag = matcher.matches();
		} catch (Exception e) {
			flag = false;
		}
		return flag;

	}

	/**
	 * 手机号规则校验
	 * @param phone
	 * @return
	 */
	public static boolean checkPhone(String phone) {
		String regex = "^((13[0-9])|(14[5,7,9])|(15([0-3]|[5-9]))|(166)|(17[0,1,3,5,6,7,8])|(18[0-9])|(19[8|9]))\\d{8}$";
		return check(phone, regex);

	}

	/**
	 * 邮箱规则校验
	 * @param phone
	 * @return
	 */
	public static boolean checkEmail(String email) {
		int x = email.indexOf("@");// 记录@第一次出现的下标
		int y = email.indexOf(".");// 记录.最后出现的下标
		if (0 == email.indexOf("@") || email.length() - 1 == email.lastIndexOf(".") || y - x < 2) {
			return false;
		} else {
			return true;
		}
	}

}
