## Quick Intro

This project is simple safe playground style to learn ainsible and docker


### Simple Ainsible test

  [vagrant@cent7ansi ~]$ ansible localhost -m find -a "paths=/vagrant file_type=file"
  localhost | SUCCESS => {
      "changed": false,
      "examined": 6,
      "files": [
          {
              "atime": 1610575837.3620062,
              "ctime": 1610575837.6780062,
              "dev": 64768,
              "gid": 1000,
              "gr_name": "vagrant",
              "inode": 67147322,
              "isblk": false,
              "ischr": false,
              "isdir": false,
              "isfifo": false,
              "isgid": false,
              "islnk": false,
              "isreg": true,
              "issock": false,
              "isuid": false,
              "mode": "0644",
              "mtime": 1610571400.0,
              "nlink": 1,
              "path": "/vagrant/LICENSE",
              "pw_name": "vagrant",
              "rgrp": true,
              "roth": true,
              "rusr": true,
              "size": 35149,
              "uid": 1000,
              "wgrp": false,
              "woth": false,
              "wusr": true,
              "xgrp": false,
              "xoth": false,
              "xusr": false
          },
          ... 
          {
              "atime": 1610575876.0480063,
              "ctime": 1610575837.6780062,
              "dev": 64768,
              "gid": 1000,
              "gr_name": "vagrant",
              "inode": 67147325,
              "isblk": false,
              "ischr": false,
              "isdir": false,
              "isfifo": false,
              "isgid": false,
              "islnk": false,
              "isreg": true,
              "issock": false,
              "isuid": false,
              "mode": "0644",
              "mtime": 1610571664.0,
              "nlink": 1,
              "path": "/vagrant/root_cronjob_monitoring_sysstat.txt",
              "pw_name": "vagrant",
              "rgrp": true,
              "roth": true,
              "rusr": true,
              "size": 179,
              "uid": 1000,
              "wgrp": false,
              "woth": false,
              "wusr": true,
              "xgrp": false,
              "xoth": false,
              "xusr": false
          }
      ],
      "matched": 4,
      "msg": ""
  }

### Simple docker test

  [vagrant@cent7ansi ~]$ docker run hello-world
  Unable to find image 'hello-world:latest' locally
  Trying to pull repository docker.io/library/hello-world ...
  latest: Pulling from docker.io/library/hello-world
  0e03bdcc26d7: Pull complete
  Digest: sha256:31b9c7d48790f0d8c50ab433d9c3b7e17666d6993084c002c2ff1ca09b96391d
  Status: Downloaded newer image for docker.io/hello-world:latest

  Hello from Docker!
  This message shows that your installation appears to be working correctly.

  To generate this message, Docker took the following steps:
  1. The Docker client contacted the Docker daemon.
  2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
      (amd64)
  3. The Docker daemon created a new container from that image which runs the
      executable that produces the output you are currently reading.
  4. The Docker daemon streamed that output to the Docker client, which sent it
      to your terminal.

  To try something more ambitious, you can run an Ubuntu container with:
  $ docker run -it ubuntu bash

  Share images, automate workflows, and more with a free Docker ID:
  https://hub.docker.com/

  For more examples and ideas, visit:
  https://docs.docker.com/get-started/


