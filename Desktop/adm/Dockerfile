#Stage 1 - Install dependencies and build the app in a build environment
FROM debian:latest AS build-env

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# Install flutter dependencies
RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 sed
RUN apt-get clean
# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
# Set flutter path
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"
# Run flutter doctor
RUN flutter doctor -v
RUN flutter channel master
RUN flutter upgrade
# Copy files to container and build
RUN mkdir /adm/
COPY . /adm/
WORKDIR /adm/
RUN flutter build web
# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
COPY --from=build-env /adm/build/web /usr/share/nginx/html

EXPOSE 8080
ENV PORT 8080
ENV HOST 0.0.0.0