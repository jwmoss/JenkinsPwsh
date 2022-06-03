## build
docker build . -t jenkinspwsh:1.0

## run
docker run --name jenkinspwsh --env-file env.list -p 8080:8080 -p 50000:50000 -d jenkinspwsh:1.0
