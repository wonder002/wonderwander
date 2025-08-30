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
    implementation(pluginCoord(libs.findPlugin("springBoot")))
    implementation(pluginCoord(libs.findPlugin("springDependencyManagement")))
}

fun DependencyHandler.pluginCoord(plugin: Provider<PluginDependency>): String =
    plugin.get().let { "${it.pluginId}:${it.pluginId}.gradle.plugin:${it.version.requiredVersion}" }
