FROM openjdk:11-jdk-slim

VOLUME /tmp
ADD /ensa-app.jar app.jar
RUN sh -c 'touch /app'
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
