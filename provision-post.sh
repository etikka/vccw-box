#!/usr/bin/env bash

set -ex

yum -y distro-sync
yum -y clean all

/etc/init.d/httpd stop

rm -fr /var/www/wordpress
rm -f /etc/httpd/sites-available/wordpress.conf
rm -f /etc/httpd/sites-enabled/wordpress.conf

rm -f /etc/ssh/ssh_host_*
cd /var/log
find /var/log/ -type f -name '*.log' -exec cp /dev/null {} \;
cp /dev/null /var/log/syslog

yes | cp /dev/null /root/.bash_history
yes | cp /dev/null /home/vagrant/.bash_history

/etc/init.d/vboxadd setup

ln -s -f /dev/null /etc/udev/rules.d/70-persistent-net.rules

curl -L https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub > /home/vagrant/.ssh/authorized_keys

chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys

history -c

shutdown -r now
