# Use an official Tomcat image
FROM tomcat:9.0-jdk15

# Copy website files into the container
COPY ./ /usr/local/tomcat/webapps/ROOT/

# Expose port 8080 for tomcat
# EXPOSE 8080
