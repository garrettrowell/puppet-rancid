# == Class rancid::config
#
# This class is called from rancid for service config.
#
class rancid::config {

  file { 'clog':
    ensure => present,
    path   => '/usr/local/rancid/.cloginrc',
    mode   => '0640',
  }

  file { 'view_query':
    ensure => present,
    path   => '/var/www/cgi-bin/query.cgi',
    owner  => 'apache',
    group  => 'apache',
  }

  file { 'view_cgi':
    ensure => present,
    path   => '/var/www/cgi-bin/viewvc.cgi',
    owner  => 'apache',
    group  => 'apache',
  }

  augeas { 'viewvc_cgi_alias':
    incl    => '/etc/httpd/conf/httpd.conf',
    lens    => 'Httpd.lns',
    context => '/files/etc/httpd/conf/httpd.conf',
    changes => [ "ins directive after /files/etc/httpd/conf/httpd.conf/IfModule[3]/directive",
      "set /files/etc/httpd/conf/httpd.conf/IfModule[3]/directive[2] \"ScriptAlias\"",
      "set /files/etc/httpd/conf/httpd.conf/IfModule[3]/directive[2]/arg[1] \"/rancid\"",
      "set /files/etc/httpd/conf/httpd.conf/IfModule[3]/directive[2]/arg[2] '\"/var/www/cgi-bin/viewvc.cgi\"'"
    ],
    require => Package['httpd'],
    before => Augeas['viewvc_query_alias'],
  }

  augeas { 'viewvc_query_alias':
    incl    => '/etc/httpd/conf/httpd.conf',
    lens    => 'Httpd.lns',
    context => '/files/etc/httpd/conf/httpd.conf',
    changes => [ "ins directive after /files/etc/httpd/conf/httpd.conf/IfModule[3]/directive[1]",
      "set /files/etc/httpd/conf/httpd.conf/IfModule[3]/directive[2] \"ScriptAlias\"",
      "set /files/etc/httpd/conf/httpd.conf/IfModule[3]/directive[2]/arg[1] \"/query\"",
      "set /files/etc/httpd/conf/httpd.conf/IfModule[3]/directive[2]/arg[2] '\"/var/www/cgi-bin/query.cgi\"'"
    ],
    require => Package['httpd'],

  }

}
