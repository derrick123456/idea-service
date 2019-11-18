package com.idea.platform.tenant.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.idea.platform.common.annotation.ApiVersion;
import com.idea.platform.common.model.CommonRsp;
import com.idea.platform.tenant.service.ICommonTenantService;
import com.idea.platform.tenant.vo.TenantModelVO;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * @Description: 租户管理模块
 * @author 王广广
 * @date: 2019年10月13日 上午9:34:15
 */
@Api(value = "租户管理系统", tags = { "登录鉴权" })
@ApiVersion(1)
@RestController
@RequestMapping("{version}/")
public class LoginController {
	
	
	@Autowired
	private ICommonTenantService userService;
	
	@ApiOperation(value = "登录鉴权", notes = "")
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public CommonRsp<?> login(@RequestBody TenantModelVO tenantModelVO) {
		CommonRsp<?> commonRsp = userService.login(tenantModelVO);
		return commonRsp;
	}

}
