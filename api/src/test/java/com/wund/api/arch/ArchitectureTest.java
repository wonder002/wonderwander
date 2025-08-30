package com.wund.api.arch;

import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;
import static com.tngtech.archunit.library.GeneralCodingRules.*;

import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.core.importer.ImportOption;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

@DisplayName("아키텍처 규칙 테스트")
class ArchitectureTest {

  private JavaClasses classes;

  @BeforeEach
  void setUp() {
    classes =
        new ClassFileImporter()
            .withImportOption(ImportOption.Predefined.DO_NOT_INCLUDE_TESTS)
            .importPackages("com.wund");
  }

  @DisplayName("일반적인 코딩 규칙 준수 검증")
  @Nested
  class GeneralCodingRulesTest {

    // 외부 ArchitectureTest.this.classes 사용

    @Nested
    @DisplayName("예외 처리 규칙")
    class ExceptionRules {
      @Test
      @DisplayName("Generic 예외를 던지지 않는다")
      void noGenericExceptions() {
        NO_CLASSES_SHOULD_THROW_GENERIC_EXCEPTIONS.allowEmptyShould(true).check(classes);
      }
    }

    @Nested
    @DisplayName("로깅·스트림 사용 규칙")
    class LoggingAndStreamRules {
      @Test
      @DisplayName("java.util.logging 사용 금지")
      void noJavaUtilLogging() {
        NO_CLASSES_SHOULD_USE_JAVA_UTIL_LOGGING.allowEmptyShould(true).check(classes);
      }

      @Test
      @DisplayName("Joda-Time 사용 금지")
      void noJodaTime() {
        NO_CLASSES_SHOULD_USE_JODATIME.allowEmptyShould(true).check(classes);
      }

      @Test
      @DisplayName("표준 스트림 접근 금지")
      void noStandardStreams() {
        NO_CLASSES_SHOULD_ACCESS_STANDARD_STREAMS.allowEmptyShould(true).check(classes);
      }
    }
  }

  @Test
  @DisplayName("도메인 레이어는 다른 레이어에 의존할 수 없다.")
  void domain_layer_dependencies() {
    noClasses()
        .that()
        .resideInAPackage("..domain..")
        .should()
        .dependOnClassesThat()
        .resideInAnyPackage("..application..", "..infra..", "..api..")
        .allowEmptyShould(true)
        .check(classes);
  }
}
