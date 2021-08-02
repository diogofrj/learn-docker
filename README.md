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
    docker container logs -f [CONTAINER ID]
    docker container rm [CONTAINER ID]
    docker container attach [CONTAINER ID]
    docker container rm -f [CONTAINER ID]
    docker container exec -ti [CONTAINER ID] [COMANDO]
    docker container run -d nginx