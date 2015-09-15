FROM ubuntu:14.04

#RUN apt-get update -y

# NGINX FROM SOURCE
# RUN apt-get install -qq -y wget
# RUN wget http://nginx.org/keys/nginx_signing.key && apt-key add nginx_signing.key
# RUN echo deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx >> /etc/apt/sources.list
# RUN echo deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx >> /etc/apt/sources.list

#RUN apt-get install -qq -y \
# openssh-server curl nano git nginx mysql-client php5-mysql php-pear php5-fpm php5-gd nginx-extras\
# php5-curl php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps

RUN \
    # Update system
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    # Install packages
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install nano openssh-server \
    curl git zip \
    php5-fpm php5-mysql php5-imagick \
    php5-mcrypt php5-curl php5-cli php5-gd php5-sqlite php5-common  \
    php-pear php5-json php5-memcache \
    nginx && \
    # Cleanup
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN php5enmod mcrypt

COPY default /etc/nginx/sites-available/default

COPY install-composer-platform /tmp/install-composer-platform
RUN chmod +x /tmp/install-composer-platform

# UPDATE NGINX CONFIGS
RUN \
    # PHP settings changes
    sed -i 's/memory_limit = .*/memory_limit = 256M/' /etc/php5/fpm/php.ini && \
    sed -i 's/cgi.fix_pathinfo = .*/cgi.fix_pathinfo = 0/' /etc/php5/fpm/php.ini && \
    sed -i 's/upload_max_filesize = .*/upload_max_filesize = 500M/' /etc/php5/fpm/php.ini && \
    sed -i 's/post_max_size = .*/post_max_size = 500M/' /etc/php5/fpm/php.ini && \
    # PHP FPM config changes
    sed -i 's/listen = .*/listen = \/var\/run\/php5-fpm\.sock/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i "/;listen.owner = www-data/c\listen.owner = www-data" /etc/php5/fpm/pool.d/www.conf && \
    sed -i "/;listen.group = www-data/c\listen.group = www-data" /etc/php5/fpm/pool.d/www.conf && \
    sed -i "/;listen.mode = 0660/c\listen.mode = 0660" /etc/php5/fpm/pool.d/www.conf && \
    sed -i "/;daemonize = yes/c\daemonize = no" /etc/php5/fpm/php-fpm.conf


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

RUN echo "/etc/init.d/php5-fpm start" >> /etc/bash.bashrc
RUN echo "/etc/init.d/nginx start" >> /etc/bash.bashrc

#
#		DOWNLOAD COMPOSER & PLATFORM.SH
#			- Will download the full project.. no DB tho.
#
#
#	git clone https://github.com/tes/cms-the-docker.git /TO/SOME/WHERE/USEFUL
#
#
#
#curl -sS https://getcomposer.org/installer | php
#sudo mv composer.phar /usr/local/bin/composer
#composer global require platformsh/cli:@stable
#composer global reequire drush/drush:7.*
#export PATH="$HOME/.composer/vendor/bin:$PATH"
#. "$HOME/.composer/vendor/platformsh/cli/platform.rc" 2> /dev/null
#
#
#

VOLUME ["/var/www", "/var/www"]
EXPOSE 22 80 443

ADD startup.sh /opt/startup.sh
RUN chmod +x /opt/startup.sh
#CMD ["/bin/bash", "/opt/startup.sh"]
CMD bash -C '/opt/startup.sh';'bash'
