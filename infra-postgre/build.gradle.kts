plugins {
    id("library-conventions")
}

dependencies {
    implementation(project(":domain"))
    runtimeOnly(libs.mysqlConnectorJ)
}