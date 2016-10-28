#!/usr/bin/env bash

if ! sudo gcloud compute disks describe yumo-registry &> /dev/null
    then sudo gcloud compute disks create --size 50GB yumo-registry
fi

kubectl apply -f Deployment.yml
kubectl apply -f Service.yml