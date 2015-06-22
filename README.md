# docker-php

A [Docker](https://docker.com/) container for [PHP](http://php.net/) version 5.6 that runs PHP in FPM (FastCGI Process Manager) mode.

Configuration, PHP extensions and other tools built into the image are primarily aimed for the developers that are using [Drupal](https://www.drupal.org/) as their primary development framework.

## Run the container

Using the `docker` command:

    CONTAINER="php" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      -e SERVER_NAME="localhost" \
      -e DRUPAL_VERSION="8" \
      -e TIMEZONE="UTC" \
      -e POST_MAX_SIZE="512M" \
      -e UPLOAD_MAX_FILESIZE="512M" \
      -e SHORT_OPEN_TAG="On" \
      -e MAX_EXECUTION_TIME="300" \
      -e MAX_INPUT_VARS="4096" \
      -e MEMORY_LIMIT="512M" \
      -e DISPLAY_ERRORS="On" \
      -e DISPLAY_STARTUP_ERRORS="On" \
      -e ERROR_REPORTING="E_ALL" \
      -e OPCACHE="On" \
      -e OPCACHE_MEMORY_CONSUMPTION="2048" \
      -e XDEBUG="On" \
      -e XDEBUG_IDEKEY="PHPSTORM" \
      -e MEMCACHED="On" \
      -e REDIS="On" \
      -e BLACKFIRE="On" \
      -e APCU="On" \
      -e APD="On" \
      -d \
      viljaste/php:5.6

Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.6 \
      && sudo docker-compose up

## Build the image

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.6 \
      && sudo docker build -t viljaste/php:5.6 . \
      && cd -

## License

**MIT**
