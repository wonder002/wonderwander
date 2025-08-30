plugins {
    id("library-conventions")
    id("jacoco-conventions")
}

dependencies {
    implementation(project(":domain"))
}
