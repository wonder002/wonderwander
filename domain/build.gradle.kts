plugins {
    id("library-conventions")
    id("jacoco-conventions")
}

dependencies {
    implementation(libs.bundles.springData)
    implementation(libs.bundles.databaseCore)

    compileOnly(libs.lombok)
    annotationProcessor(libs.lombok)
}
