Vagrant::Config.run do |config|
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    config.vm.host_name = "dev.thomazot.vm"
    config.vm.network :hostonly, "192.168.33.10"
    config.vm.forward_port 80, 8080
    #config.vm.share_folder("vagrant-root", "/var/www", ".", :nfs => true)

    # Caminho absoluto
    config.vm.share_folder("vagrant-root", "/var/www", "./www", :nfs => true)

    config.vm.customize do |vm|
        vm.memory_size = 1024
    end

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "vagrant/manifests"
    end
end