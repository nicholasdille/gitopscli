GITLAB_DEBUG=false
GITLAB_HOST=
GITLAB_PROJECT=
GITLAB_PAT=

gitlab_branches() {
    curl --silent --header "Private-Token: ${GITLAB_PAT}" https://${GITLAB_HOST}/api/v4/projects/${GITLAB_PROJECT}/repository/branches | jq --raw-output '.[].name'
}
