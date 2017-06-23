Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 3000, host: 3000, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 1
    vb.memory = "512"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo apt-get update

    # Install build dependencies
    sudo apt-get install -y \
      autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev \
      zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev \
      libpq-dev postgresql-client git-core

    # Install ruby (via rbenv)
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.profile
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.profile
    echo 'eval "$(rbenv init -)"' >> ~/.profile
    source ~/.profile

    # export PATH="$HOME/.rbenv/bin:$PATH"
    # export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
    # eval "$(rbenv init -)"

    rbenv install 2.4.1
    rbenv global 2.4.1
    ruby -v

    gem install bundler
    rbenv rehash

    # Install project gems
    cd /vagrant
    bundle install
    rbenv rehash
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
    # Load database schema
    cd /vagrant
    bundle exec rake db:setup
  SHELL
end
