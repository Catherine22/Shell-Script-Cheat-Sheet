# Linux-tutorial

-   [Prerequisites](https://github.com/Catherine22/Linux-tutorial#prerequisites)
    -   [Useful vagrant commands](https://github.com/Catherine22/Linux-tutorial#useful-vagrant-commands)
-   [Shell script](https://github.com/Catherine22/Linux-tutorial#shell-script)
    -   [Commands](https://github.com/Catherine22/Linux-tutorial#commands)
    -   [Permission](https://github.com/Catherine22/Linux-tutorial#permission)
    -   [echo](https://github.com/Catherine22/Linux-tutorial#echo)
    -   [Special variables](https://github.com/Catherine22/Linux-tutorial#special-variables)

## Prerequisites

1. Install virtualBox and [vagrant](https://www.vagrantup.com/) to automate the process of creating a virtual machine.
2. Take a look at [vagrant cloud](https://app.vagrantup.com/boxes/search) to see what public vagrant boxes are available
3. (Optional) Customise Your terminal and vim

-   Zoom the font size of your terminal:
    Terminal -> Preferences -> Switch to `text` tab -> Font
-   Set terminal colour in ~/.bash_profile:

```
# Global terminal colours
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacedH
catherine@Vincent-2 ~ $
```

-   Show git branch on terminal in ~/.bash_profile:

```
# Git branch in prompt.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[35m\]\$(parse_git_branch)\[\033[00m\] $ "
```

-   Set vim colour in ~/.vimrc:

```
syntax on

colorscheme desert
```

-   Display line numbers in vim:

Vim any file

```shell
$vim ANY_FILE
```

Type `:set nu` and enter

4. Useful shortcuts

    - terminal
        - Search command history: `ctrl` + `R`, next: `R`
    - vim
        - Jump to line 14: `:14`
        - Scroll to top: `gg` or `:1`
        - Reach the end of a file: `shift` + `g`
        - Search: `/` or `?`

### Useful vagrant commands

-   Download a box(OS image) and store it to your local storage , e.g.

```shell
$vagrant box add username/os_name
```

-   Initialise a vagrant project and import the box into VirtualBox:

```shell
$vagrant init username/os_name
$vagrant up
```

[Exercise](https://www.udemy.com/course/linux-shell-scripting-projects/learn/lecture/7980558#overview)

-   You can create a box with your very own Vagrantfile, which contains a serial of steps of creating a machine. (Think of it a script defines commands of VirtualBox to create a virtual machine)
-   [Vagrant file example](https://github.com/Catherine22/Linux-tutorial/Vagrantfile)

-   Once you have the machine created, what you do the most might be to start the machine and SSH into the machine.

1. Run the box (with the username test1 for example)

```shell
$vagrant up test1
```

2. SSH into the machine

```shell
$vagrant ssh test1
```

And you will see something like this `[vagrant@testbox01 ~]$`.

## Shell script

### Commands

1. Put shebang in the first line

```shell
#!/bin/bash
```

When you write shebang, i.e. "#!", it specifies which interpreter this script is going to use.

2. To see what a command actually is, check its type at first.

E.g. to see what `whoami` can do

```shell
$type a whoami
```

And you will get `whoami is /usr/bin/whoami`. It is a program, so we can open its manual by typing `man

```shell
$man whoami
```

### Permission

1. Check access permission at first

```shell
$ls -l
```

And you will see the permission

```shell
-rw-r--r-- 1 vagrant vagrant   32 Dec  3 08:19 test1_echo.sh
```

Ignore the first `-`, we have three characters a group, the first `rw-` is the permission of the owner of the file means the readable, writeable but non-executable. The next set `r--` represents the permission of the group of the file, the last `r--` represents the permission that everyone else in this system granted.

2. Execute the file and you will get _Permission denied_ error
3. Grant the permission to execute the file

```shell
$chmod 755 test1_echo.sh
```

> r=4, w=2, x=1
> To calculate the number of `chmod`, for example, I need `rwxr-xr-x`, the number will be (4+2+1) (4+1) (4+1) = 755. That's how 755 comes from.

Type `ls -l` again, and you'll see:

```shell
-rwxr-xr-x 1 vagrant vagrant   32 Dec  3 08:19 test1_echo.sh
```

4. Execute the script

```shell
$./test1_echo.sh
```

> .: this directory
> /: separate the file and `.`
> ..: parent directory

You can simply run the file by `./test1_echo.sh`, or you can even go from parent directory like `../localusers/test1_echo.sh`

#### Shell builtin

To see if a command is a shell builtin, type

```shell
$type [COMMAND]
```

For example, you can try `$help echo`, and you will get `echo is a shell builtin`

You can get documentation of any shell builtin by typing

```shell
$help [SHELL_BUILTIN]
```

To show in another page

```shell
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

### Special variables

1. UID/EUID

```shell
$echo "Your UID is ${UID} and EUID is ${EUID}"
```

2. id(uid, gid and group)

```shell
$id
```

You will see `uid=1000(vagrant) gid=1000(vagrant) groups=1000(vagrant)` in Vagrant machine, and you will see more information on Mac by the way ([link](https://apple.stackexchange.com/questions/113822/what-are-com-apple-access-ssh-and-com-apple-access-screensharing-can-i-dele)).

To print one piece of information e.g. name of gid, type:

```shell
$id -g -n
```

These options can be merged. E.g. `$id -gn`

> They're different when a program is running set-uid. Effective UID is the user you changed to, UID is the original user. (Which means **UID IS READ ONLY**)

3. username

```shell
USERNAME=$(id -un) # or `id -un` or $(whoami) or `whoami`
echo "Your username: ${USERNAME}"
```

```
┌──────┐
| Tips |
├──────┴─────────────────────────────────────────────────────────────────┐
|1. Define a code snippet with `$(YOUR_COMMAND)` or `` `YOUR_COMMAND` `` |
|2. Single quotes for value, double quotes for variable                  |
└────────────────────────────────────────────────────────────────────────┘
```
