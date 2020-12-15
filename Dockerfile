FROM tomcat:8.5
MAINTAINER saye.ramesh babu
COPY target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
