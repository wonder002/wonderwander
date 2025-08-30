

plugins {
    id("java-common-conventions")
    id("org.springframework.boot")
}

apply(plugin = "io.spring.dependency-management")

// Version Catalog 사용
val libs = extensions
    .getByType<org.gradle.api.artifacts.VersionCatalogsExtension>()
    .named("libs")

dependencies {
    testImplementation(libs.findLibrary("springBootStarterTest").get())
}


