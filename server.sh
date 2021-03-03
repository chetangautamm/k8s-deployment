#!/bin/bash

opensips_server=$(kubectl get pods -n default -o wide | grep opensips | awk '{print $1}');
opensips_ip=$(kubectl get pods -n default -o wide | grep opensips | awk '{print $6}');
uas=$(kubectl get pods -n default -o wide | grep 'uas' | awk '{print $1}');
uac=$(kubectl get pods -n default -o wide | grep 'uac' | awk '{print $1}'); 
uac_ip=$(kubectl get pods -n default -o wide | grep 'uac' | awk '{print $6}');
uas_ip=$(kubectl get pods -n default -o wide | grep 'uas' | awk '{print $6}');

kubectl exec -i $uas -n default -- bash -c "export TERM=xterm && ./sipp -sf uas_mod_orig.xml -rsa $opensips_ip:5060 -i $uas_ip -p 5080 " ;
#kubectl exec -i $uas -n default -- bash -c "kill -INT 888"
