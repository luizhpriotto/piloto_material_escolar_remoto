#!/bin/bash
kubectl run kaniko-$(git rev-parse --abbrev-ref HEAD) -n build \
--rm --stdin=true \
--image=gcr.io/kaniko-project/executor:latest --restart=Never \
--overrides='{
  "apiVersion": "v1",
  "spec": {
    "containers": [
      {
        "name": "kaniko-'$(git rev-parse --abbrev-ref HEAD)'",
        "image": "gcr.io/kaniko-project/executor:latest",
        "stdin": true,
        "stdinOnce": true,
        "args": [
          "--dockerfile=Dockerfile",
          "--context='"$(git config remote.origin.url | sed -r 's/https/git/g')"'",
	        "--git=branch='"$(git rev-parse --abbrev-ref HEAD)"'",
          "--cache-ttl=24h",
	        "--cache-copy-layers",
	        "--cache-dir=/cache",
          "--destination='$1':'tilt-"$(git rev-parse --abbrev-ref HEAD)"'"
        ],
        "volumeMounts": [
          {
            "name": "docker-config",
            "mountPath": "/kaniko/.docker/"
          },
          {
            "name": "cache",
            "mountPath": "/cache",
            "subPath": "cache",
            "readOnly": false
          }
        ]
      }
    ],
    "volumes": [
      {
        "name": "docker-config",
        "projected": {
           "sources": [
             {
               "secret": {
                 "items": [
                   {
                     "key": ".dockerconfigjson",
                     "path": "config.json"
                   }
                 ],
                 "name": "regcred"
               }
             }
           ]
        }
      },
      {
        "name": "cache",
        "persistentVolumeClaim": {
	         "claimName": "kaniko",
           "persistentVolumeClaimId": "build:kaniko",
           "readOnly": false
        }
      }
    ]
  }
}'
