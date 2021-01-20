## Quick Intro

This project is simple safe playground style to learn ainsible and docker.

I've been following

* the latest Linkedin Learning ansible course from there general DevOps path https://www.linkedin.com/learning/learning-ansible-2
* then going more in depth with "Ansible 101 by Jeff Geerling" (both youtube and e-book) https://www.jeffgeerling.com/blog/2020/ansible-101-jeff-geerling-youtube-streaming-series

These examples are the most simple scenarios regarding one centos7 VM which ansible is using as both a control and a managed node i.e. a typical training environment.

I've also setup some more interesting configurations using vagrant to have distinct control and a managed nodes:
* https://github.com/dgapitts/vagrant-ansible-for-devops (including deploying postgres on managed node via ansible galaxy role)
* https://github.com/dgapitts/vagrant-ansible-for-devops-3nodes (setup 2apps and a db in a managed cluster)


### Simple Ainsible test

```
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
```

### Simple docker test

```
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
```

### First ansible-playbook a few simple checks and operations

```
My first ansible-playbook

  [vagrant@cent7ansi vagrant]$ cat first_ansible-playbook_display_file_test.yml
  ---
    - name: "Display content of file root_cronjob_monitoring_sysstat.txt"
      hosts: localhost
      tasks:
      - name: ping test
        ping:

      - name: Get root_cronjob_monitoring_sysstat.txt contents
        command: cat root_cronjob_monitoring_sysstat.txt chdir=/vagrant
        register: command_output

      - name: Print to console
        debug:
          msg: "{{command_output.stdout}}"

      - name: "find files in /vagrant"
        find:
          paths: '/vagrant'
```

NB the above took me some time to get write, the identation has to be perfect ;)

Here is the output:

