# Purpose
This is a simple script that can help management of docker containers you may have in your home lab or testing environment.

[CAUTION] As always do not trust scripts you find on the internet. Instead read throgh the script to get ideas as to how you can create a script that aligns with your workflow that may help you manage container images.

# Current Limitation(s):
In this script I used the "env" binary to locate bash to make this script more portable. 

In other words it will run on any system that has the env binary and locate bash. This script is still a work in progess, as it needs to evaluate the operating system environment (e.g. Windows, MacOS, Linux) and shell environment.

This script will not run natively on a Windows Operating System. I will work on steps to get that running. I have run it under Windows Subsystem for Linux (WSL) on a Windows 11 virtual machine, but I did not like the results and it was not easy to use.

# TO-DO:
Modify script to run on Windows OS.

# Script Walthrough

# Variables

The first section is declaring the variables for binaries that will need to be on the system that is running docker and also the temporary directories.

[NOTE] You may encounter errors like below:
![docker pull error](/graphics/script-docker-pull-error.png)

There are a variety of reasons this can occur. In this intance it was because the script was trying to pull a image that was not hosted on a known repository server. The image was a custom one that I built to run jenkins.

# Workflow
Here is wherer the script creates a tenmporary working directory, creates a list of docker images on the system, pulls the version tagged as "latest" from a known repository and then deletes the working directory and files inside the working directory.

# Dangling images
This is where the script will report if you have "unused" docker objects. They call them "dangling images".

The command to prune docker images can be located on the official docker website: https://docs.docker.com/engine/manage-resources/pruning/

[CAUTION] This command has no recovery as far as I can tell. If you run this on a system that has "untagged" images it WILL destroy those images determined to be unused.

This script just informs you if you have untagged images. 

[RECOMMANDATION] If the script shows that you have untagged images, look at he 