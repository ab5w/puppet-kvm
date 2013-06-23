#
#   Simple module to install KVM on Debian or RHEL.
#
#   Include it into your .pp with either; 
#   
#   class { 'kvm': }
#
#   or
#
#   include kvm
#
#   Copyright (C) 2013 Craig Parker <craig@paragon.net.uk>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 3 of the License, or
#   (at your option) any later version.
#   
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; If not, see <http://www.gnu.org/licenses/>.
#

class kvm {

    if $::osfamily == 'redhat' {
 
        package {'python-virtinst':
            ensure => installed,
        }

        package {'virt-top':
            ensure => installed,
        }

        package {'qemu-kvm':
            ensure => installed,
        }

        package {'libvirt':
            ensure => installed,
        }

        package {'bridge-utils':
            ensure => installed,
        }

        exec { 'yum-group-install-virt':
            unless  => '/usr/bin/yum grouplist "Virtualization" | /bin/grep "^Virtualization"',
            command => '/usr/bin/yum -y groupinstall "Virtualization"',
        }

        exec { 'yum-group-install-virt-plat':
            unless  => '/usr/bin/yum grouplist "Virtualization Platform" | /bin/grep "^Virtualization Platform"',
            command => '/usr/bin/yum -y groupinstall "Virtualization Platform"',
        }

        exec { 'yum-group-install-virt-plat-tools':
            unless  => '/usr/bin/yum grouplist "Virtualization Tools" | /bin/grep "^Virtualization Tools"',
            command => '/usr/bin/yum -y groupinstall "Virtualization Tools"',
        }

        service { "libvirtd":
            enable => true,
            ensure => running,
        }

    } elsif $::osfamily == 'debian' {

        exec { 'aptgetupdate':
            command => '/usr/bin/apt-get update',
            path => '/usr/bin:/bin:/usr/sbin:/sbin',
        }

        package {'qemu-kvm':
            ensure => installed,
            require  => Exec['aptgetupdate'],
        }

        package {'virt-top':
            ensure => installed,
            require  => Exec['aptgetupdate'],
        }

        package {'libvirt-bin':
            ensure => installed,
            require  => Exec['aptgetupdate'],
        }

        package {'virtinst':
            ensure => installed,
            require  => Exec['aptgetupdate'],
        }

        package {'python-libvirt':
            ensure => installed,
            require  => Exec['aptgetupdate'],
        }

        package {'bridge-utils':
            ensure => installed,
            require  => Exec['aptgetupdate'],
        }

        service { "libvirt-bin":
            ensure => "running",
            enable => true,
        }

    }    
    
}
