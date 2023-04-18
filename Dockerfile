# https://nodejs.org/en/docs/guides/nodejs-docker-webapp
FROM node:16

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# https://blog.npmjs.org/post/171556855892/introducing-npm-ci-for-faster-more-reliable
RUN npm ci --omit=dev

# Bundle app's source code inside the Docker image
COPY . .

ENV NAME=Michael
EXPOSE 8080
CMD [ "node", "server.js" ]

# ==== DOCKER REFERENCE ====
# IMAGE COMMANDS
# $ docker build . -t <username>/<image name>:latest; Build image with 'latest' tag
# $ docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]; Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
# $ docker images; list images
# $ docker image rm [OPTIONS] IMAGE [IMAGE...]; Remove image
# $ docker image rm $(docker images -q); Remove all images
# 
# VERSIONING CONVENTION https://betterprogramming.pub/how-to-version-your-code-in-2020-60bdd221278b
# $ docker build -t <username>/<image name>:latest .;
# $ docker tag <username>/<image name>:latest <username>/<image name>:<version>; https://docs.docker.com/engine/reference/commandline/tag/
# $ docker push <username>/<image name>:<version>;
# $ docker push <username>/<image name>:latest;
#
# CONTAINER COMMANDS
# $ docker run -p 49160:8080 -d --name=<container name optional> <your username>/<image name>; Start container with image
#   -d detached mode (runs in bg of the terminal)
#   -p redirects a public port to a private port inside the container
# $ docker ps; list running containers only
# $ docker ps -aq; list all container ids (-q quiet -a all running and killed)
# $ docker logs <container id>; Print app output
# $ docker exec -it <container id> /bin/bash; Execute code inside a container
# $ docker pause container <container-id or container-name>; Sends SIGSTOP (memory & disk are persisted)
# $ docker unpause container <container-id or container-name>;
# $ docker stop <container id>; Sends SIGTERM then 10s grace period later, SIGKILL (disk is persisted)
# $ docker kill <container id>; Sends SIGKILL
# $ docker rm <container id>; Remove container data e.g. processes, file system, volume & network mappings, etc.
# $ docker rm $(docker ps -aq); Remove all containers