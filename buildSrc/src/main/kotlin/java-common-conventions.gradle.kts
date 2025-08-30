plugins {
    `java-library`
    kotlin("jvm")
}

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
}

val libs = extensions.getByType<org.gradle.api.artifacts.VersionCatalogsExtension>().named("libs")

dependencies {
    testImplementation(platform(libs.findLibrary("testcontainersBom").get()))
    testRuntimeOnly(libs.findLibrary("h2Database").get())
}

tasks.withType<Test> {
    useJUnitPlatform()
}
