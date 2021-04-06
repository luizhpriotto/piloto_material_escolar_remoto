#!/bin/bash
sed -e "s/\${tag}/tilt-$(git rev-parse --abbrev-ref HEAD)/" deployments-template.yaml > deployments.yaml
sed -e "s/\${tag}/tilt-$(git rev-parse --abbrev-ref HEAD)/" Tiltfile-template > Tiltfile
#sudo usermod -a -G docker $USER
#if [ ! -f ./tilt ]; then
#   curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
#fi
kubectl create configmap -n build --dry-run material-escolar-backend --from-env-file=.env --output yaml | tee configmap.yaml 
tilt up
##FIM
