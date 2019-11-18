package com.idea.platform.tenant.service;


import com.idea.platform.tenant.config.DatasourceConfig;
import com.idea.platform.tenant.config.MycatConfig;

/**
 * @Description: manage配置服务
 * @author leiyangjun
 * @date: 2019年7月2日 上午10:17:56
 */
public interface IConfigService {

	/**
	 * @Title: getDatasourceConfig 获取初始化数据库配置
	 * @Description: 获取初始化数据库配置
	 * @return DatasourceConfig 返回类型
	 */
	public DatasourceConfig getDatasourceConfig();

	/**
	 * @Title: getMycatConfig 获取mycat配置
	 * @Description: 获取mycat配置
	 * @return MycatConfig 返回类型
	 */
	public MycatConfig getMycatConfig();
}
