# Build stage
FROM gradle:8.5-jdk21 AS build
WORKDIR /app

# Copy Gradle files
COPY build.gradle.kts settings.gradle.kts gradle.properties ./
COPY buildSrc/ ./buildSrc/

# Copy source code
COPY api/ ./api/
COPY application/ ./application/
COPY domain/ ./domain/
COPY infra-postgre/ ./infra-postgre/
COPY infra-redis/ ./infra-redis/

# Build application
RUN gradle build --no-daemon --parallel

# Runtime stage
FROM openjdk:21-jre-slim
WORKDIR /app

# Create non-root user
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Copy built JAR
COPY --from=build /app/application/build/libs/*.jar app.jar

# Change ownership
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]