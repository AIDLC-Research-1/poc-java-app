package com.metlife.poc;

import java.util.Map;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class HelloControllerTest {

    @Test
    void helloReturnsGreeting() {
        HelloController controller = new HelloController();
        assertThat(controller.hello()).isEqualTo("Hello from poc-java-app");
    }

    @Test
    void healthReturnsOkStatus() {
        HelloController controller = new HelloController();
        assertThat(controller.health()).isEqualTo(Map.of("status", "ok"));
    }
}
