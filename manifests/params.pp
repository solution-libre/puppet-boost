# == Class: boost::params
#
# This is a container class with default parameters for boost classes.
class boost::params {
  $all_devel      = false
  $devel          = false
  $doc            = false
  $package_ensure = 'present'
  $packages       = {}

  case $::osfamily {
    'Debian': {
      $prefix                 = 'libboost'
      $suffix                 = '.0'
      $suffix_dev             = '-dev'
      $all_devel_package_name = "${prefix}-all${suffix_dev}"
      case $::lsbdistid {
        'Debian': {
          case $::lsbdistcodename {
            'squeeze': {
              $version = '1.42'
            }
            'wheezy': {
              $version = '1.49'
            }
            'jessie': {
              $version = '1.55'
            }
            default: {
              fail("Unsupported Debian release: ${::lsbdistcodename}")
            }
          }
        }
        'Ubuntu': {
          case $::lsbdistcodename {
            'lucid': {
              $version = '1.42'
            }
            'precise': {
              $version = '1.46'
            }
            'trusty': {
              $version = '1.54'
            }
            default: {
              fail("Unsupported Ubuntu release: ${::lsbdistcodename}")
            }
          }
        }
        default: {
          fail("Unsupported Debian family OS: ${::lsbdistid}")
        }
      }
    }
    'RedHat': {
      $prefix                 = 'boost'
      $version                = ''
      $suffix                 = ''
      $suffix_dev             = '-devel'
      $all_devel_package_name = "${prefix}${suffix_dev}"
    }
    default: {
      fail("Unsupported OS family: ${::osfamily}")
    }
  }

  $doc_package_name = "${prefix}-doc"
}
