FROM openjdk:11
EXPOSE 8081
ADD target/my-app.jar my-app.jar
ENTRYPOINT ["java","-jar","/my-app.jar"]
