Vagrant.configure("2") do |config|
  config.vm.box = "jasonc/centos7"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
  end
  config.vm.define "test1" do |test1| 
   test1.vm.hostname = "testbox01"
   test1.vm.network "private_network", ip: "10.9.8.7"
  end
  config.vm.define "test2" do |test2| 
   test2.vm.hostname = "testbox02"
   test2.vm.network "private_network", ip: "10.9.8.6"
  end
end

# $vagrant reload
# $vagrnat ssh test1
# $sudo su
# $yum update -y
# $yum install httpd -y
# $systemctl start httpd

# Check the status by typing
# $systemctl status httpd
# $systemctl is-active httpd

# Open "10.9.8.7" and you can see "Apache HTTP server" page in your browser
