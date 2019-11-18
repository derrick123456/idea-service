package com.idea.platform.tenant.service.impl;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.idea.platform.common.enums.ParameterWarnEnum;
import com.idea.platform.common.enums.SystemWarnEnum;
import com.idea.platform.common.model.CommonRsp;
import com.idea.platform.common.model.LoginVO;
import com.idea.platform.common.model.TokenVO;
import com.idea.platform.common.util.JWTUtil;
import com.idea.platform.common.util.MycatXMLUtil;
import com.idea.platform.common.util.SCPUtil;
import com.idea.platform.common.util.SQLScriptExeUtil;
import com.idea.platform.common.util.ThreadLocalHolder;
import com.idea.platform.tenant.config.DatasourceConfig;
import com.idea.platform.tenant.config.MycatConfig;
import com.idea.platform.tenant.config.utils.VerifyUtil;
import com.idea.platform.tenant.mapper.CommonTenantMapper;
import com.idea.platform.tenant.service.ICommonTenantService;
import com.idea.platform.tenant.vo.CommonUser;
import com.idea.platform.tenant.vo.TenantModelVO;

import lombok.extern.slf4j.Slf4j;

/**
 * @Description: 租户模块
 * @author 王广广
 * @date: 2019年10月11日 上午9:59:01
 */
@Slf4j
@Service
public class CommonTenantServiceImpl implements ICommonTenantService {

	@Autowired
	private CommonTenantMapper commonUserMapper;

	@Autowired
	private DatasourceConfig dbConfig;

	@Autowired
	private MycatConfig mycatConfig;

	@Value("${spring.boot.admin.username}")
	private String username;

	@Value("${spring.boot.admin.password}")
	private String password;

	@Value("${securityKey}")
	private String securityKey;

	@Value("${expiretime}")
	private Integer expiretime;

	@Override
	public CommonRsp<?> register(CommonUser commonUser) {
		// 租户标识码需唯一
		List<Map<String, Object>> list = commonUserMapper.isExist(commonUser);
		if (list != null && !list.isEmpty()) {
			return CommonRsp.errorSys409("1131", "商户标识码已存在，请重新输入");
		}
		boolean checkPhoen = VerifyUtil.checkPhone(commonUser.getMobile());
		if (!checkPhoen) {
			return CommonRsp.errorSys401("001", "请填写正确的手机号码");
		}
		boolean checkMail = VerifyUtil.checkEmail(commonUser.getEmail());
		if (!checkMail) {
			return CommonRsp.errorSys401("002", "请填写正确的邮箱");
		}
		int resultInt = commonUserMapper.insertBase(commonUser);
		return resultInt >= 1 ? CommonRsp.successSys() : CommonRsp.errorSys500(SystemWarnEnum.SYS001);
	}

