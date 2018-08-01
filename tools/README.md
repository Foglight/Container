## tools ##
This folder contains tools for Foglight for Container Management

Prerequisite:
 - kubectl installed
 - kubectl can connect to the kubernetes cluster
 - service account already exist

Tools
 - serviceaccount-token-retriver.bat: generate token for service account under windows platform.
 - serviceaccount-token-retriver.sh: linux shell script to generate service account token to a file

How to use:
Open the .sh or .bat file and change the SERVICEACCOUNT_NAME and SERVICEACCOUNT_NAMESPACE to your service account name and namespaces.
Then run the script in the command line or shell. 
At the end of this file, it will use kubectl version to check if new credential can access to your cluster.