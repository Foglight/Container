## tools ##
This folder contains tools for Foglight for Container Management

Prerequisite:
 - kubectl installed
 - kubectl can connect to the kubernetes cluster
 - service account already exist

Tools
 - kubeconfig-updater.bat: windows batch file to update default kubeconfig to Kubernetes Agent credential. supported cloud platforms (AKS, GKE, Openshift, EKS)
 - kubeconfig-updater.sh: linux shell script to update default kubeconfig to Kubernetes Agent credential. supported cloud platforms (AKS, GKE, Openshift, EKS)
 - kubeconfig-ibm-updater.bat: windows batch file to update default kubeconfig to Kubernetes Agent credential. supported cloud platforms (IBM Cloud Kubernetes Service)
 - kubeconfig-ibm-updater.sh: linux shell script to update default kubeconfig to Kubernetes Agent credential. supported cloud platforms (IBM Cloud Kubernetes Service)
 
How to use:
Open the .sh or .bat file and change the SERVICEACCOUNT_NAME and SERVICEACCOUNT_NAMESPACE to your service account name and namespaces.
Then run the script in the command line or shell. 
At the end of this file, it will use kubectl version to check if new credential can access to your cluster.