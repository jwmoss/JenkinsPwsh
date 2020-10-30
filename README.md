# Jenkinspwsh

* Jenkins Server with Powershell installed

## Build the image

```bash
docker build . -t jenkinspwsh:1.0 -f ./dockerfile
```

## Run the image

```bash
docker run --name jenkinspwsh -p 8080:8080 -p 50000:50000 -d jenkinspwsh
```

## Check the logs

```bash

```

## Start over

```bash
docker rm -f $(docker ps -a -q)
```
