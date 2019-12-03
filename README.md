# Linux-tutorial

## Prerequisites

1. Install virtualBox and [vagrant](https://www.vagrantup.com/) to automate the process of creating a virtual machine.
2. Take a look at [vagrant cloud](https://app.vagrantup.com/boxes/search) to see what public vagrant boxes are available

### Useful vagrant commands

-   Download a box(OS image) and store it to your local storage , e.g.

```sh
$vagrant box add username/os_name
```

-   Initialise a vagrant project and import the box into VirtualBox:

```sh
$vagrant init username/os_name
$vagrant up
```

[Exercise](https://www.udemy.com/course/linux-shell-scripting-projects/learn/lecture/7980558#overview)

-   You can create a box with your very own Vagrantfile, which contains a serial of steps of creating a machine. (Think of it a script defines commands of VirtualBox to create a virtual machine)
-   [Vagrant file example](https://github.com/Catherine22/Linux-tutorial/blob/master/Vagrantfile)

-   Once you have the machine created, what you do the most might be to start the machine and SSH into the machine.

1. Run the box (with the username test1 for example)

```sh
$vagrant up test1
```

2. SSH into the machine

```sh
$vagrant ssh test1
```

And you will see something like this `[vagrant@testbox01 ~]$`.

## Shell script

### Commands

1. Put shebang in the first line

```sh
#!/bin/bash
```

When you write shebang, i.e. "#!", it specifies which interpreter this script is going to use.

### Permission

1. Check access permission at first

```sh
$ls -l
```

And you will see the permission

```sh
-rw-r--r-- 1 vagrant vagrant   32 Dec  3 08:19 test1_demo.sh
```

Ignore the first `-`, we have three characters a group, the first `rw-` is the permission of the owner of the file means the readable, writeable but non-executable. The next set `r--` represents the permission of the group of the file, the last `r--` represents the permission that everyone else in this system granted.

2. Execute the file and you will get _Permission denied_ error
3. Grant the permission to execute the file

```sh
$chmod 755 test1_demo.sh
```

> r=4, w=2, x=1
> To calculate the number of `chmod`, for example, I need `rwxr-xr-x`, the number will be (4+2+1) (4+1) (4+1) = 755. That's how 755 comes from.

Type `ls -l` again, and you'll see:

```sh
-rwxr-xr-x 1 vagrant vagrant   32 Dec  3 08:19 test1_demo.sh
```

4. Execute the script

```sh
$./test1_demo.sh
```

> .: this directory
> /: separate the file and `.`
> ..: parent directory

You can simply run the file by `./test1_demo.sh`, or you can even go from parent directory like `../localusers/test1_demo.sh`
