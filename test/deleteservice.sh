#!/bin/bash
b=1
# deleting -> $1, deletepagename -> $2
if [ $1 -eq $b ];
then
        if [ $2 = "default"]
        then
                rm -rf $2
                kubectl delete cm ${2}cm
                kubectl delete deployment ${2}
                kubectl delete svc ${2}
        else
                rm -rf $2
                kubectl delete cm ${2}cm
                kubectl delete deployment ${2}
                kubectl delete svc ${2}
                grep -n $2 ~/ingress/test/ingress-config.yml > a.txt
                d=`awk -F : '{print $1}' a.txt`
                e=`expr $d + 6`
                sed "$d, ${e}d" ~/ingress/test/ingress-config.yml > b.txt
                cat b.txt > ~/ingress/test/ingress-config.yml
        fi
else