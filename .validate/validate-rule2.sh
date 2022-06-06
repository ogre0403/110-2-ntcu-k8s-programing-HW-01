#!/bin/bash


echo ""
echo "測試是否能連通Web Deployment"


cid=`docker ps -f name=control-plane -q`


svc=`for f in ./manifest/*; do cat ${f} | yq '(.|select(.kind == "Service")).metadata.name' ; done`


nodeport=`kubectl get svc ${svc} -o jsonpath='{.spec.ports[0].nodePort}'`


for i in {1..20}; do

  docker exec ${cid} curl 127.0.0.1:${nodeport}  >/dev/null  2>&1
  RET=$?

  if [[ ${RET} -eq 0 ]]; then
    echo "........ PASS"
    exit 0
  fi

  sleep 3
done

echo "timeout for wait for connect deployment ${deployment} success"
exit 1

