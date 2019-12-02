: "${DOCKER_STATE:=${HOME}/.cache/gitopscli/docker}"
: "${DOCKER_DEBUG:=false}"

assert_tools docker

get_docker_instances() {
    docker container ls --all --filter status=running --format "{{.Names}}"
}

new_docker_instance() {}

remove_docker_instance() {}
