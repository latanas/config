#!/bin/bash

# Timed background changer

DIR=(
  "/path/to/images"
);
gsettings set org.gnome.desktop.background picture-options "zoom"

while [ 1 ]
do
    DIR_SEL=${DIR[$((RANDOM%1))]};
    PIC=$(ls -R $DIR_SEL | awk '
    /:$/&&f{s=$0;f=0}
    /:$/&&!f{sub(/:$/,"");s=$0;f=1;next}
    NF&&f{ print s"/"$0 }' | shuf -n1)

    gsettings set org.gnome.desktop.background picture-uri "file://$PIC"
    sleep 120m
done

