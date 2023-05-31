FROM 218211829215.dkr.ecr.us-east-2.amazonaws.com

WORKDIR /app/java_project/

# Copy the jar
# COPY target/dockerized-0.0.1-SNAPSHOT.jar ./
# # Copy dependencies
# COPY target/dependency-jars/* ./dependency-jars/
# # Copy input data
# COPY src/test/resources/file.txt /tmp/docker/input/
# COPY src/main/resources/log4j2.xml ./log4j2.xml

# Volumes
VOLUME ["/tmp/docker/input", "/tmp/docker/output", "/tmp/docker/data/logs"]

# Run the jar (CMD)
CMD ["java", "-Dlog4j.configurationFile=/app/java_project/log4j2.xml", "-jar", "dockerized-0.0.1-SNAPSHOT.jar"]