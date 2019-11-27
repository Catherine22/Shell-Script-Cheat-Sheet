# Linux-tutorial

## Prerequisites
1. Install virtualBox and  [vagrant](https://www.vagrantup.com/) to automate the process of creating a virtual machine.		
2. Take a look at [vagrant cloud](https://app.vagrantup.com/boxes/search) to see what public vagrant boxes are available		


### Useful vagrant commands		
- Download a box(OS image) and store it to your local storage , e.g.		
```sh
$vagrant box add username/os_name
```

- Initialise a vagrant project and import the box into VirtualBox:
```sh
$vagrant init username/os_name
$vagrant up
```

[Exercise](https://www.udemy.com/course/linux-shell-scripting-projects/learn/lecture/7980558#overview)
