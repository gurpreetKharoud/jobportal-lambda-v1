package com.jobportal.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import java.util.HashMap;
import java.util.Map;

@RestController
//@EnableWebMvc
@RequestMapping("/")
public class PingController {

	@GetMapping("/ping")
	public Map<String, String> ping() {
		Map<String, String> pong = new HashMap<>();
		pong.put("pong", "Hello, World!");
		return pong;
	}

	@GetMapping("/hello")
	public Map<String, String> hello() {
		Map<String, String> pong = new HashMap<>();
		pong.put("hello", "Hello, World!");
		return pong;
	}

}
