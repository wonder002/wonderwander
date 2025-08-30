package com.wund.api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ApiApplication {

  /**
   * Application entry point — boots the Spring Boot application.
   *
   * <p>Starts the Spring application context using this class as the primary source.
   *
   * @param args command-line arguments passed through to SpringApplication (may be empty)
   */
  public static void main(String[] args) {
    SpringApplication.run(ApiApplication.class, args);
  }
}
