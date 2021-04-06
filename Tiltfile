#path of docker compose
#docker_compose('docker-compose-tilt.yml')

#valida se o contexts é o demo, para evitar possíveis problemas
#load('ext://restart_process', 'custom_build_with_restart')
allow_k8s_contexts('demo')

k8s_yaml(['configmap.yaml', 'deployments.yaml', 'ingress.yaml', 'services.yaml'])

custom_build(
  # Image name - must match the image in the docker-compose file
  'luizhpriotto/material-escolar-beckend:tilt-master',

  #custom command, in this case a script, you should pass the same os image as a parameter.
  './kaniko.sh luizhpriotto/material-escolar-beckend',

  # Docker context
  '.',

  #entrypoint='',
  disable_push=True,
  skips_local_docker=True,
  #Fixind a tag, because Tilt generate a dynamic tag
  tag = 'tilt-master',

  #live updte for hot reload
  live_update = [
    
    # Sync local files into the container.
    sync('.', '/code'),
    #sync('.', '/var/www/app/'),

    # Re-run npm install whenever package.json changes.
    #run('npm i', trigger='package.json'),
    #python -m pip --no-cache install -r requirements/production.txt
    run('python -m pip --no-cache install -r requirements/production.txt', trigger='requirements/production.txt'),
    run('python -m pip --no-cache install -r requirements/production.txt', trigger='requirements/base.txt'),
    run('ps -afx |grep python | awk "{print $1}" | xargs kill -9')
    #restart_container()
  ])
