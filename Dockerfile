# Use an official Java runtime as a parent image
FROM openjdk:11

# Set the working directory to /app
WORKDIR /app

# Copy the executable jar file to the working directory
COPY . /app/

RUN javac main.java

# Run the application when the container starts
Expose 3000
CMD ["java", "main"]
