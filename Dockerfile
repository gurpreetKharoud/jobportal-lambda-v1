# Stage 1: Build Stage (Use an image with Maven to build the project)
FROM maven:3.9.9-openjdk-17 AS build

# Set the working directory
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the project (compile and package the app using Maven)
RUN mvn clean package

# Stage 2: Runtime Stage (Use AWS Lambda runtime image for Java)
FROM public.ecr.aws/lambda/java:17

# Copy the built artifact from the build stage
COPY --from=build /app/target/*.jar ${LAMBDA_TASK_ROOT}/function.jar

# Copy the runtime dependencies (assuming these are in target/dependency)
COPY target/dependency/* ${LAMBDA_TASK_ROOT}/lib/

# Set the Lambda function handler
CMD [ "com.jobportal.StreamLambdaHandler::handleRequest" ]