#!/bin/bash
opensips_server=$(kubectl get pods -n default -o wide | grep opensips | awk '{print $1}');
opensips_ip=$(kubectl get pods -n default -o wide | grep opensips | awk '{print $6}');
uas=$(kubectl get pods -n default -o wide | grep 'uas' | awk '{print $1}');
uac=$(kubectl get pods -n default -o wide | grep 'uac' | awk '{print $1}'); 
uac_ip=$(kubectl get pods -n default -o wide | grep 'uac' | awk '{print $6}');
uas_ip=$(kubectl get pods -n default -o wide | grep 'uas' | awk '{print $6}');

kubectl exec -i $uac -n default -- bash -c "export TERM=xterm && ./sipp -sf uac_mod.xml $opensips_ip:5060 -s chetan -i $uac_ip -p 5065  -m 100 -r 10 -rp 1000 " ;
