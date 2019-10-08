# ocp3-grafana6-custom

## Create a new project
```
oc new-project build-grafana6
```

## Create secret that will be used to pull images (needed for rhel7-minimum)
```
oc create secret docker-registry your-secret-name \
    --docker-server=registry.redhat.io \
    --docker-username='ANUMBER|your-sa-name' \
    --docker-password='REPLACEME'
```

## link secret for pulling
```
oc secrets link default your-secret-name --for=pull
```

## link secret for the builder
```
oc secrets link builder your-secret-name
```

## Create a new build config from the Dockerfile in your git repo
```
oc new-build --name=grafana6-custom \
--strategy=docker \
https://github.com/worsco/ocp3-grafana6-custom.git
```

## Start the build
```
oc start-build grafana6-custom
```
