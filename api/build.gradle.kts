plugins {
    id("springboot-conventions")
    id("jacoco-conventions")
}

dependencies {
    implementation(libs.bundles.springBootWeb)
    implementation(project(":application"))

    testImplementation(project(":domain"))
    testImplementation(project(":application"))
    testImplementation(project(":infra-postgre"))
    testImplementation(project(":infra-redis"))
    testImplementation(libs.bundles.archunit)
}
