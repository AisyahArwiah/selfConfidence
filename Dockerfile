FROM tomcat:9.0-jdk11-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY dist/selfConfidence.war /usr/local/tomcat/webapps/ROOT.war
ENV PORT=8080
EXPOSE 8080
CMD ["catalina.sh", "run"]
