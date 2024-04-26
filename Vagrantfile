Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
    v.gui = true
  end
  config.vm.provision "shell", path: "provisioners/privileged.sh"
  config.vm.provision "shell", path: "provisioners/unprivileged.sh", privileged: false
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
end
