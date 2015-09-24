# == Class rancid::deps
#
# This class is called from rancid to install package dependencies.
#
class rancid::deps {

  package { 'expect':
    ensure => present,
  }

  package { 'cvs':
    ensure => present,
  }

  package { 'httpd':
    ensure => present,
    before => User['rancid'],
  }

  package { 'rcs':
    ensure => present,
  }

}
