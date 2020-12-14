FROM tomcat
MAINTAINER saye.ramesh babu
COPY dist/ /usr/local/tomcat/webapps/
EXPOSE 8080
