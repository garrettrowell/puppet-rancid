# == Class rancid::user
#
# This class is meant to be called from rancid.
# It ensures the netadm user is setup properly.
#
class rancid::user {

  file { 'rancid_dir':
    ensure  => directory,
    path    => '/usr/local/rancid/',
    owner   => 'rancid',
    group   => 'netadm',
    mode    => '0755',
    recurse => true,
    before  => Package['rancid'],
  }

  user { 'netadm':
    ensure  => present,
    name    => 'netadm',
    home    => '/usr/local/rancid',
    groups  => 'apache',
    before  => File['rancid_dir'],
  }

}
