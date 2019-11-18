package com.idea.platform.tenant.config;


import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * @Description: 
 * @author wgg
 * @date: 2019年10月18日 上午9:49:36
 */
@Component
@Data
@ConfigurationProperties(prefix = "manage.config.datasource")
public class DatasourceConfig {

	private String url;
	
	private String driver;
	
	private String username;
	
	private String password;
	
	private String createDatabaseSql;
	
	private String createTableSql;
	
	private String initDataSql;
	
	private String prefix;
}
