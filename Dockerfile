FROM tomcat:8.5-jdk17
 
#repertoire de travail dans image
WORKDIR /usr/local/tomcat
 
#supprimer les applications par défaut (ROOT, docs, etc)
RUN rm -rf webapps/*
 
COPY petclinic.war webapps/petclinic.war
 
EXPOSE 8080
 
#demarrer Tomcat
CMD ["catalina.sh", "run"]
