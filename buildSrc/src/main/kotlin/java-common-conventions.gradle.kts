
plugins {
    `java-library`
}

apply(plugin = "org.jetbrains.kotlin.jvm")

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
}

spotless {
    java {
        target("src/**/*.java")
        googleJavaFormat()
        // You can add more formatters or rules here if needed
    }
}

val libs = extensions.getByType<org.gradle.api.artifacts.VersionCatalogsExtension>().named("libs")

dependencies {
    testImplementation(platform(libs.findLibrary("testcontainersBom").get()))
    testImplementation(libs.findLibrary("springBootStarterTest").get())
    testRuntimeOnly(libs.findLibrary("h2Database").get())
}

tasks.withType<Test> {
    useJUnitPlatform()
}
