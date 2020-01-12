# Linux-tutorial

-   [Prerequisites](#prerequisites)
    -   [Useful vagrant commands](#useful-vagrant-commands)
-   [Shell script](#shell-script)
    -   [Commands](#commands)
    -   [Permission](#permission)
    -   [echo](#echo)
    -   [Special variables](#special-variables)
    -   [If statement](#if-statement)
    -   [Exit status](#exit-status)
    -   [Standard input](#standard-input)
    -   [Checksum](#checksum)
    -   [Random](#random)
    -   [Head](#head)
    -   [Stream manipulation](#stream-manipulation)
    -   [Fold](#fold)
    -   [use case](#use-case)
        -   [Check if I am root](#check-if-i-am-root)
        -   [Create a new user](#create-a-new-user)
        -   [Password Generator](#password-generator)

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
```

-   Show git branch on terminal in ~/.bash_profile:

```
# Git branch in prompt.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[31m\]\$(parse_git_branch)\[\033[00m\] $ "
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

Example 1, a program

```shell
$type -a whoami
```

And you will get `whoami is /usr/bin/whoami`. It is a program, so we can open its manual by typing `man`

```shell
$man whoami
```

Example 2, a shell keyword

```shell
$type -a if
```

It turns out `if is a shell keyword`. So now you can learn the keyword by typing `help`

```shell
$help if
```

Example 3, a shell builtin

```shell
$type -a test
```

It turns out:

```
test is a shell builtin
test is /usr/bin/test
```

Show the manual by typing `help`, you can also add `| less` to get it more readable.

```shell
$help test | less
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
| echo |
├──────┴─────────────────────────────────────────────────────────────────┐
|1. No blanks                                                            |
|2. Single quotes for value, double quotes for variable                  |
└────────────────────────────────────────────────────────────────────────┘
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

4. Check if it is root

```shell
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root'
else
  echo 'You are not root'
fi
```

5. Root user
   Two ways to become a root user:
    - Run this code snippet with `sudo`, and you will get 'You are root' result.
    - Or you can switch to root user by typing `su` at first.

When you are not root, your might see `[vagrant@testbox01 localusers]$`, once you become the root user, it shows `[root@testbox01 localusers]#`

```
┌───────────┐
| Variables |
├───────────┴────────────────────────────────────────────────────────────┐
|1. Define a code snippet with $(YOUR_COMMAND) or  `YOUR_COMMAND`        |
|2. Single quotes for value, double quotes for variable                  |
└────────────────────────────────────────────────────────────────────────┘
```

### If statement

Rule 1

```shell
if [[ xxx -eq xxx ]]
then
    # do something
fi;
```

E.g.

Write in one single line and separate each command by `;`

```shell
$if [[ 'a' -eq 'a' ]]; then echo 'same'; fi;
```

To be readable, you can truncate commands by pressing `shift` + `enter`. No `;` anymore.

```shell
$if [[ 'a' -eq 'a' ]]
>  then echo 'same'
>fi
```

> `-eg` or `=`: equal  
> `-ne` or `!=`: not equal

```
┌────┐
| If |
├────┴───────────────────────────────────────────────────────────────────┐
| if [[ condition1 ]]                                                    |
| then                                                                   |
|    // do something                                                     |
| elif [[ condition2 ]]                                                  |
| then                                                                   |
|    // do something                                                     |
| else                                                                   |
|    // do something                                                     |
| fi                                                                     |
└────────────────────────────────────────────────────────────────────────┘
```

### Exit status

#### Principle of status code

-   0: success
-   Not 0: fail

1. Check existed exit status, take `useradd` for example

```shell
$man useradd
```

2. Search the keyword "exit" by typing `/exit`, `n` for next and `N` for previous

3. You will find

```
EXIT VALUES
       The useradd command exits with the following values:

       0
           success

       1
           can't update password file

       2
           invalid command syntax

       ...
```

#### Get the exit status of the previous command

1. Verify the command we've just typed (in shall script)

```shell
USERNAME=$(id -un)

# Test if the command worked (check the exit status of the previous command, i.e. 'id -un' in this case
if [[ "${?}" -ne 0 ]]
then
  echo "The id command did not work successfully."
  exit 2
fi

echo "Username: ${USERNAME}"
```

2. Verify the command we've just typed (in bash)

```shell
$id -un
```

Then you get "vagrant"

```shell
$echo "${?}"
```

And you get 0

Now if I run a false command like

```shell
$id -abc
```

You get the error:

```
id: invalid option -- 'b'
Try 'id --help' for more information.
```

Get the exit status, and this time, it will be 1

```shell
$echo "${?}"
```

```
┌─────────────┐
| Exit status |
├─────────────┴──────────────────────────────────────────────────────────┐
| > status code                                                          |
|   0: success                                                           |
|   others: fail                                                         |
|                                                                        |
| > At the end of your shell script, add:                                |
|   exit 0                                                               |
└────────────────────────────────────────────────────────────────────────┘
```

### Standard Input

Read the input with comments

```shell
$read -p 'type something: ' WORDS
type something: Hello
$echo "${WORDS}"
Hello
```

### Checksum

List all available checksum methods

```shell
$ls -l /usr/bin/*sum

# -rwxr-xr-x 1 root root 33152 Aug 20 02:25 /usr/bin/cksum
# -rwxr-xr-x 1 root root 41504 Aug 20 02:25 /usr/bin/md5sum
# -rwxr-xr-x 1 root root 37448 Aug 20 02:25 /usr/bin/sha1sum
# -rwxr-xr-x 1 root root 41608 Aug 20 02:25 /usr/bin/sha224sum
# -rwxr-xr-x 1 root root 41608 Aug 20 02:25 /usr/bin/sha256sum
# -rwxr-xr-x 1 root root 41624 Aug 20 02:25 /usr/bin/sha384sum
# -rwxr-xr-x 1 root root 41624 Aug 20 02:25 /usr/bin/sha512sum
# -rwxr-xr-x 1 root root 37432 Aug 20 02:25 /usr/bin/sum
```

> -b, --binary

              read in binary mode

> -c, --check

              read SHA256 sums from the FILEs and check them

> --tag create a BSD-style checksum

> -t, --text

              read in text mode (default)

              Note: There is no difference between binary and text mode option on GNU system.

Get the sha256sum of a file

```shell
$sha256sum YOUR_FILE
```

### Random

Generate random numbers

```shell
echo ${RANDOM}

# 3054
```

To dive into the random method, go to the [Password Generator](#password-generator) section

### Head

1. Print the first line of a file

```shell
# 1st line
$head -n1 FILE_NAME

# the first two lines
$head -n2 FILE_NAME
```

2. Print the first character of a file

```shell
# 1st character
$head -c1 FILE_NAME

# the first three characters
$head -c3 FILE_NAME
```

3. Print the first 5 characters of inputs

```shell
$echo 12345678 | head -c5
```

### Stream manipulation

With `|`, you can manipulate the input stream.

E.g. Print the first 5 characters of inputs

```shell
# You will get 12345
$echo 12345678 | head -c5
```

And you can keep modify the inputs with multiple `|`

E.g. Print the first 8 characters of the sha256 checksum of the timestamp

```shell
$date +%s | sha256sum | head -c8
```

### fold

wrap each input line to fit in specified width

> -b, --bytes

              count bytes rather than columns

> -c, --characters

              count characters rather than columns

> -s, --spaces

              break at spaces

> -w, --width=WIDTH

              use WIDTH columns instead of 80

For example

```shell
S='!@#$%^&*()_-+='
echo "${S}" | fold -b1
```

You will get these characters printed on a single line one by one

```
!
@
#
$
%
^
&
*
(
)
_
-
+
=
```

A further use case of `fold` is to generate a random string. The `shuf` method works on shuffling lines of text, you cannot shuffle a string directly, you must fold it at first.

```shell
echo "${S}" | fold -c1 | shuf
```

```
#
+
=
-
@
(
$
!
*
_
^
&
%
)
```

And you can print each line of the character by using `head`

### Use Case

#### Check if I am root

```shell
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root'
else
  echo 'You are not root'
fi
```

#### Create a new user

-   create a new user

```shell
$sudo useradd -c dougstamper -m stamper
```

> -c, --comment COMMENT

           Any text string. It is generally a short description of the login, and is currently used as the field for the user's full name.

> -m, --create-home

           Create the user's home directory if it does not exist. The files and directories contained in the skeleton directory (which can be defined with the -k option)
           will be copied to the home directory.

           By default, if this option is not specified and CREATE_HOME is not enabled, no home directories are created.

           The directory where the user's home directory is created must exist and have proper SELinux context and permissions. Otherwise the user's home directory cannot be
           created or accessed.

-   Set the password

```shell
$sudo echo 123456 | passwd  --stdin stamper
```

-   Expire a password for an account. The user will be forced to change the password during the next login attempt.

```shell
$sudo passwd -e stamper
```

-   Switch to stamper, the user we just created

```shell
$su - stamper
```

-   Logout

```shell
$exit
```

The script to create a user: [add_local_user.sh]

### Password Generator

-   Rule of thumb: [test1_5_pwd_generator.sh]
-   Demo: [password_generator.sh]

[add_local_user.sh]: https://github.com/Catherine22/Linux-tutorial/blob/master/add_local_user.sh
[test1_5_pwd_generator.sh]: https://github.com/Catherine22/Linux-tutorial/blob/master/test1_5_pwd_generator.sh
[password_generator.sh]: https://github.com/Catherine22/Linux-tutorial/blob/master/password_generator.sh
