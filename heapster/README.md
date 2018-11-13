## heapster ##
### Install kubectl command line tool ###
Install from https://kubernetes.io/docs/tasks/tools/install-kubectl/.
### Prepare KubeConfig file ###
KubeConfig file is used as a credential for the kubernetes client access to the cluster. 
Get KubeConfig from your kubernetes cluster and put it at [local path to kubeconfig]
### Set environment variable ###
windows: set KUBECONFIG=[local path to kubeconfig]
linux: export KUBECONFIG=[local path to kubeconfig]
### Deploy Sample Heapster ###
Download the files in this folder: It contains the heapster service deployment yaml files which you can use to deploy the service onto your cluster. You can download the files into your folder [folderpath], then deploy the service through:
```
kubectl create -f [folderpath]
```
Default Configuration:
 - Namespace: kube-system
 - Name: heapster

### Note ###
The above configuration can be used to configure the Kubernetes Agent Properties (Heapster Namespace and Heapster Service Name).
