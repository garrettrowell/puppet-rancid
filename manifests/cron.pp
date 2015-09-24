# == Class rancid::cron
#
# This class is meant to be called from rancid.
# It ensures the required cron jobs for rancid are configure properly.
#
class rancid::cron {

  cron { 'rancid-run':
    ensure  => present,
    command => '/usr/local/rancid/bin/rancid-run',
    minute  => '1',
    target  => 'rancid',
    notify  => Service['crond'],
  }

  cron { 'rancid-log':
    ensure   => present,
    command  => '/usr/bin/find /usr/local/rancid/var/logs -type f -mtime +30 -exec rm {} \;',
    hour     => '00',
    minute   => '00',
    monthday => '1',
    target   => 'rancid',
    notify   => Service['crond'],
  }

  service { 'crond': }

}