```
  [vagrant@cent7ansi vagrant]$ ansible-playbook first_ansible-playbook_display_file_test.yml -v
  Using /etc/ansible/ansible.cfg as config file
  [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

  PLAY [Display content of file root_cronjob_monitoring_sysstat.txt] ********************************************************************************

  TASK [Gathering Facts] ****************************************************************************************************************************
  ok: [localhost]

  TASK [ping test] **********************************************************************************************************************************
  ok: [localhost] => {"changed": false, "ping": "pong"}

  TASK [Get root_cronjob_monitoring_sysstat.txt contents] *******************************************************************************************
  changed: [localhost] => {"changed": true, "cmd": ["cat", "root_cronjob_monitoring_sysstat.txt"], "delta": "0:00:00.007846", "end": "2021-01-14 00:17:24.397899", "rc": 0, "start": "2021-01-14 00:17:24.390053", "stderr": "", "stderr_lines": [], "stdout": "# run system activity accounting tool every 1 minutes\n*/1 * * * * /usr/lib64/sa/sa1 1 1\n# generate a daily summary of process accounting at 23:53\n53 23 * * * /usr/lib64/sa/sa2 -A", "stdout_lines": ["# run system activity accounting tool every 1 minutes", "*/1 * * * * /usr/lib64/sa/sa1 1 1", "# generate a daily summary of process accounting at 23:53", "53 23 * * * /usr/lib64/sa/sa2 -A"]}

  TASK [Print to console] ***************************************************************************************************************************
  ok: [localhost] => {
      "msg": "# run system activity accounting tool every 1 minutes\n*/1 * * * * /usr/lib64/sa/sa1 1 1\n# generate a daily summary of process accounting at 23:53\n53 23 * * * /usr/lib64/sa/sa2 -A"
  }

  TASK [find files in /vagrant] *********************************************************************************************************************
  ok: [localhost] => {"changed": false, "examined": 7, "files": [{"atime": 1610575837.3620062, "ctime": 1610575837.6780062, "dev": 64768, "gid": 1000, "gr_name": "vagrant", "inode": 67147322, "isblk": false, "ischr": false, "isdir": false, "isfifo": false, "isgid": false, "islnk": false, "isreg": true, "issock": false, "isuid": false, "mode": "0644", "mtime": 1610571400.0, "nlink": 1, "path": "/vagrant/LICENSE", "pw_name": "vagrant", "rgrp": true, "roth": true, "rusr": true, "size": 35149, "uid": 1000, "wgrp": false, "woth": false, "wusr": true, "xgrp": false, "xoth": false, "xusr": false}, {"atime": 1610575837.363006, "ctime": 1610575837.6780062, "dev": 64768, "gid": 1000, "gr_name": "vagrant", "inode": 67147323, "isblk": false, "ischr": false, "isdir": false, "isfifo": false, "isgid": false, "islnk": false, "isreg": true, "issock": false, "isuid": false, "mode": "0644", "mtime": 1610571400.0, "nlink": 1, "path": "/vagrant/Vagrantfile", "pw_name": "vagrant", "rgrp": true, "roth": true, "rusr": true, "size": 534, "uid": 1000, "wgrp": false, "woth": false, "wusr": true, "xgrp": false, "xoth": false, "xusr": false}, {"atime": 1610575837.363006, "ctime": 1610575837.6780062, "dev": 64768, "gid": 1000, "gr_name": "vagrant", "inode": 67147324, "isblk": false, "ischr": false, "isdir": false, "isfifo": false, "isgid": false, "islnk": false, "isreg": true, "issock": false, "isuid": false, "mode": "0644", "mtime": 1610575779.0, "nlink": 1, "path": "/vagrant/provision.sh", "pw_name": "vagrant", "rgrp": true, "roth": true, "rusr": true, "size": 1165, "uid": 1000, "wgrp": false, "woth": false, "wusr": true, "xgrp": false, "xoth": false, "xusr": false}, {"atime": 1610575876.0480063, "ctime": 1610575837.6780062, "dev": 64768, "gid": 1000, "gr_name": "vagrant", "inode": 67147325, "isblk": false, "ischr": false, "isdir": false, "isfifo": false, "isgid": false, "islnk": false, "isreg": true, "issock": false, "isuid": false, "mode": "0644", "mtime": 1610571664.0, "nlink": 1, "path": "/vagrant/root_cronjob_monitoring_sysstat.txt", "pw_name": "vagrant", "rgrp": true, "roth": true, "rusr": true, "size": 179, "uid": 1000, "wgrp": false, "woth": false, "wusr": true, "xgrp": false, "xoth": false, "xusr": false}, {"atime": 1610583380.515912, "ctime": 1610583378.5669067, "dev": 64768, "gid": 1000, "gr_name": "vagrant", "inode": 67579643, "isblk": false, "ischr": false, "isdir": false, "isfifo": false, "isgid": false, "islnk": false, "isreg": true, "issock": false, "isuid": false, "mode": "0664", "mtime": 1610583378.5549893, "nlink": 1, "path": "/vagrant/first_ansible-playbook_display_file_test.yml", "pw_name": "vagrant", "rgrp": true, "roth": true, "rusr": true, "size": 467, "uid": 1000, "wgrp": true, "woth": false, "wusr": true, "xgrp": false, "xoth": false, "xusr": false}], "matched": 5, "msg": ""}

  PLAY RECAP ****************************************************************************************************************************************
  localhost                  : ok=5    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
Note you need the -v (verbose) option to see the results of the find TASK



## Background - setting up ssh access for vagrant user over loopback 

Ref: https://github.com/ansible/ansible/issues/19584 "Failed to connect to the host via ssh: Permission denied (publickey,password)"

Initially I was hitting 

```
loopback1 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh: Permission denied (publickey,gssapi-keyex,gssapi-with-mic).",
    "unreachable": true
}
```

and checking regular ssh

```
[vagrant@cent7ansi vagrant]$ ssh vagrant@127.0.0.1
Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
```

so generate ssh keys and add the new public key (.ssh/id_rsa.pub) to the approved host/keys file (.ssh/authorized_keys)


```
[vagrant@cent7ansi vagrant]$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/vagrant/.ssh/id_rsa.
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:B3bX1Vfvw7vBHCdUk0WYzoII4OBQKoD2Tg8m2Kghw1I vagrant@cent7ansi
The key's randomart image is:
+---[RSA 2048]----+
|+.o ..         =@|
|o=Eo  .      .o+=|
|*+o .  .o....oo o|
|Oo.=   ..o....+. |
|+o= o   S .  ..+o|
|.  . .   .    o.=|
|               = |
|                o|
|               . |
+----[SHA256]-----+
[vagrant@cent7ansi ~]$ cat .ssh/id_rsa.pub >> .ssh/authorized_keys
```

and now ssh works

```
[vagrant@cent7ansi ~]$ ssh vagrant@127.0.0.1
Last login: Wed Jan 20 17:08:05 2021 from 10.0.2.2
```




