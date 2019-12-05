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

#### Shell builtin

To see if a command is a shell builtin, type

```sh
$type [COMMAND]
```

For example, you can try `$help echo`, and you will get `echo is a shell builtin`

You can get documentation of any shell builtin by typing

```sh
$help [SHELL_BUILTIN]
```

To show in another page

```sh
$help [SHELL_BUILTIN]|less
```

E.g. `$help echo`

### echo

To print something such as variables on the terminal.

```bash
#!/bin/bash

# Print 'Hello world'
echo 'Hello World'

# Assign a value to a variable (NO BLANKS before the value)
NAME='Catherine'

# Print the variable (You MUST use double quotes)
echo "$NAME"

# Print a sentence contained a variable
echo "Hello, there! I'm $NAME."

# Combine variables
LINE1='England is barely big enough to contain her. '
LINE2='She will travel Paris, Italy, the Pyrenees. She was mentioning Russia.'

echo "${LINE1}${LINE2}"

# Reassignment
LINE1='Will she be staying long? '
LINE2='Oh, I doubt it.'

echo "${LINE1}${LINE2}"
```

```
┌──────┐
| Tips |
├──────┴─────────────────────────────────────────────────┐
|1. No blanks                                            |
|2. Single quotes for value, double quotes for variable  |
└────────────────────────────────────────────────────────┘
```
