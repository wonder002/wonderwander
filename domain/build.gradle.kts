plugins {
    id("library-conventions")
    id("jacoco-conventions")
}

dependencies {
    implementation(libs.bundles.springData)
    implementation(libs.bundles.databaseCore)
    implementation(libs.querydslJpa) {
        artifact {
            classifier = "jakarta"
        }
    }
    annotationProcessor(libs.querydslApt) {
        artifact {
            classifier = "jakarta"
        }
    }

    compileOnly(libs.lombok)
    annotationProcessor(libs.lombok)
    testCompileOnly(libs.lombok)
    testAnnotationProcessor(libs.lombok)
}
