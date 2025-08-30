pluginManagement {
    versionCatalogs {
        create("libs") {
            val catalogFile = file("gradle/libs.versions.toml")
            require(catalogFile.exists()) { "루트 기준 gradle/libs.versions.toml 파일이 존재하지 않습니다." }
            from(files(catalogFile))
        }
    }
    repositories {
        gradlePluginPortal()
    }
    plugins {
        id("org.springframework.boot") version libs.versions.springBoot.get()
        id("io.spring.dependency-management") version libs.versions.springDependencyManagement.get()
    }
}

dependencyResolutionManagement {
    versionCatalogs {
        create("libs") {
            from(files("../gradle/libs.versions.toml"))
        }
    }
}