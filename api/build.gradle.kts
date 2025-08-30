plugins {
    id("springboot-conventions")
    id("jacoco-conventions")
}

dependencies {
    implementation(libs.bundles.springBootWeb)
    implementation(project(":application"))

    testImplementation(libs.bundles.archunit)
}
