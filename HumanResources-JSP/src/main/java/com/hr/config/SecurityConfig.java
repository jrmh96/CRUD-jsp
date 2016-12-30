package com.hr.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import com.hr.web.SecurityInterceptor;

@Configuration
public class SecurityConfig extends WebMvcConfigurerAdapter {
	@Autowired
	SecurityInterceptor securityInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
	//	registry.addInterceptor(securityInterceptor);
	}
	
	
	
}