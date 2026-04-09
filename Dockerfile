FROM maven:3.9.11-eclipse-temurin-17 AS build

WORKDIR /workspace

COPY Hospital_appointment-backend ./Hospital_appointment-backend
COPY Hospital_appointment_frontend ./Hospital_appointment_frontend

RUN mkdir -p Hospital_appointment-backend/src/main/resources/static \
    && cp -r Hospital_appointment_frontend/. Hospital_appointment-backend/src/main/resources/static/ \
    && mvn -f Hospital_appointment-backend/pom.xml clean package -DskipTests

FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /workspace/Hospital_appointment-backend/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
