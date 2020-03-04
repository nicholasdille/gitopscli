RT_HOST=
RT_USER=
RT_PASS=

rt_get_artifact() {
    local rt_path=$1
    curl --silent --fail --user "${RT_USER}:${RT_PASS}" https://${RT_HOST}/artifactory/${rt_path}
}
