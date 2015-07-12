FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install -qq -y wget

#RUN wget http://nginx.org/keys/nginx_signing.key && apt-key add nginx_signing.key
#RUN echo deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx >> /etc/apt/sources.list
#RUN echo deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -qq -y \
 openssh-server curl nano git nginx mysql-client php5-mysql php-pear php5-fpm php5-gd nginx-extras

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN sed -i s/\;cgi\.fix_pathinfo\s*\=\s*1/cgi.fix_pathinfo\=0/ /etc/php5/fpm/php.ini

# prepare php test scripts
RUN echo "<?php phpinfo(); ?>" > /usr/share/nginx/html/info.php
	
#RUN service nginx restart && /etc/init.d/php5-fpm restart && echo "restarted"

# Configure SSH access
RUN mkdir -p /var/run/sshd
RUN chmod 0755 /var/run/sshd
# Create and configure vagrant user
RUN useradd --create-home -s /bin/bash vagrant
WORKDIR /home/vagrant
RUN mkdir -p /home/vagrant/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant: /home/vagrant/.ssh
RUN echo -n 'vagrant:vagrant' | chpasswd
# Enable passwordless sudo for the "vagrant" user
RUN echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant

VOLUME ["/var/www", "/var/www"]

EXPOSE 22 80 443

#CMD ["nginx", "-g", "daemon off"]

CMD ["/bin/bash"]

CMD /usr/sbin/sshd -D -o UseDNS=no -o UsePAM=no
