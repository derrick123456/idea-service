package com.idea.platform.tenant.config;


import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * @Description:
 * @author wgg
 * @date: 2019年10月12日 上午9:49:36
 */
@Component
@Data
@ConfigurationProperties(prefix = "manage.config.mycat")
public class MycatConfig {

	private String ip;

	private Integer port;

	private String username;

	private String password;

	private String createDatabaseSql;

	private String createTableseSql;

	private String remote;

	private String local;

	private String filename;

	private String command;
}
