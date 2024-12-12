# Use the base image with Maven and Amazon Corretto 17 pre-installed
FROM maven:3-amazoncorretto-17-debian

# Update the package list and install dependencies for Chrome
RUN apt-get update -y && apt-get install -y \
    wget \
    gnupg2 \
    apt-transport-https \
    ca-certificates

# Add Google Chrome repository
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Install Google Chrome
RUN apt-get update -y && apt-get install -y google-chrome-stable

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the working directory in the container to /usr/src/app
WORKDIR /usr/src/app
