#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.redhat-epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat-epel
[ ! -d $rolesdir/geerlingguy.apache ] && git clone https://github.com/geerlingguy/ansible-role-apache $rolesdir/geerlingguy.apache
[ ! -d $rolesdir/geerlingguy.nginx ] && git clone https://github.com/geerlingguy/ansible-role-nginx $rolesdir/geerlingguy.nginx
[ ! -d $rolesdir/juju4.harden-apache ] && git clone https://github.com/juju4/ansible-harden-apache $rolesdir/juju4.harden-apache
[ ! -d $rolesdir/juju4.harden-nginx ] && git clone https://github.com/juju4/ansible-harden-nginx $rolesdir/juju4.harden-nginx

## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/noplanman.lufi ] && ln -s ansible-lufi $rolesdir/noplanman.lufi
[ ! -e $rolesdir/noplanman.lufi ] && cp -R $rolesdir/ansible-lufi $rolesdir/noplanman.lufi

## don't stop build on this script return code
true

