package com.scs.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.transaction.annotation.EnableTransactionManagement;
/**
 *
 * @author 徐豪智
 * @description   Spring配置
 *
 */
@Configuration
@ComponentScan({"com.scs.service"})
@PropertySource("classpath:jdbc.properties")
@Import({MyBatisConfig.class, DataSourceConfig.class})
@EnableTransactionManagement
public class SpringConfig
{
}
