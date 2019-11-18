package com.idea.platform.tenant;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.amqp.RabbitAutoConfiguration;
import org.springframework.cloud.netflix.eureka.EurekaClientAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import springfox.documentation.swagger2.annotations.EnableSwagger2;
/**
 * spring-boot 启动入口
 *
 * @author wgg
 * @date 2019/10/12
 */
@SpringBootApplication(exclude = {
		// DataSourceAutoConfiguration.class,
		// //如果项目不需要数据库,请包涵该项,同时去掉配置文件数据库相关配置,否则请去掉或注释
		// DruidDataSourceAutoConfigure.class,//如果项目不需要数据库,请包涵该项,同时去掉配置文件数据库相关配置,否则请去掉或注释
		// HibernateJpaAutoConfiguration.class,
		// //如果项目不需要数据库,请包涵该项,同时去掉配置文件数据库相关配置,否则请去掉或注释
		RabbitAutoConfiguration.class, // 如果项目不需要rabbitMQ,请包涵该项,同时去掉rabbit相关配置,否则请去掉或注释
		//MailSenderAutoConfiguration.class,
		EurekaClientAutoConfiguration.class,//如果项目不需要Eureka请包涵此项，并去掉相关配置注解
		// PageHelperAutoConfiguration.class// 如果使用自定义分页配置,需要去除自动配置
//		 RedisAutoConfiguration.class //如果项目不需要Redis,请包涵该项,同时去掉Redis相关配置,否则请去掉或注释
})
//@ComponentScans({@ComponentScan("com.idea.platform.common")}) //
//第一种:引入所有common配置

//第二种选择性引入,同时列出common-base目前所有支持的可选配置
@ComponentScans({@ComponentScan("com.idea.platform.common.config.druid"), // 选择性引入连接池配置类
		@ComponentScan("com.idea.platform.common.config.exception"), // 选择性引入异常配置类
		@ComponentScan("com.idea.platform.common.config.swagger"), // 选择性引入swagger配置类
		@ComponentScan("com.idea.platform.common.config.version"), // 选择性引入api版本注解支持
//		@ComponentScan("com.idea.platform.common.config.tenant"), // 选择性引入多租户支持,请配合mycat使用,单库应用请去掉该项
//		@ComponentScan("com.idea.platform.common.service.webSocket"),
		@ComponentScan("com.idea.platform.common.service.redis"), // 选择性引入iredisservice
		@ComponentScan("com.idea.platform.common.service.log"),
		@ComponentScan("com.idea.platform.common.config.pageHelper"), // 选择性引入pageHelper分页插件支持
		@ComponentScan("com.idea.platform.common.config.spring")}) // 选择性的引入spring工具的支持

@EnableSwagger2 // 开启swagger文档,配合ComponentScan("com.idea.platform.common.config.swagger")使用
@MapperScan("com.idea.platform.tenant.mapper") // mapper扫描位置,如有使用mybatis该项必须
public class TenantApp {
	public static void main(String[] args) {
		SpringApplication.run(TenantApp.class, args);
	}
}


