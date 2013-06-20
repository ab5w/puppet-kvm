#
#   Simple module to install KVM on Debian.
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

    service { "libvirt-bin":
        ensure => "running",
        enable => true,
    }
    
}