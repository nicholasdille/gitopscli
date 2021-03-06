CLUSTER_DEFAULT_BRANCH=template

clusters() {
    CLUSTERS=($(gitlab_branches))
    #>&2 echo "### Found ${#CLUSTERS[*]} clusters"

    declare -a WORKS
    declare -a DIFFS
    declare -a NODES
    #for CLUSTER in ${CLUSTERS[*]}; do
    for INDEX in ${!CLUSTERS[*]}; do
        CLUSTER=${CLUSTERS[$INDEX]}
        #echo "### Cluster ${CLUSTER}"

        DIFF=$(gitlab_branch_diff ${CLUSTER_DEFAULT_BRANCH} ${CLUSTER})
        ADDS=$(echo "${DIFF}" | grep -E '^+' | wc -l)
        REMOVES=$(echo "${DIFF}" | grep -E '^-' | wc -l)
        DIFFS[$INDEX]="+${ADDS}-${REMOVES}"

        if ! rt_get_artifact hmg-devinfra-generic/k8s/${CLUSTER}/kubeconfig.aes >"${GOCLI_DIR}/clusters/${CLUSTER}_kubeconfig.aes"; then
            #echo "EEE Unable to download kubeconfig"
            WORKS[$INDEX]="!download"
            rm "${GOCLI_DIR}/clusters/${CLUSTER}_kubeconfig.aes"
            continue
        fi
        #echo "III Found kubeconfig"

        if ! cat "${GOCLI_DIR}/clusters/${CLUSTER}_kubeconfig.aes" | openssl_decrypt >"${GOCLI_DIR}/clusters/${CLUSTER}_kubeconfig"; then
            #echo "EEE Unable to decrypt kubeconfig"
            WORKS[$INDEX]="!decrypt"
            rm "${GOCLI_DIR}/clusters/${CLUSTER}_kubeconfig"
            continue
        fi
        #echo "III Decrypted kubeconfig"

        if k8s_ping "${GOCLI_DIR}/clusters/${CLUSTER}_kubeconfig"; then
            #echo "III Accessible"
            WORKS[$INDEX]="Ok"
        else
            #echo "EEE Not accessible"
            WORKS[$INDEX]="!available"
            continue
        fi

        NODES[$INDEX]="$(k8s_count_nodes "${GOCLI_DIR}/clusters/${CLUSTER}_kubeconfig")"
    done

    (
        echo "Name Changes Available Nodes"
        for INDEX in ${!CLUSTERS[*]}; do
            echo "${CLUSTERS[$INDEX]} ${DIFFS[$INDEX]} ${WORKS[$INDEX]} ${NODES[$INDEX]}"
        done
    ) | column -t
}
