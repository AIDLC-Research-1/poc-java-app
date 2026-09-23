package com.metlife.poc;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class VersionControllerTest {

    @Test
    void versionReturnsConfiguredValue() {
        VersionController controller = new VersionController();
        assertThat(controller.version()).containsEntry("version", "0.1.0");
    }
}
