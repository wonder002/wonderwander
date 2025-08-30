plugins {
    id("springboot-conventions")
}

dependencies {
    implementation(libs.bundles.springBootWeb)
    implementation(project(":domain"))
    implementation(project(":application"))
}