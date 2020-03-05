GITLAB_DEBUG=false
GITLAB_HOST=
GITLAB_PROJECT=
GITLAB_PAT=

gitlab_branches() {
    curl --silent --header "Private-Token: ${GITLAB_PAT}" https://${GITLAB_HOST}/api/v4/projects/${GITLAB_PROJECT}/repository/branches | jq --raw-output '.[].name'
}

gitlab_branch_diff() {
    local from=$1
    local to=$2
    curl --silent --header "Private-Token: ${GITLAB_PAT}" "https://${GITLAB_HOST}/api/v4/projects/${GITLAB_PROJECT}/repository/compare?from=${from}&to=${to}&straight=true" | jq --raw-output '.diffs[].diff'
}
