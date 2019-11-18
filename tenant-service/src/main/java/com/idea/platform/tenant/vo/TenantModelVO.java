package com.idea.platform.tenant.vo;


import com.idea.platform.common.model.BaseVO;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class TenantModelVO extends BaseVO{

	@ApiModelProperty(value = "租户id(租户审批接口用)")
	private String id;
	
	@ApiModelProperty(value = "新租户注册鉴权账户名称")
	private String name;
	
	@ApiModelProperty(value = "新租户注册鉴权账户密码")
	private String password;
}
