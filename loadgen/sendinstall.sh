#!/bin/bash
fshostname=${1:-$(read -p 'Hostname to install on (enclose IPv6 in brackets): ' line; echo $line)}
gwhostname=${2:-$(read -p 'Enter gateway IP: ' line; echo $line)}
gwregister=${3:-$(read -p 'Register? (true/false): ' line; echo $line)}
gwusername=${4:-$(read -p 'Gateway Username: ' line; echo $line)}
gwpassword=${5:-$(read -p 'Gateway Password: ' line; echo $line)}

echo scp install.sh "root@$fshostname:/tmp/"
scp install.sh "root@$fshostname:/tmp/"
echo ssh "root@$fshostname" bash /tmp/install.sh "$gwhostname" "$gwregister" "$gwusername" "$gwpassword"
ssh "root@$fshostname" bash /tmp/install.sh "$gwhostname" "$gwregister" "$gwusername" "$gwpassword"
