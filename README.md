# Jenkinspwsh

* Jenkins Server with Powershell installed

## Build the image

```bash
docker build . -t jenkinspwsh -f ./dockerfile
```

## Run the image

```bash
docker run -p 8080:8080 -p 50000:50000 -d jenkinspwsh -n jenkinspwsh
```

## Start over

```bash
docker rm -f $(docker ps -a -q)
```
