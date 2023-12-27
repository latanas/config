#!/bin/bash
# VirtualBox helper script

function mount_vbox()   
{
    sudo mount -t vboxsf $1 /home/sennin/$1
}
