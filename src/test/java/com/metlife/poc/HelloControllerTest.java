package com.metlife.poc;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class HelloControllerTest {

    @Test
    void helloReturnsGreeting() {
        HelloController controller = new HelloController();
        assertThat(controller.hello()).isEqualTo("Hello from poc-java-app");
    }
}
