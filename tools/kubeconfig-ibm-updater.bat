@echo off
set SERVICEACCOUNT_NAME=kubeagentadmin
set SERVICEACCOUNT_NAMESPACE=kube-system
set KUBECONFIG_FILEPATH=.\kubeconfig

call kubectl config view current --minify=true --flatten -o yaml > %KUBECONFIG_FILEPATH%
set KUBECONFIG=%KUBECONFIG_FILEPATH%
echo Check kubernetes version using update with authority data kubeconfig at %KUBECONFIG_FILEPATH%
call kubectl version

set DESC_SERVICEACCOUNT=call kubectl describe serviceaccount %SERVICEACCOUNT_NAME% --namespace %SERVICEACCOUNT_NAMESPACE%
for /F "tokens=2 delims=:" %%G in ('%DESC_SERVICEACCOUNT% ^| find "Mountable secrets:"') do set SERVICEACCOUNT_SECRET_NAME=%%G
set SERVICEACCOUNT_SECRET_NAME=%SERVICEACCOUNT_SECRET_NAME: =%
echo Service Account %SERVICEACCOUNT_NAME%'s secret Name is %SERVICEACCOUNT_SECRET_NAME%

set DESC_SECRET=call kubectl describe secret %SERVICEACCOUNT_SECRET_NAME% --namespace %SERVICEACCOUNT_NAMESPACE%
for /F "tokens=2 delims=:" %%G in ('%DESC_SECRET% ^| find "token:"') do set SERVICEACCOUNT_SECRET_TOKEN=%%G
set SERVICEACCOUNT_SECRET_TOKEN=%SERVICEACCOUNT_SECRET_TOKEN: =%
echo %SERVICEACCOUNT_SECRET_TOKEN% > %SERVICEACCOUNT_NAME%.token
echo Service Account %SERVICEACCOUNT_NAME%'s secret %SERVICEACCOUNT_SECRET_NAME%'s token is generate at %SERVICEACCOUNT_NAME%.token

set QUERY_CURRENT_CONTEXT_CLUSTER="call kubectl config view current -o jsonpath={.contexts[0].context.cluster}"
for /F "tokens=*" %%G in ('%QUERY_CURRENT_CONTEXT_CLUSTER%') do set CURRENT_CLUSTER=%%G
set CURRENT_CLUSTER=%CURRENT_CLUSTER: =%
echo Current Kubernetes Configured Cluster in the Current Context is %CURRENT_CLUSTER%

call kubectl config set-credentials new-user --token=%SERVICEACCOUNT_SECRET_TOKEN%
call kubectl config set-context new-context --cluster=%CURRENT_CLUSTER% --user=new-user --namespace=%SERVICEACCOUNT_NAMESPACE%
call kubectl config use-context new-context
echo Update Configuration Down

echo Check kubernetes version for both server and client by the updated configuration
call kubectl version