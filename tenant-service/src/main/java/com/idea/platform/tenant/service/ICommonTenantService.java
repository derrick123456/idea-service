package com.idea.platform.tenant.service;


import java.util.List;
import java.util.Map;

import com.github.pagehelper.PageInfo;
import com.idea.platform.common.model.CommonRsp;
import com.idea.platform.tenant.vo.CommonUser;
import com.idea.platform.tenant.vo.TenantModelVO;

/**
 * @Description: 商户模块:注册,审核,查询
 * @author 雷阳军
 * @date: 2019年7月1日 上午9:57:37
 */
public interface ICommonTenantService {

	/**
	 * @Title: register 用户注册
	 * @Description: (这里用一句话描述这个方法的作用)
	 * @return
	 * @return boolean true注册成功,false注册失败
	 */
	public CommonRsp<?> register(CommonUser commonUser);

	/**
	 * @Title: approve 审核
	 * @Description: approve 审核 --创建库,创建表,初始化数据,创建mycat node-->重启mycat
	 * @param commonUser
	 * @return boolean true审核成功,false审核失败
	 */
	public boolean approve(TenantModelVO commonUser);

	/**
	 * @Title: list 分页查询
	 * @Description: list 分页查询
	 * @param commonUser
	 * @return PageInfo<CommonUser>
	 */
	public PageInfo<CommonUser> list(CommonUser commonUser);
	/**
	 * @Description: 通过命令重启mycat服务
	 * @param commonUser
	 * @return boolean<CommonUser>
	 */
	public CommonRsp<?> restartMycat(TenantModelVO tenantModelVO);
	/**
	 * @Description: 新租户
	 * @param tenantModelVO
	 * @return boolean<CommonUser>
	 */
	public CommonRsp<?> login(TenantModelVO tenantModelVO);

	public List<Map<String, Object>> getList();
}
