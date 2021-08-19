# learn-docker

## Dia01 :smile:

### Links

[https://docs.docker.com/install](https://docs.docker.com/install)


### Comandos

    docker container ls
    docker run -it ubuntu bash
    docker container run hello-world
    docker image ls
    docker ps
    docker container ls
    docker container ls -a
    docker container run -ti centos:7
    docker container run -ti ubuntu
    docker container run -d nginx
    docker container attach [CONTAINER ID]
    docker container exec -ti [CONTAINER ID] [COMANDO]
    docker container start [CONTAINER ID]
    docker container stop [CONTAINER ID]
    docker container restart [CONTAINER ID]
    docker container pause [CONTAINER ID]
    docker container unpause [CONTAINER ID]
    docker container inspect [CONTAINER ID] 
        docker container inspect -f '{{ .NetworkSettings.IPAddress }}' [CONTAINER_ID_OR_NAME]
        docker container inspect -f '{{ .NetworkSettings.Networks.bridge.IPAddress }}' [6f27c7b5485e]
    docker container logs -f [CONTAINER ID]
    docker container rm [CONTAINER ID]
    docker container attach [CONTAINER ID]
    docker container rm -f [CONTAINER ID]
    docker container exec -ti [CONTAINER ID] [COMANDO]
    docker container run -d nginx
    docker container stats [CONTAINER ID]
    docker container top [CONTAINER ID]
    docker container run -d -m 128M --cpus 0.5 nginx
    docker container update --memory 64M --cpus 0.4 nginx
    docker container inspect [CONTAINER ID]
    docker container stats [CONTAINER ID]
    docker container top [CONTAINER ID]
    
**Comando executados dentro do container:**
    
    apt-get update
    apt-get install stress
    stress --cpu 1 --vm-bytes 128M --vm1

```
docker image build -t toskeira:1.0
docker image ls
docker container run -d toskeira:1.0
docker container logs -f [CONTAINER ID]
```

### No Dockerfile

```dockerfile
FROM debian
LABEL app="testdocker"
ENV DFS="prod"
RUN apt-get update && apt-get install -y curl stress && apt-get clean
CMD stress --cpu 1 --vm-bytes 64M --vm 1
```

**Volumes Tipo bind:**

/opt/dfs
docker container run -ti --mount type=bind,src=/opt/dfs,dst=/dfs,ro debian
docker volume create dfs
docker volume inspect dfs
```json
[
    {
        "CreatedAt": "2021-08-03T03:21:19Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/dfs/_data",
        "Name": "dfs",
        "Options": {},
        "Scope": "local"
    }
]
```

    docker container run -ti --mount type=volume,src=dfs,dst=/dfs debian
    docker exec -ti [CONTAINER ID] touch /dfs/teste1
    docker volume rm dfs 

    docker container prune
    docker volume prune
    docker image prune

    docker container create -v /opt/dfs --name dbdados centos #old sintaxe

docker run -d -p 5432:5432 --name pgsql1 --volumes-from dbdados -e POSTGRESQL_USER=docker -e POSTGRESQL_docker -e POSTGRESQL_DB=docker kamui/postgresql #old volume-from sintaxe

