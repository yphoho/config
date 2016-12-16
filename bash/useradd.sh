sudo useradd -m -s /bin/bash xxxxxx
sudo passwd xxxxxx

==========================================
visudo

## Allows people in group admin to run all commands
%admin  ALL=(ALL)       ALL


groupadd admin
==========================================


#sudo usermod -a -G admin xxxxxx


#  -G, --groups GROUPS           new list of supplementary GROUPS
#  -a, --append                  append the user to the supplemental GROUPS
#                                mentioned by the -G option without removing
#                                him/her from other groups



sudo userdel -rf xxxxxx

#change username hh to oo
sudo usermod -l oo hh

