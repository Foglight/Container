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