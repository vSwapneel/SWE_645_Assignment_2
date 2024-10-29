# Swapneel, Sanjana, Nohtih
# Base Image from tomcat
FROM tomcat:9.0-jdk15

# Copy website files into the container
COPY ./ /usr/local/tomcat/webapps/ROOT/
