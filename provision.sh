#! /bin/bash
if [ ! -f /home/vagrant/already-installed-flag ]
then
  echo "ADD EXTRA ALIAS VIA .bashrc"
  cat /vagrant/bashrc.append.txt >> /home/vagrant/.bashrc
  #echo "GENERAL YUM UPDATE"
  #yum -y update
  #echo "INSTALL GIT"
  yum -y install git
  #echo "INSTALL VIM"
  #yum -y install vim
  #echo "INSTALL TREE"
  yum -y install tree
  #echo "INSTALL unzip curl wget lsof"
  yum  -y install unzip curl wget lsof 
  # install sysstat
  #yum -y install sysstat
  #systemctl start sysstat
  #systemctl enable sysstat


  # setup environment variables and extra alias for postgres user
  # cat /vagrant/bashrc.append.txt >> /var/lib/pgsql/.bash_profile


  yum -y install python3
  yum -y install python-virtualenv
  yum -y install gcc openssl-devel
  yum -y install epel-release
  yum -y install ansible
  yum -y install docker

  systemctl start docker
  systemctl enable docker
else
  echo "already installed flag set : /home/vagrant/already-installed-flag"
fi

