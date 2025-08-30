plugins {
    id("springboot-conventions")
}

dependencies {
    implementation(libs.bundles.springBootWeb)
    implementation(project(":application"))

    testImplementation(libs.bundles.archunit)
}
