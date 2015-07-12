FROM    ubuntu:14.04

MAINTAINER Robin Mofakham "frobinrobin@hotmail.com"

RUN apt-get update

# seed database password
COPY mysqlpwdseed /root/mysqlpwdseed
RUN debconf-set-selections /root/mysqlpwdseed

RUN apt-get install -y openssh-server mysql-server

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
 
RUN /usr/sbin/mysqld & \
    sleep 10s &&\
    echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'secret' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql -u root --password=secret &&\
    echo "create database test" | mysql -u root --password=secret
 
# persistence: http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/ 


RUN mkdir -p /var/run/sshd
RUN chmod 0755 /var/run/sshd

# Create and configure vagrant user
RUN useradd --create-home -s /bin/bash vagrant
WORKDIR /home/vagrant

# Configure SSH access
RUN mkdir -p /home/vagrant/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant: /home/vagrant/.ssh
RUN echo -n 'vagrant:vagrant' | chpasswd

# Enable passwordless sudo for the "vagrant" user
RUN echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant


#RUN /usr/bin/mysqld_safe
#RUN service mysql restart

EXPOSE 3306

CMD /usr/sbin/sshd -D -o UseDNS=no -o UsePAM=no
