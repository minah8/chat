package com.spring.chat.chatting.Config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

import lombok.RequiredArgsConstructor;
//import spring.common.web.LogonCheckInterceptor;

@RequiredArgsConstructor
@Configuration
@EnableWebSocketMessageBroker
public class WebSockerConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    // 클라이언트가 메시지를 구독할 endpoint를 정의합니다.
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/send");
    }

    @Override
    // connection을 맺을때 CORS 허용
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/").setAllowedOrigins("http://localhost:8182/index.js").withSockJS();
        //registry.addEndpoint("/").setAllowedOrigins("*").withSockJS();
    }
}
