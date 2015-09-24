# == Class: rancid
#
# Full description of class rancid here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class rancid (
  $rancid_rpm = $::rancid::params::rancid_rpm,
  $viewvc_rpm = $::rancid::params::viewvc_rpm,
) inherits ::rancid::params {

  class { '::rancid::deps': } ->
  class { '::rancid::user': } ->
  class { '::rancid::install': } ->
  class { '::rancid::config': } ~>
  class { '::rancid::cron': } ->
  Class['::rancid']
}
