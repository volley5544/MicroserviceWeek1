# ---------- Stage 1: Test ----------
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

COPY pom.xml ./
# Download dependencies
RUN mvn -B dependency:go-offline


COPY src ./src

# Run tests (if fail → build stops here ❌)
RUN mvn -B test
# Build jar
RUN mvn -B clean package -DskipTests
# ---------- Stage 2: Production ----------
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# Copy jar with fixed name (avoid wildcard issues)
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 3579

CMD ["java", "-jar", "/app/app.jar"]