FROM tomcat:8.0
MAINTAINER saye.ramesh babu
COPY target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
