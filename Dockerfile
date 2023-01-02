FROM maven as build

WORKDIR /app

COPY . . 

RUN mvn install 

##stage 2
FROM openjdk:8

WORKDIR /app

COPY  --from=build /app/target/springboot-mongo-docker.jar /app/springboot-mongo-docker.jar

RUN useradd springboot-user

USER springboot-user

EXPOSE 8080

ENTRYPOINT [ "jar", "-jar", "springboot-mongo-docker.jar" ]
