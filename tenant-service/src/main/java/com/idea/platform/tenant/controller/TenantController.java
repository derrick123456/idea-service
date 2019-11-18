package com.idea.platform.tenant.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.idea.platform.common.annotation.ApiVersion;
import com.idea.platform.common.enums.SystemWarnEnum;
import com.idea.platform.common.model.CommonRsp;
import com.idea.platform.tenant.service.ICommonTenantService;
import com.idea.platform.tenant.vo.CommonUser;
import com.idea.platform.tenant.vo.TenantModelVO;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * @Description: 租户管理系统
 * @author 王广广
 * @date: 2019年10月13日 上午9:34:15
 */
@Api(value = "租户管理系统", tags = { "租户管理" })
@ApiVersion(1)
@RestController
@RequestMapping("{version}/tenant")
public class TenantController {

	@Autowired
	private ICommonTenantService userService;

	@ApiOperation(value = "租户注册", notes = "")
	@RequestMapping(value = "register", method = RequestMethod.POST)
	public CommonRsp<?> register(@RequestBody CommonUser commonUser) {
		CommonRsp<?> commonRsp = userService.register(commonUser);
		return commonRsp;
	}

	@ApiOperation(value = "租户审批", notes = "只需要ID即可")
	@RequestMapping(value = "appprove", method = RequestMethod.PUT)
	public CommonRsp<?> approve(@RequestBody TenantModelVO tenantModelVO) {
		boolean result = userService.approve(tenantModelVO);
		CommonRsp<?> commonRsp = result == true ? CommonRsp.successSys() : CommonRsp.errorSys500(SystemWarnEnum.SYS001);
		return commonRsp;
	}

	@ApiOperation(value = "重启mycat服务", notes = "")
	@RequestMapping(value = "restart", method = RequestMethod.PUT)
	public CommonRsp<?> restartMycat(@RequestBody TenantModelVO tenantModelVO) {
		CommonRsp<?> commonRsp = userService.restartMycat(tenantModelVO);
		return commonRsp;
	}

	@ApiOperation(value = "租户列表", notes = "")
	@RequestMapping(value = "", method = RequestMethod.GET)
	public CommonRsp<?> list(CommonUser commonUser) {
		return CommonRsp.successSys(userService.list(commonUser));
	}
	
	@ApiOperation(value = "获取列表（测试）", notes = "")
	@RequestMapping(value = "getList", method = RequestMethod.GET)
	public CommonRsp<?> getList(CommonUser commonUser) {
		List<Map<String, Object>> list = userService.getList();
		return CommonRsp.successSys(list);
	}
}
