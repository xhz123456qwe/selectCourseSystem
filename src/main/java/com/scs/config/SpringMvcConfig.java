package com.scs.config;

import com.scs.Interceptor.ManagerLoginHandlerInterceptor;
import com.scs.Interceptor.StuLoginHandlerInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.util.List;
import java.util.Properties;

/**
 *
 * @author 徐豪智
 * @description   SpringMVC配置
 *
 */
@Configuration
@ComponentScan("com.scs.controller")
@EnableWebMvc
public class SpringMvcConfig implements WebMvcConfigurer
{
    @Bean
    public ViewResolver viewResolver()
    {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        viewResolver.setOrder(1);
        viewResolver.setExposeContextBeansAsAttributes(true);
        return viewResolver;
    }

    //开启静态资源代理
    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer)
    {
        configurer.enable();
    }

    //视图控制器
    @Override
    public void addViewControllers(ViewControllerRegistry registry)
    {
        registry.addViewController("/").setViewName("login");
    }

    //    //异常处理器
    @Override
    public void configureHandlerExceptionResolvers(List<HandlerExceptionResolver> resolvers)
    {
        SimpleMappingExceptionResolver simpleMappingExceptionResolver = new SimpleMappingExceptionResolver();
        Properties properties = new Properties();
        properties.setProperty("java.lang.Exception", "error");
        simpleMappingExceptionResolver.setExceptionMappings(properties);
        //设置其中的exceptionAttribute属性
        simpleMappingExceptionResolver.setExceptionAttribute("cause");
        resolvers.add(simpleMappingExceptionResolver);
    }

    //    //配置拦截器
    @Override
    public void addInterceptors(InterceptorRegistry registry)
    {
        InterceptorRegistration interceptorRegistration1 = registry.addInterceptor(new StuLoginHandlerInterceptor());
        interceptorRegistration1.addPathPatterns("/student/**").excludePathPatterns("/student");
        InterceptorRegistration interceptorRegistration2 = registry.addInterceptor(new ManagerLoginHandlerInterceptor());
        interceptorRegistration2.addPathPatterns("/manager/**").excludePathPatterns("/manager");
    }
}
