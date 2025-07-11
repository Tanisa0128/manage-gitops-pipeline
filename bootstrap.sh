#!/usr/bin/env bash

set -o errexit

CLUSTER_NAME=$1
GIT_REPO=$2
GITHUB_USER=Tanisa0128
if [ -z "$CLUSTER_NAME" ] || [ -z "$GIT_REPO" ]; then
echo "Usage :$0 <CLUSTER_NAME> <GIT_REPO>"
exit 1
fi

function prepare_kind_config() {

  export CLUSTER_NAME
  envsubst < kind-config-template.yaml > kind-config-$CLUSTER_NAME.yaml
}
function create_cluster(){
  echo "Creating Kind Cluster: $CLUSTER_NAME"
  kind create cluster --config kind-config-$CLUSTER_NAME.yaml
}
function bootstrap_flux(){
  echo "waiting for nodes to be ready..."
  kubectl wait --for=condition=Ready nodes --all --timeout=120s
  echo "Bootstrapping Flux with repo: $GIT_REPO"
  flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=$GIT_REPO \
  --branch=main \
  --path=clusters/$CLUSTER_NAME \
  --personal \
  --token=$GITHUB_TOKEN
  kubectl get pods -n flux-system
}
function main(){
  prepare_kind_config
  create_cluster
  bootstrap_flux
}
main
