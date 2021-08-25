# learn-docker

## Dia01 :smile:

### Links

[https://docs.docker.com/install](https://docs.docker.com/install)

    sudo apt-get update
    sudo apt-get install     apt-transport-https     ca-certificates     curl     gnupg     lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    sudo su -
    echo $USER
    sudo usermod -aG docker $USER

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

## Dia02 :smile:
CONTAINER

    docker container create -v /opt/giro/:/data --name dbdados centos
    docker container run -d -p 5432:5432 --name pgsql1 --volumes-from dbdados -e POSTGRESQL_USER=docker -e POSTGRESQL_docker -e POSTGRESQL_DB=docker kamui/postgresql
    docker container run -d -p 5433:5432 --name pgsql2 --volumes-from dbdados -e POSTGRESQL_USER=docker -e POSTGRESQL_docker -e POSTGRESQL_DB=docker kamui/postgresql

BIND

    docker container run -ti --mount type=bind,src=/opt/giro,dst=/giro debian
    docker container run -ti --mount type=bind,src=/opt/giro,dst=/giro,ro debian

VOLUME


    docker container run -it --mount type=volume,src=giro,dst=/giromount debian
    docker container rm -f 7887824c5407
    docker volume rm giro
    
    docker volume create dbdados
    docker volume ls
    docker container run -d -p 5432:5432 --name pgsql1 --mount type=volume,src=dbdados,dst=/data -e POSTGRESQL_USER=docker -e POSTGRESQL_docker -e POSTGRESQL_DB=docker kamui/postgresql
    
    docker container run -d -p 5433:5432 --name pgsql2 --mount type=volume,src=dbdados,dst=/data -e POSTGRESQL_USER=docker -e POSTGRESQL_docker -e POSTGRESQL_DB=docker kamui/postgresql
    
    docker container ls -a 
    docker volume ls    
    docker volume inspect dbdados 

BACKUP


    docker container run -ti --mount type=volume,src=dbdados,dst=/data --mount type=bind,src=/opt/backup,dst=/backup debian tar -cvf /backup/bkp-banco.tar /data 
    
    docker container run -ti --mount type=bind,src=/volume,dst=/volume ubuntu
    docker container run -ti --mount type=bind,src=/root/primeiro_container,dst=/volume ubuntu
    docker container run -ti --mount type=bind,src=/root/primeiro_container,dst=/volume,ro ubuntu
    docker volume create giropops
    docker volume rm giropops
    docker volume inspect giropops
    docker volume prune
    docker container run -d --mount type=volume,source=giropops,destination=/var/opa  nginx
    docker container create -v /data --name dbdados centos
    docker run -d -p 5432:5432 --name pgsql1 --volumes-from dbdados -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -e POSTGRESQL_DB=docker kamui/postgresql
    docker run -d -p 5433:5432 --name pgsql2 --volumes-from dbdados -e  POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -e POSTGRESQL_DB=docker kamui/postgresql
    docker run -ti --volumes-from dbdados -v $(pwd):/backup debian tar -cvf /backup/backup.tar /data


DOCKERFILE

```dockerfile
FROM debian

RUN apt-get update && apt-get install -y apache2 && apt-get clean
RUN chown www-data:www-data /var/lock && chown www-data:www-data /var/run/ && chown www-data:www-data /var/log/
ENV APACHE_LOCK_DIR="/var/lock"
ENV APACHE_PID_FILE="/var/run/apache2.pid"
ENV APACHE_RUN_USER="www-data"
ENV APACHE_RUN_GROUP="www-data"
ENV APACHE_LOG_DIR="/var/log/apache2"

ADD index.html /var/www/html

LABEL description="Webserver"
LABEL version="1.1"

USER www-data

WORKDIR /var/www/html/

VOLUME /var/www/html/
EXPOSE 80

ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D", "FOREGROUND"]

```
    docker image build -t meu_apache:2.0.0 .
    docker image build -t meu_apache:2.0.0 . --no-cache
    docker container run -it -p 8080:80
    docker container run -ti -P # pega a porta do expose e escolhe uma aleatorea
    
    docker container run -ti meu_apache:1.0.0
    docker container run -ti meu_apache:2.0.0
    
    docker container run -d -p 8080:80 meu_apache:2.0.0
    
    docker image build -t meu_apache:4.0.0 .
    docker container run -d -p 8000:80 meu_apache:4.0.0
    docker container logs <ID>
    docker container rm -f $(docker ps -q)


DOCKERFILE - MULTISTAGE

DOCKER HUB

    docker image tag c9fdbf36da85 diogofernandes/apache_2_curso:1.0.0
    docker login
    docker push diogofernandes/apache_2_curso:1.0.0
    docker pull diogofernandes/apache_2_curso:1.0.0
    docker container run -d diogofernandes/apache_2_curso:1.0.0

    docker container run -d -p 5000:5000 --restart=always --name registry registry:2
    docker logout
    docker image tag c9fdbf36da85 localhost:5000/apache_2_curso:2.0.0
    docker push localhost:5000/apache_2_curso:2.0.0
    docker container run -d localhost:5000/apache_2_curso:2.0.0

    curl localhost:5000/v2/_catalog
    curl localhost:5000/v2/apache_2_curso/tags/list

    docker image inspect debian
    docker history linuxtips/apache:1.0
    docker login
    docker login registry.suaempresa.com
    docker push linuxtips/apache:1.0
    docker pull linuxtips/apache:1.0
    docker image ls
    docker container run -d -p 5000:5000 --restart=always --name registry registry:2
    docker tag IMAGEMID localhost:5000/apache



Projeto - Preparar imagem com ferramentas cloud e IAC.


DOCKER MACHINE

docker-machine create -d hyperv --hyperv-virtual-switch "Bridge" VMDOCKER

docker-machine.exe rm VMDOCKER
docker-machine.exe inspect VMDOCKER
docker-machine.exe ip VMDOCKER
docker-machine.exe ssh vmdocker
docker container run -d -p 8080:80 nginx
docker-machine.exe status|start|stop vmdocker
docker-machine.exe env -u
eval $("C:\Users\dfs\bin\docker-machine.exe" env -u)
docker-machine.exe rm vmdocker -f


DOCKER SWARM

masternode
docker swarm init --advertise-addr 192.168.0.29
docker node ls
docker node promote node02

docker swarm leave -f 
docker swarm join-token worker
docker swarm join-token manager

docker swarm join-token --rotate manager
docker swarm join-token --rotate worker

docker node demote node2
docker node rm -f node2

docker node inspect node1

docker service create --name webserver --replicas 3 -p 8080:80 nginx
docker service ps webserver

docker node update --availability pause
docker node update --availability pause node2


DOCKER SECRETS

echo 'minha secret' | docker secret create 
docker secret create minha_secret minha_secret.txt
docker secret inspect minha_secret
docker secret ls
docker secret rm minha_secret
docker service create --name app --detach=false --secret db_pass  minha_app:1.0
docker service create --detach=false --name app --secret source=db_pass,target=password,uid=2000,gid=3000,mode=0400 minha_app:1.0
ls -lhart /run/secrets/
docker service update --secret-rm db_pass --detach=false --secret-add source=db_pass_1,target=password app


DOCKER COMPOSE