	@Override
	public boolean approve(TenantModelVO tenantModelVO) {
		boolean result = true;
		CommonUser commonUser = commonUserMapper.selectById(tenantModelVO.getId());
		result = commonUser == null ? false : result;
		if (result) {
			String database = dbConfig.getPrefix() + commonUser.getCode().toLowerCase();
			String sql = dbConfig.getCreateDatabaseSql().replaceAll(dbConfig.getPrefix(), database);
			String remoteFile = mycatConfig.getRemote() + mycatConfig.getFilename();
			String localFile = mycatConfig.getLocal() + mycatConfig.getFilename();
			try {
				// 创建数据库
				result = SQLScriptExeUtil.exeSQL(
						dbConfig.getUrl().substring(0, dbConfig.getUrl().indexOf(dbConfig.getPrefix())),
						dbConfig.getDriver(), dbConfig.getUsername(), dbConfig.getPassword(), sql);
				if (result) {// 创建数据库成功才能往下执行
					// 执行创建表脚本
					result = SQLScriptExeUtil.exeLocalScript(
							dbConfig.getUrl().replaceAll(dbConfig.getPrefix(), database), dbConfig.getDriver(),
							dbConfig.getUsername(), dbConfig.getPassword(), getInspm(dbConfig.getCreateTableSql()));
					// 执行数据初始化脚本
					result = SQLScriptExeUtil.exeLocalScript(
							dbConfig.getUrl().replaceAll(dbConfig.getPrefix(), database), dbConfig.getDriver(),
							dbConfig.getUsername(), dbConfig.getPassword(), getInspm(dbConfig.getInitDataSql()));
					// 从远程服务器下载原配置文件schema.xml到本地
					result = SCPUtil.downloadFile(mycatConfig.getIp(), mycatConfig.getPort(), mycatConfig.getUsername(),
							mycatConfig.getPassword(), remoteFile, mycatConfig.getLocal());
					// 添加mycat schema.xml数据库节点
					MycatXMLUtil.addDataNode(database, database, localFile);
					// 上传修改后的文件到远程服务器
					result = SCPUtil.uploadFile(mycatConfig.getIp(), mycatConfig.getPort(), mycatConfig.getUsername(),
							mycatConfig.getPassword(), mycatConfig.getRemote(), localFile);
					// 更新审批状态1审批通过
					if (result) {
						commonUser.setStatus(Short.valueOf("1"));
						int resultInt = commonUserMapper.updateBase(commonUser);
						result = resultInt >= 1 ? result : false;
					}
				}
			} catch (Exception e) {
				log.error("mycat error：", e);
			}
		}
		return result;
	}

	// 通过类加载器以流的形式获取资源
	private InputStream getInspm(String filePath) {
		InputStream inps = this.getClass().getClassLoader().getResourceAsStream(filePath);
		return inps;
	}

	@Override
	public PageInfo<CommonUser> list(CommonUser commonUser) {
		Integer pageNum = commonUser.getPageNum() == null ? 1 : commonUser.getPageNum();
		Integer pageSize = commonUser.getPageSize() == null ? 10 : commonUser.getPageSize();
		commonUser.setPageNum(pageNum);
		commonUser.setPageSize(pageSize);
		PageHelper.startPage(commonUser.getPageNum(), commonUser.getPageSize(), true, false);
		List<CommonUser> reslut = commonUserMapper.selectList(commonUser);
		PageInfo<CommonUser> pageInfo = new PageInfo<CommonUser>(reslut);
		return pageInfo;
	}

	@Override
	public CommonRsp<?> restartMycat(TenantModelVO tenantModelVO) {

		if (!tenantModelVO.getName().equals(username)) {
			return CommonRsp.errorSys400(ParameterWarnEnum.USER);
		}
		if (!tenantModelVO.getPassword().equals(password)) {
			return CommonRsp.errorSys400(ParameterWarnEnum.USER);
		}
		// 传命令重启mycat
		String resultCode = SCPUtil.execuateCommand(mycatConfig.getIp(), mycatConfig.getPort(),
				mycatConfig.getUsername(), mycatConfig.getPassword(), mycatConfig.getCommand());
		return "1".equals(resultCode) ? CommonRsp.successSys() : CommonRsp.errorSys500(SystemWarnEnum.SYS001);
	}

	@Override
	public CommonRsp<?> login(TenantModelVO tenantModelVO) {

		if (!tenantModelVO.getName().equals(username)) {
			return CommonRsp.errorSys400(ParameterWarnEnum.USER);
		}
		if (!tenantModelVO.getPassword().equals(password)) {
			return CommonRsp.errorSys400(ParameterWarnEnum.USER);
		}
		String token = null;
		try {
			// 生成token
			TokenVO tokenStr = JWTUtil.getToken(username, expiretime, securityKey);
			if (!StringUtils.isEmpty(tokenStr)) {
				token = tokenStr.getAccess_token();
			}
		} catch (Exception e) {
			log.error("token error：", e);
		}
		return CommonRsp.successSys(token);
	}

	@Override
	public List<Map<String, Object>> getList() {
		// TODO Auto-generated method stub
		return commonUserMapper.getList();
	}
}
