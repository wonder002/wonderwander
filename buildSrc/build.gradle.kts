import org.gradle.api.artifacts.dsl.DependencyHandler
import org.gradle.api.provider.Provider
import org.gradle.plugin.use.PluginDependency

plugins {
    `kotlin-dsl`
}

repositories {
    gradlePluginPortal()
    mavenCentral()
}



val libs = extensions.getByType<org.gradle.api.artifacts.VersionCatalogsExtension>().named("libs")

dependencies {
    implementation(libs.findLibrary("kotlinGradlePlugin").get())
    implementation(pluginCoord(libs.findPlugin("springBoot").get()))
    implementation(pluginCoord(libs.findPlugin("springDependencyManagement").get()))
}

fun DependencyHandler.pluginCoord(plugin: Provider<PluginDependency>): String =
    plugin.orNull?.let { "${it.pluginId}:${it.pluginId}.gradle.plugin:${it.version.requiredVersion}" }
        ?: error("Version catalog plugin alias not found for buildSrc: expected plugin entry is missing.")
