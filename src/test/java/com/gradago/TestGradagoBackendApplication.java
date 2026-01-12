package com.gradago;

import org.springframework.boot.SpringApplication;

import com.gradago.GradagoBackendApplication;

public class TestGradagoBackendApplication {

	public static void main(String[] args) {
		SpringApplication.from(GradagoBackendApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
