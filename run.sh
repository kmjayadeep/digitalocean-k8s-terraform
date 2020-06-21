#/bin/sh

DO_TOKEN=$(cat ~/.config/doctl/config.yaml | grep token | cut -d ' ' -f 2)

plan(){
  terraform plan \
    -var "do_token=${DO_TOKEN}"
}

display() {
  echo "DO_TOKEN=$DO_TOKEN"
}

apply(){
  terraform apply \
    -var "do_token=${DO_TOKEN}"
}

kubeconfig(){
  doctl kubernetes cluster kubeconfig save $CLUSTER
}

ip(){
  kubeconfig
  kubectl get svc ingress-nginx-controller -n ingress-nginx -o=jsonpath='{.status.loadBalancer.ingress[0].ip}'
}

case $1 in
    plan)
      plan
    ;;
    apply)
      apply
      ip
    ;;
    display)
      display
    ;;
    kubeconfig)
      kubeconfig
    ;;
    ip)
      ip
    ;;
    *)
      echo "usage: $0 plan/apply/display/kubeconfig/ip"
    ;;
esac
