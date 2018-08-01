# Container
Container Agents Related Resources

## heapster ##
This folder contains the heapster service deployment yaml files which you can use to deploy the service onto your cluster.
You can download the files into your folder [folderpath], then deploy the service through:
```
kubectl create -f [folderpath]
```
Default Configuration:
 - Namespace: kube-system
 - Name: heapster

The above configuration can be used to configure the Kubernetes Agent Properties (Heapster Namespace and Heapster Service Name).

## serviceaccount ##
This folder contains the service account deployment yaml files. This service account is binding to a cluster-admin cluster role to accessing all the kubernetes namespaces components.
You can download the files into your folder [folderpath], then deploy the service through:
```
kubectl create -f [folderpath]
```
Default Configuration:
 - Namespace: kube-system
 - Service Account Name: kubeagentadmin
 - Cluster Role: cluster-admin