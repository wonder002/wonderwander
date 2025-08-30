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
    implementation(plugin(libs.findPlugin("springBoot").get()))
    implementation(plugin(libs.findPlugin("springDependencyManagement").get()))
}

/**
     * Converts a `Provider<PluginDependency>` into a `Provider<String>` containing Gradle plugin coordinates.
     *
     * The produced provider, when realized, yields a coordinate string in the form
     * `pluginId:pluginId.gradle.plugin:version` using the dependency's `pluginId` and `version.requiredVersion`.
     * The conversion is lazy — no values are resolved until the returned provider is queried.
     *
     * @param plugin Provider of the plugin dependency to convert.
     * @return A provider that produces the plugin coordinate string.
     */
    fun DependencyHandler.plugin(plugin: Provider<PluginDependency>) =
    plugin.map { "${it.pluginId}:${it.pluginId}.gradle.plugin:${it.version.requiredVersion}" }
