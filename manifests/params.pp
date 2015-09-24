# == Class rancid::params
#
# This class is meant to be called from rancid.
# It sets variables according to platform.
#
class rancid::params {
  case $::osfamily {
    'RedHat': {
      case $::hardwaremodel {
        'x86_64': {
          $rancid_rpm = 'rancid-3.2-1.x86_64.rpm'
          $viewvc_rpm = 'viewvc-1.1.23-1.x86_64.rpm'
        }
        default: {
          fail("${::hardwaremodel} not supported")
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
