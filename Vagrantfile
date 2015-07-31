# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
#Check if you have the good Vagrant version to use docker provider...
Vagrant.require_version ">= 1.6.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

  config.vm.define "db" do |db|
    db.vm.provider "docker" do |d|
      d.build_dir = "mysql"
      d.build_args = "-t='stack/mysql:1.0'"
      d.name = "mysqlserver"
      #d.has_ssh = true
      d.create_args = ['-p', '192.168.1.41:3306:3306']
      #d.volumes = ["/vagrant/data:/var/lib/mysql"]
    end
    #db.ssh.port = 22
    #db.ssh.private_key_path = "id_rsa"
  end

  config.vm.define "app" do |app|
   app.vm.provider "docker" do |d|
     d.build_dir = "nginx"
     d.build_args = "-t='stack/nginx:1.0'"
     d.name = "web"
     d.has_ssh = true
     d.create_args = ['-p', '192.168.1.42:80:80']
#    config.vm.provision :shell, :path => "bootstrap.sh"
#    http://stackoverflow.com/questions/26831761/how-to-run-provision-sh-on-vagrant-with-docker-provider
    d.volumes = ["/var/www/the:/var/www/the"]
    d.link("mysqlserver:web")
   end  
   config.ssh.port = 22
  end
end
