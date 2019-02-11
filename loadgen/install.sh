#!/bin/sh
gwhostname=${1:-$(read -p 'Enter gateway IP: ' line; echo $line)}
gwregister=${2:-$(read -p 'Register? (true/false): ' line; echo $line)}
gwusername=${3:-$(read -p 'Gateway Username: ' line; echo $line)}
gwpassword=${4:-$(read -p 'Gateway Password: ' line; echo $line)}

yum install -y http://files.freeswitch.org/freeswitch-release-1-6.noarch.rpm epel-release
cat > /etc/yum.repos.d/irontec.repo << 'EOF'
[irontec]
name=Irontec RPMs repository
baseurl=http://packages.irontec.com/centos/$releasever/$basearch/
EOF
rpm --import http://packages.irontec.com/public.key
yum install -y nano tcpdump net-tools sngrep
yum install -y freeswitch freeswitch-config-vanilla
cat > /etc/freeswitch/sip_profiles/external/gateway.xml << EOF
<include>
	<gateway name="gateway">
		<param name="username" value="$gwusername"/>
		<param name="password" value="$gwpassword"/>
		<param name="proxy" value="$gwhostname"/>
		<param name="expire-seconds" value="800"/>
		<param name="register" value="$gwregister"/>
		<param name="retry-seconds" value="30"/>
		<param name="context" value="public"/>
		<variables></variables>
	</gateway>
</include>
EOF
