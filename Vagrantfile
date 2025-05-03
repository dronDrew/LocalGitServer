Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"

  config.vm.network "private_network", ip: "192.168.33.33"

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.name = "vagrant-custom-git-server"
    vb.memory = "2048"
    vb.cpus = 1
  end

  config.vm.provision "file", source: "git_set_upscripts", destination: "/home/vagrant/git_set_upscripts"

  public_key_path = File.expand_path("<path_to_your_public_key>") # Replace with the path to your public key
  public_key = File.read(public_key_path).chomp

  config.vm.provision "shell", inline: <<-SHELL
    set -e

    apt-get update
    apt-get upgrade -y
    apt-get install -y git
    
    # Create git user
    adduser --disabled-password --gecos "" git

    mkdir -p /home/git/.ssh
    cp /home/vagrant/.ssh/authorized_keys /home/git/.ssh/authorized_keys
    echo "#{public_key}" > /home/git/.ssh/authorized_keys
    chmod 700 /home/git/.ssh
    chmod 600 /home/git/.ssh/authorized_keys
    chown -R git:git /home/git/.ssh

    # Restrict git user to git-shell
    chsh -s $(which git-shell) git
    
    # Create creator user
    adduser --disabled-password --gecos "" creator
    mkdir -p /home/creator/.ssh
    cp /home/vagrant/.ssh/authorized_keys /home/creator/.ssh/authorized_keys
    echo "#{public_key}" > /home/creator/.ssh/authorized_keys
    chmod 700 /home/creator/.ssh
    chmod 600 /home/creator/.ssh/authorized_keys
    chown -R creator:creator /home/creator/.ssh
    

    # Create the repositories directory
    mkdir -p /home/git/repos
    chown -R git:git /home/git/repos
    chmod 700 /home/git/repos
    
    # moving script to the creator's home directory
    mv /home/vagrant/git_set_upscripts/create-repo.sh /home/creator/create-repo.sh
    chmod +x /home/creator/create-repo.sh
    chown creator:creator /home/creator/create-repo.sh

    echo "exec /home/creator/create-repo.sh" >> /home/creator/.bashrc
    sed -i 's/\r$//' /home/creator/create-repo.sh

    echo "creator ALL=(git) NOPASSWD:/bin/mkdir, /usr/bin/git, /home/creator/create-repo.sh" > /etc/sudoers.d/creator-nopasswd

    echo "Git server setup complete."
  SHELL
end
