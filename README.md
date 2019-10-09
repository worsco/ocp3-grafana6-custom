# ocp3-grafana6-custom

## Switch to the openshift-monitoring project
```
oc project openshift-monitoring
```

## Create secret that will be used to pull images (needed for rhel7-minimum)
```
oc create secret docker-registry your-secret-name \
    --docker-server=registry.redhat.io \
    --docker-username='A_NUMBER|your-container-service-account-name' \
    --docker-password='YOUR_LONG_HASH_PASSWORD'
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

### Alternatively from local directory of cloned repo

```
oc new-build --name=grafana6-custom \
--strategy=docker \
--from-repo="."
```


## Start the build
```
oc start-build grafana6-custom
```
