#!/bin/bash

mkdir ${pagename}pvpvc
echo " 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: ${pagename}vol
spec:
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: 192.168.1.101
    path: /${pagename} " > ~/test/$pagename/${pagename}pvpvc/${pagename}pv.yml


echo "
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ${pagename}pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 50Mi" > ~/test/$pagename/${pagename}pvpvc/${pagename}pvc.yml


kubectl apply -f ~/test/$pagename/${pagename}pvpvc/.