package com.idea.platform.tenant.mapper;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.jdbc.SQL;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.idea.platform.common.mapper.BaseMapper;
import com.idea.platform.common.util.BaseSQLBuffer;
import com.idea.platform.tenant.vo.CommonUser;

public interface CommonTenantMapper extends BaseMapper<CommonUser> {

	@SelectProvider(method = "selectList", type = SQLBuffer.class)
	public List<CommonUser> selectList(CommonUser commonUser);
	
	@SelectProvider(method = "selectById", type = SQLBuffer.class)
	public CommonUser selectById(String id);

	class SQLBuffer {
		
		/**
		 * 生成select语句:支持任意条件=匹配查询
		 * 
		 * @param obj:MyBatis传入的参数对象VO
		 * @return
		 */
		public String selectList(Object obj) {
			JSONObject jsonObject = (JSONObject) JSON.toJSON(obj);
			JSONObject params=(JSONObject)jsonObject.clone();
			// 将className以驼峰规则加入下划线
			String tableName = obj.getClass().getSimpleName().replaceAll("[A-Z]", "_$0").substring(1).toUpperCase();
			Set<String> columns = jsonObject.keySet();// 取到所有包含的字段
			BaseSQLBuffer.removeKeyBase(columns);
			String xinhao = StringUtils.join(columns, ",");
			return new SQL() {
				{
					SELECT(xinhao.toUpperCase());
					FROM(tableName);
					List<String> allKey = new ArrayList<String>(columns);
					BaseSQLBuffer.addKeyBase(allKey);
					for (String column : allKey) {
						if ((column.equals("id") || column.equals("status"))&&jsonObject.get(column) != null) {
							WHERE(column.toUpperCase() + "=#{" + column + "}");
						} else if (column.equals("searchValue")&&params.get(column) != null) {
							WHERE("(  " + "code like concat('%',concat(#{searchValue},'%')) "
									+ "or name like concat('%',concat(#{searchValue},'%')) "
									+ "or fullname like concat('%',concat(#{searchValue},'%')) "
									+ "or address like concat('%',concat(#{searchValue},'%')) "
									+ "or mobile like concat('%',concat(#{searchValue},'%')) "
									+ "or email like concat('%',concat(#{searchValue},'%')) "
									+ "or head like concat('%',concat(#{searchValue},'%'))" + ")");
						}
					}
				}
			}.toString();
		}
		
		/**
		 * 生成select语句:支持任意条件=匹配查询
		 * 
		 * @param obj:MyBatis传入的参数对象VO
		 * @return
		 */
		public String selectById(String id) {
			CommonUser obj=new CommonUser();
			JSONObject jsonObject = (JSONObject) JSON.toJSON(obj);
			// 将className以驼峰规则加入下划线
			String tableName = obj.getClass().getSimpleName().replaceAll("[A-Z]", "_$0").substring(1).toUpperCase();
			Set<String> columns = jsonObject.keySet();// 取到所有包含的字段
			BaseSQLBuffer.removeKeyBase(columns);
			String xinhao = StringUtils.join(columns, ",");
			return new SQL() {
				{
					SELECT(xinhao.toUpperCase());
					FROM(tableName);
					WHERE("ID=#{id}");
				}
			}.toString();
		}
	}
	
	/**
	 * 检查code是否重复
	 * @param code
	 * @return
	 */
	public List<Map<String, Object>> isExist(CommonUser commonUser);
	
	
	public static void main(String[] args) {
		SQLBuffer buff=new SQLBuffer();
		System.out.println(buff.selectById("abc"));
	}

	public List<Map<String, Object>> getList();

	
	
}