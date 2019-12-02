: "${DOCKER_COMPOSE_STATE:=${HOME}/.cache/gitopscli/docker-compose}"
: "${DOCKER_COMPOSE_DEBUG:=false}"

assert_tools docker-compose

get_docker_compose_instances() {}

new_docker_compose_instance() {}

remove_docker_compose_instance() {}
