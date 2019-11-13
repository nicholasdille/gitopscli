: "${GITHUB_STATE:=${HOME}/.cache/gitopscli/github}"
: "${GITHUB_DEBUG:=false}"

assert_tools curl jq

github_branches() {
    OWNER=${1}
    REPO=${2}

    curl -sf https://api.github.com/repos/${OWNER}/${REPO}/branches | jq --raw-output '.[].name'
}

github_new_branch() {
    OWNER=${1}
    REPO=${2}
    BASE=${3}
    BRANCH=${4}

    git_new_branch "https://github.com/${OWNER}/${REPO}" ${BASE} ${BRANCH}
}

github_remove_branch() {
    OWNER=${1}
    REPO=${2}
    BRANCH=${3}

    git_remove_branch "https://github.com/${OWNER}/${REPO}" ${BRANCH}
}
