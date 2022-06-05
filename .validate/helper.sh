#!/bin/bash


deployment=`for f in ./manifest/*; do cat ${f} | yq '(.|select(.kind == "Deployment")).metadata.name' ; done`


ready="false"

for i in {1..60}; do 
    ready=`oc get deployments.apps nginx-deployment >/dev/null  2>&1  && oc get deployments.apps nginx-deployment -o yaml |  yq .status.readyReplicas==.status.replicas`

	if [ "$ready" == "true" ]; then 
		break
	fi 
    echo "deployment not ready, sleep 1 sec"
    sleep 1
done