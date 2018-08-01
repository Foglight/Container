# Container
Container Agents Related Resources

## heapster ##
This folder contains the heapster service deployment yaml files which you can use to deploy the service onto your cluster.
You can download the files into your folder [folderpath], then deploy the service through:
```
kubectl create -f [folderpath]
```
Heapster Default Configuration:
 - Namespace: kube-system
 - Name: heapster

The above configuration can be used to configure the Kubernetes Agent Properties (Heapster Namespace and Heapster Service Name).
