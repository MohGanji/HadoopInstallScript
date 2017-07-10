# Hadoop
Hadoop multinode installation bash script

# Run on ubuntu 16.04 32 bit in order not to get some warnings.

Step By Step installation guide:

go in this order and do NOT close any of master or slave terminals,

NOTE: run all these sh files with the command bash
ex: bash 1_both_java_insall.sh

1- run java install script for master.
2- run master add hostname.
3- run master setup ssh server.
4- run master configs.
4.1- copy master's public key from ~/.ssh/id_rsa.pub
5- run java install for all slaves.
6- run slave add hostname for all slaves.
7- run slave setup ssh for all slaves.
8- run master copy hadoop to slaves.
9- run this command: $source ~/.bashrc
...

## TO DO
- [ ] there is a problem now, namenode does not start datanodes.

