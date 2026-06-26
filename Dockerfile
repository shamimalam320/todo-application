FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /APP

COPY pom.xml /APP/
COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /APP
COPY --from=build /APP/target/*.jar /APP/app.jar
EXPOSE 8081

ENTRYPOINT ["java","-jar","app.jar"]
