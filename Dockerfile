FROM tomcat:8.0
ARG BN
ADD target/cfsjava-1.$BN-SNAPSHOT.war webapps/java.war
EXPOSE 8080
