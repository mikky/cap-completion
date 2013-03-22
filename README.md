# cap-completion

Bash completion function for Capistrano multiple stage extension.

## Features
* Bash completion for capistrano-ext gem with stage (development, test, staging, production).
* Fast completion using local cache file (./.cap_completion).
* Automatic cache update in background.

With Capistrano multiple stage extension(capistrano-ext), cap command may be,  
for example;

    cap production deploy:setup

In this case, conventional capistrano auto completion fails to complete.

My *cap-completion* can complete command line so fast.

## Install

It has only tested on CentOS. Other systems may be almost same.

1. At first, you must install bash-completion module.

* CentOS
    sudo yum -y --enablerepo=epel install bash-completion

2. Install it into bash-completion's directory.

    sudo cp cap-completion.sh /etc/bash_completion.d/

3. Relaunch bash/terminal

## Licence

Copyright (C) 2013, "Mikiya Sase":https://github.com/mikky/cap-completion

This script is distributed under the MIT licence.
