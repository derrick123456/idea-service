package com.idea.platform.tenant.service.impl;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.idea.platform.tenant.config.DatasourceConfig;
import com.idea.platform.tenant.config.MycatConfig;
import com.idea.platform.tenant.service.IConfigService;

/**
 * @Description: 
 * @author leiyangjun
 * @date: 2019年7月2日 上午10:26:26
 */
@Service
public class ConfigServiceImpl implements IConfigService {

	@Autowired
	private DatasourceConfig datasourceConfig;

	@Autowired
	private MycatConfig mycatConfig;

	@Override
	public DatasourceConfig getDatasourceConfig() {
		return datasourceConfig;
	}

	@Override
	public MycatConfig getMycatConfig() {
		return mycatConfig;
	}

}
