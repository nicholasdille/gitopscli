: "${K8S_STATE:=${HOME}/.cache/gitopscli/k8s}"
: "${K8S_DEBUG:=false}"
: "${K8S_TIMEOUT:=5}"

assert_tools kubectl

k8s_ping() {
    local kubeconfig=$1
    timeout ${K8S_TIMEOUT} kubectl --kubeconfig=${kubeconfig} cluster-info 2>&1 >/dev/null
}

k8s_get_nodes() {
    local kubeconfig=$1
    local params=$2
    kubectl --kubeconfig=${kubeconfig} get nodes $params
}

k8s_count_nodes() {
    local kubeconfig=$1
    k8s_get_nodes ${kubeconfig} "-o json" | jq '.items | length'
}
