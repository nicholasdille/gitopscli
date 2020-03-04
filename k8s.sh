: "${K8S_STATE:=${HOME}/.cache/gitopscli/k8s}"
: "${K8S_DEBUG:=false}"
: "${K8S_TIMEOUT:=5}"

assert_tools kubectl

k8s_ping() {
    local kubeconfig=$1
    timeout ${K8S_TIMEOUT} kubectl --kubeconfig=${kubeconfig} cluster-info 2>&1 >/dev/null
}
