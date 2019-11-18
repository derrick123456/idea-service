package com.idea.platform.tenant.config.filter;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSON;
import com.idea.platform.common.enums.AuthorizeWarnEnum;
import com.idea.platform.common.model.CommonRsp;
import com.idea.platform.common.util.JWTUtil;
import com.idea.platform.common.util.PathUtil;
import com.idea.platform.tenant.config.FilterUrlConfig;

import io.jsonwebtoken.io.IOException;

@Component
public class CommonInterceptor implements HandlerInterceptor {

	private static Logger logger = LoggerFactory.getLogger(CommonInterceptor.class);

	@Value("${securityKey}")
	private String securityKey;
	@Autowired
	private FilterUrlConfig filterUrlConfig;

	/**
	 * 在请求被处理之前调用
	 * 
	 * @param request
	 * @param response
	 * @param handler
	 * @return
	 * @throws Exception
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String url = request.getRequestURI();
		boolean checkurl = PathUtil.pathMatcher(url, filterUrlConfig.getUnauthorizationUrl());
		if (!checkurl) {
			return true;
		}
		String token = request.getHeader("Authorization");
		if (!StringUtils.isEmpty(token)) {
			boolean exists = JWTUtil.checkToken(token, securityKey);
			if (exists) {
				return true;
			}
		}
//	     跨域ajax请求，先发送一个OPTIONS请求，确认是可以请求的之后才发送get或post,第一次OPTIONS预请求，headers是不会带过来的，需要在过滤器中单独处理下；
		if (request.getMethod().equals("OPTIONS")) {
			response.setStatus(HttpServletResponse.SC_OK);
			return true;
		}
		output("", "", response);
		return false;
	}

	/**
	 * 在请求被处理后，视图渲染之前调用
	 * 
	 * @param request
	 * @param response
	 * @param handler
	 * @param modelAndView
	 * @throws Exception
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	/**
	 * 在整个请求结束后调用
	 * 
	 * @param request
	 * @param response
	 * @param handler
	 * @param ex
	 * @throws Exception
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

	/**
	 * 认证不通过时，返回的信息
	 * 
	 * @param code
	 * @param response
	 * @param msg
	 * @throws IOException
	 * @throws UnsupportedEncodingException
	 */
	private <T> void output(String code, String msg, HttpServletResponse response)
			throws IOException, UnsupportedEncodingException {
		response.setContentType("text/plain;charset=UTF-8");
		try {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.getWriter().write(JSON.toJSONString(CommonRsp.errorSys401(AuthorizeWarnEnum.INVALID)));
		} catch (java.io.IOException e) {
			logger.error("" + e);
		}
	}

}
