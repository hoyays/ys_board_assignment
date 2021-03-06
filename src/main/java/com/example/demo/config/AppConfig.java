package com.example.demo.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class AppConfig implements WebMvcConfigurer {

	@Bean
	public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
	SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
	sessionFactory.setDataSource(dataSource);

	Resource[] res = new PathMatchingResourcePatternResolver().getResources("classpath:/mapper/**/*.xml");
	sessionFactory.setMapperLocations(res);

	return sessionFactory.getObject();
	}

	@Bean
	public SqlSessionTemplate sqlSession(SqlSessionFactory sqlSessionFactory) {
	System.out.println("sqlSessionFactory : " + sqlSessionFactory);
	return new SqlSessionTemplate(sqlSessionFactory);
	}
	
	//외부 resource 서비스 하기 - application.properties 주석값도 풀어야 함
	//참고 블로그 : https://zepinos.tistory.com/36
//	@Value("${resources.location}")
//	private String resourcesLocation;
//	@Value("${resources.uri_path}")
//	private String resourcesUriPath;
//	
//	@Override
//    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler(resourcesUriPath+"/**")
//                .addResourceLocations("file:///"+resourcesLocation); 
//    }
	
	
}//class
