plugins {
    id("java-common-conventions")
    alias(libs.plugins.spotless) apply false
}

allprojects {
    group = "com.wund"
    version = "0.0.1-SNAPSHOT"
}

subprojects {
    apply(plugin = "com.diffplug.spotless")
    
    configure<com.diffplug.gradle.spotless.SpotlessExtension> {
        java {
            target("src/**/*.java")
            googleJavaFormat("1.23.0")
            importOrder()
            removeUnusedImports()
            trimTrailingWhitespace()
            endWithNewline()
        }
    }
}

