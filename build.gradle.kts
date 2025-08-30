plugins {
    id("java-common-conventions")
    alias(libs.plugins.spotless) apply false
    alias(libs.plugins.owaspDependencyCheck) apply false
}

allprojects {
    group = "com.wund"
    version = "0.0.1-SNAPSHOT"
}

subprojects {
    apply(plugin = "com.diffplug.spotless")
    apply(plugin = "org.owasp.dependencycheck")
    
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
    
    configure<org.owasp.dependencycheck.gradle.extension.DependencyCheckExtension> {
        autoUpdate = true
        format = org.owasp.dependencycheck.reporting.ReportGenerator.Format.ALL.toString()
        outputDirectory = "build/reports/owasp"
        failBuildOnCVSS = 7.0f
        skipConfigurations = listOf("compileClasspath", "testCompileClasspath")
        analyzers.apply {
            assemblyEnabled = false
            nuspecEnabled = false
            nodeEnabled = false
        }
    }
}

