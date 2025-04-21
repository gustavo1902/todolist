FROM ubuntu:lastest AS buil

RUN apt-get update
RUN apt-get install openjdk-17 -y

COPY . .
RUN apt-get install maven -y
RUN mvn clean install

FROM openjdk:17-jdk-slim

EXPOSE 8080

COPY --from=build /app/target/todolist-1.0.0.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]