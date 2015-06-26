#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php_blackfire_server_token.yml"

container() {
  echo "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps php | grep php | awk '{ print $1 }')"
}

setup() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up -d --allow-insecure-ssl

  sleep 10
}

teardown() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" kill
  docker-compose -f "${DOCKER_COMPOSE_FILE}" rm --force
}

@test "php: blackfire" {
  run docker exec "$(container)" /bin/su - root -mc "php -m | grep 'blackfire.server_token'"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"91bde3fa9350479ba84f90acab46b680142c0f6fe8154a649e82d0d2ddadfa93"* ]]
}
