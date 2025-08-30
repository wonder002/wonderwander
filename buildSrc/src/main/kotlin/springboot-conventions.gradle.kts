import io.spring.gradle.dependencymanagement.dsl.DependencyManagementExtension

plugins {
    id("java-common-conventions")
    id("org.springframework.boot")
}

apply(plugin = "io.spring.dependency-management")

configure<DependencyManagementExtension> {
    imports {
        mavenBom("org.testcontainers:testcontainers-bom:1.19.7")
    }
}
