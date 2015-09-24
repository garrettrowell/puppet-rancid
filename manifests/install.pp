# == Class rancid::install
#
# This class is called from rancid for install.
#
class rancid::install(
  $rancid_rpm = $::rancid::rancid_rpm,
  $viewvc_rpm = $::rancid::rancid_rpm
) {

  file { 'rancid':
    ensure => present,
    path   => "/tmp/${rancid_rpm}",
    source => "puppet:///modules/rancid/tmp/${rancid_rpm}",
  }

  file { 'viewvc':
    ensure => present,
    path   => "/tmp/${viewvc_rpm}",
    source => "puppet:///modules/rancid/tmp/${viewvc_rpm}",
  }

  package { 'rancid':
    ensure   => installed,
    provider => 'rpm',
    source   => '/tmp_.rpm',
    require  => [ File['rancid'], Package['expect'], Package['cvs'], Package['rcs'] ],
  }

  package { 'viewvc':
    ensure   => installed,
    provider => 'rpm',
    source   => '/tmp/_.rpm',
    require  => [ File['viewvc'], Package['rancid'], Package['httpd'] ],
  }

}
