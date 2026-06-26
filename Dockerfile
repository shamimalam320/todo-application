FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /APP

COPY pom.xml
COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /APP
COPY --from=build /APP/target/*.jar app.jar
EXPOSE 8081

EXTRYPOINT ["java","-jar","app.jar"]
