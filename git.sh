: "${GIT_STATE:=${HOME}/.cache/gitopscli/git}"
: "${GIT_DEBUG:=false}"

assert_tools git

is_git_dir() {
    DIR=${1}
    ${GIT_DEBUG} && echo "### is_git_dir ${DIR}"
    test -d "${GIT_STATE}/${DIR}"
}

git_clone_bare() {
    URL=${1}
    DIR=$(url_fs ${URL})

    if ! is_git_dir ${DIR}; then
        ${GIT_DEBUG} && echo "### Cloning into ${DIR}"
        mkdir -p "${GIT_STATE}/${DIR}"
        git clone --bare --quiet ${URL} "${GIT_STATE}/${DIR}"
    else
        ${GIT_DEBUG} && echo "### Fetching into ${DIR}"
        git --git-dir "${GIT_STATE}/${DIR}" fetch --quiet
    fi
}

git_branches() {
    URL=${1}
    DIR=$(url_fs ${URL})
    git_clone_bare ${URL}
    ${GIT_DEBUG} && echo "### Branches for ${URL}"
    git --git-dir "${GIT_STATE}/${DIR}" branch --all --list | sed -E 's/^\*?\s+//'
}

git_new_branch() {
    URL=${1}
    BASE=${2}
    BRANCH=${3}

    git --git-dir "${GIT_STATE}/${DIR}" branch ${BRANCH} ${BASE}
    git --git-dir "${GIT_STATE}/${DIR}" push origin ${BRANCH}
}

git_remove_branch() {
    URL=${1}
    BRANCH=${2}

    git --git-dir "${GIT_STATE}/${DIR}" branch -D ${BRANCH}
    git --git-dir "${GIT_STATE}/${DIR}" push origin :${BRANCH}
}
