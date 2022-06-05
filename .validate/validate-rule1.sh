#!/bin/bash


svc=`for f in ./manifest/*; do cat ${f} | yq '(.|select(.kind == "Service")).metadata.name' ; done`
deployment=`for f in ./manifest/*; do cat ${f} | yq '(.|select(.kind == "Deployment")).metadata.name' ; done`



kubectl get deployment $deployment >/dev/null  2>&1

RET=$?


if [[ $RET != 0 ]]; then
    echo "查無apps/v1 Deployment: $deployment"
    exit 1
fi


kubectl get svc $svc >/dev/null  2>&1

RET=$?


if [[ $RET != 0 ]]; then
    echo "查無core/v1 Service: $svc"
    exit 1
fi