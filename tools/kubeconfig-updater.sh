#!/bin/bash
set +H
export SERVICEACCOUNT_NAME=kubeadmin
export SERVICEACCOUNT_NAMESPACE=kube-system

KUBE_SERVICEACCOUNT_SECRET=$(kubectl describe serviceaccount $SERVICEACCOUNT_NAME --namespace $SERVICEACCOUNT_NAMESPACE | grep -o 'Mountable secrets:.*' | awk '{split($0,a,":"); print a[2]}')
echo Service Account $SERVICEACCOUNT_NAME secret name is $KUBE_SERVICEACCOUNT_SECRET.

KUBE_SERVICEACCOUNT_SECRET_TOKEN=$(kubectl describe secret $KUBE_SERVICEACCOUNT_SECRET --namespace $SERVICEACCOUNT_NAMESPACE | grep -o 'token:.*' | awk '{split($0,a,":"); print a[2]}')
echo $KUBE_SERVICEACCOUNT_SECRET_TOKEN > $SERVICEACCOUNT_NAME.token
echo Service Account $SERVICEACCOUNT_NAME secret $KUBE_SERVICEACCOUNT_SECRET token is generated at $SERVICEACCOUNT_NAME.token

#Update default kubeconfig, add new context with new user credential to the current cluster.
KUBE_CURRENT_CLUSTER=$(kubectl config view current --minify=true -o jsonpath={.contexts[0].context.cluster})
echo Current kubernetes configured cluster in the current context is $KUBE_CURRENT_CLUSTER

kubectl config set-credentials new-user --token $KUBE_SERVICEACCOUNT_SECRET_TOKEN
kubectl config set-context new-context --cluster=$KUBE_CURRENT_CLUSTER --user=new-user --namespace=$SERVICEACCOUNT_NAMESPACE
kubectl config use-context new-context
echo Update default kubeconfig done. will check kubernetes version with new kubeconfig

kubectl version