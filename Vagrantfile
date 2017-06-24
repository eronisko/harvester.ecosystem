Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 3000, host: 3000, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 1
    vb.memory = "512"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo apt-get install software-properties-common
    sudo apt-add-repository ppa:brightbox/ruby-ng
    sudo apt-get update

    sudo apt-get install -y \
      ruby2.4 ruby2.4-dev \
      ruby-switch \
      libpq-dev postgresql-client \

    sudo ruby-switch --set ruby2.4

    sudo gem install bundler

    # Install project gems
    cd /vagrant
    bundle install
  SHELL

  config.vm.provision "docker" do |d|
    d.run "postgis",
          image: "mdillon/postgis:9.5",
          args: "-p 5432:5432 "\
        "-e POSTGRES_PASSWORD=datahub "\
        "-e POSTGRES_USER=datahub "\
        "-e POSTGRES_DB=datahub_development "

    d.run "redis",
          args: "-p 6379:6379"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    cd /vagrant
    bundle exec rake db:setup
  SHELL
end
