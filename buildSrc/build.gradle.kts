import org.gradle.api.artifacts.dsl.DependencyHandler
import org.gradle.api.provider.Provider
import org.gradle.plugin.use.PluginDependency

plugins {
    `kotlin-dsl`
}

repositories {
    gradlePluginPortal()
}

val libs = extensions.getByType<org.gradle.api.artifacts.VersionCatalogsExtension>().named("libs")

dependencies {
    implementation(libs.findLibrary("kotlinGradlePlugin").get())
    implementation(plugin(libs.findPlugin("springBoot").get()))
    implementation(plugin(libs.findPlugin("springDependencyManagement").get()))
}

fun DependencyHandler.plugin(plugin: Provider<PluginDependency>) =
    plugin.map { "${it.pluginId}:${it.pluginId}.gradle.plugin:${it.version.requiredVersion}" }
