assert_tools() {
    while [[ "$#" -gt "0" ]]; do
        if ! type ${1} >/dev/null 2>&1; then
            echo "Missing tool: ${1}"
            exit 1
        fi
        shift
    done
}

url_fs() {
    URL=${1}
    echo ${URL} | sed -E 's|^https?://||'
}