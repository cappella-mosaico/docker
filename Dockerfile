FROM tomcat:9.0.59-jre11-temurin
MAINTAINER delki8 <delki8@gmail.com>

# exposing default tomcat apps (like management) to automatic deploys
RUN rm -r /usr/local/tomcat/webapps/
RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps

# allow the tomcat management tools to be accessed outside container
COPY ./tomcat/conf/manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
# replacing tomcat users to allow admin access inside management
COPY ./tomcat/conf/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY ./pastorais-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/pastorais.war
COPY ./tomcat/*.jar /usr/local/tomcat/lib/

EXPOSE 8080

CMD ["catalina.sh", "run"]
