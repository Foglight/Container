@echo off
set SERVICEACCOUNT_NAME=kubeadm
set SERVICEACCOUNT_NAMESPACE=kube-system

set DESC_SERVICEACCOUNT=call kubectl describe serviceaccount %SERVICEACCOUNT_NAME% --namespace %SERVICEACCOUNT_NAMESPACE%
for /F "tokens=2 delims=:" %%G in ('%DESC_SERVICEACCOUNT% ^| find "Mountable secrets:"') do set SERVICEACCOUNT_SECRET=%%G
for /F "tokens=*" %%s in ("%SERVICEACCOUNT_SECRET%") do set _trimmed_secret=%%s
echo Service Account %SERVICEACCOUNT_NAME%'s secret Name is %_trimmed_secret%

set DESC_SECRET=call kubectl describe secret %_trimmed_secret% --namespace %SERVICEACCOUNT_NAMESPACE%
for /F "tokens=2 delims=:" %%G in ('%DESC_SECRET% ^| find "token:"') do set SERVICEACCOUNT_SECRET_TOKEN=%%G
for /F "tokens=*" %%s in ("%SERVICEACCOUNT_SECRET_TOKEN%") do set _trimmed_token=%%s
echo %_trimmed_token% > %SERVICEACCOUNT_NAME%.token
echo Service Account %SERVICEACCOUNT_NAME%'s secret %_trimmed_secret%'s token is generate at %SERVICEACCOUNT_NAME%.token

set QUERY_CURRENT_CONTEXT_CLUSTER="call kubectl config view current -o jsonpath={.contexts[0].context.cluster}"
for /F "tokens=*" %%G in ('%QUERY_CURRENT_CONTEXT_CLUSTER%') do set CURRENT_CLUSTER=%%G
for /F "tokens=*" %%s in ("%CURRENT_CLUSTER%") do set _trimmed_current_cluster=%%s
echo Current Kubernetes Configured Cluster in the Current Context is %_trimmed_current_cluster%

call kubectl config set-credentials new-user --token=%_trimmed_token%
call kubectl config set-context new-context --cluster=%_trimmed_current_cluster% --user=new-user --namespace=%SERVICEACCOUNT_NAMESPACE%
call kubectl config use-context new-context
echo Update Configuration Down

echo Check kubernetes version for both server and client by the updated configuration
call kubectl version