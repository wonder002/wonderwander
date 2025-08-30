
plugins {
    id("springboot-conventions")
}

val libs = extensions.getByType<org.gradle.api.artifacts.VersionCatalogsExtension>().named("libs")

dependencies {
    implementation(libs.findLibrary("springBootStarter").get())
}
