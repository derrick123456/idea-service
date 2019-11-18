package com.idea.platform.tenant.config;

import java.util.List;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * @author wgg
 * @date 2019/10/17
 */
@Component
@Data
@ConfigurationProperties(prefix = "tenantserver-url.config")
public class FilterUrlConfig {
	/**
	 * 不拦截的(不需要header添加authorization的通配符路径,见yaml配置文件)
	 */
	private List<String> unauthorizationUrl;
	
	private String tokenSplit;
	
	private List<String> unResponeUrl;

}
