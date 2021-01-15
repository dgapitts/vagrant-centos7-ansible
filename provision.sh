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
  yum -y install sysstat
  systemctl start sysstat
  systemctl enable sysstat

  # initial cron
  crontab /vagrant/root_cronjob_monitoring_sysstat.txt

  # setup environment variables and extra alias for postgres user
  # cat /vagrant/bashrc.append.txt >> /var/lib/pgsql/.bash_profile


  yum -y install python3
  yum -y install python-virtualenv
  yum -y install gcc openssl-devel
  yum -y install epel-release
  yum -y install ansible
  yum -y install docker

  #  new YAML callback plugin (introduced with Ansible 2.5) https://www.jeffgeerling.com/blog/2018/use-ansibles-yaml-callback-plugin-better-cli-experience
  echo 'stdout_callback = yaml' >> /etc/ansible/ansible.cfg
  echo 'bin_ansible_callbacks = True' >> /etc/ansible/ansible.cfg


  systemctl start docker
  systemctl enable docker
  
  # setup docker so it can be run as vagrant user
  groupadd docker
  gpasswd -a vagrant docker
  setfacl -m user:vagrant:rw /var/run/docker.sock
else
  echo "already installed flag set : /home/vagrant/already-installed-flag"
fi

