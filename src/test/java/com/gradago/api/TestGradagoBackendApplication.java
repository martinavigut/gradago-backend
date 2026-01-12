package com.gradago.api;

import org.springframework.boot.SpringApplication;

public class TestGradagoBackendApplication {

	public static void main(String[] args) {
		SpringApplication.from(GradagoBackendApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
