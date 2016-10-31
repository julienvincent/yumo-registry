#!/usr/bin/env bash

export IMAGE_NAME=gcr.io/yumo-1384/registry:$((1 + RANDOM % 10000000000))

if ! sudo gcloud compute disks describe yumo-registry &> /dev/null
    then sudo gcloud compute disks create --size 50GB yumo-registry
fi

docker build -t yumo/registry .
docker tag yumo/registry ${IMAGE_NAME}
gcloud docker push ${IMAGE_NAME}

envsubst < Deployment.yml > parsed-deployment.yml

kubectl apply -f parsed-deployment.yml
kubectl apply -f Service.yml

rm -rf parsed-deployment.yml