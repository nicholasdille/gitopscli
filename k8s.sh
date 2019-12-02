: "${K8S_STATE:=${HOME}/.cache/gitopscli/k8s}"
: "${K8S_DEBUG:=false}"

assert_tools kubectl

get_k8s_instances() {}

new_k8s_instance() {}

remove_k8s_instance() {}
