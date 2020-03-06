apps() {
    APPS=($(gitlab_subgroups))
    CLUSTER=svc-2

    declare -a NAMESPACES
    for INDEX in ${!APPS[*]}; do
        NAMESPACES[$INDEX]=$(k8s_get_namespaces "${GOCLI_DIR}/clusters/${CLUSTER}_kubeconfig" | grep -i "${APPS[$INDEX]}" | xargs echo | tr ' ' ',')
    done

    (
        echo "Name Namespace"
        for INDEX in ${!APPS[*]}; do
            echo "${APPS[$INDEX]} ${NAMESPACES[$INDEX]}"
        done
    ) | column -t
}
