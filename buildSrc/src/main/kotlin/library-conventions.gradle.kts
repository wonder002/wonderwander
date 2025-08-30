import io.spring.gradle.dependencymanagement.dsl.DependencyManagementExtension

plugins {
    id("java-common-conventions")
}

apply(plugin = "io.spring.dependency-management")

val libs = extensions.getByType<org.gradle.api.artifacts.VersionCatalogsExtension>().named("libs")

configure<DependencyManagementExtension> {
    imports {
        mavenBom(org.springframework.boot.gradle.plugin.SpringBootPlugin.BOM_COORDINATES)
        mavenBom("org.testcontainers:testcontainers-bom:1.19.7")
    }
}