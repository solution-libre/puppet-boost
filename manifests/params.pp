# == Class: boost::params
#
# This is a container class with default parameters for boost classes.
class boost::params {
  $all_devel      = false
  $devel          = false
  $doc            = false
  $package_ensure = 'present'
  $packages       = {}

  # <OS family handling>
  case $::osfamily {
    'Debian': {
      $prefix                 = 'libboost'
      $suffix                 = '.0'
      $suffix_dev             = '-dev'
      $all_devel_package_name = "${prefix}-all${suffix_dev}"

      case $::operatingsystem {
        'Debian': {
          case $::operatingsystemrelease {
            /^6/: {
              $version = '1.42'
            }
            /^7/: {
              $version = '1.49'
            }
            /^8/: {
              $version = '1.55'
            }
            /^9/: {
              $version = '1.62'
            }
            default: {
              fail("boost supports Debian 6 (squeeze), 7 (wheezy), 8 \
(jessie) and 9 (stretch). Detected operatingsystemrelease is \
<${::operatingsystemrelease}>.")
            }
          }
        }
        'Ubuntu': {
          case $::operatingsystemrelease {
            /^10.04/: {
              $version = '1.42'
            }
            /^12.04/: {
              $version = '1.46'
            }
            /^14.04/: {
              $version = '1.54'
            }
            /^16.04/: {
              $version = '1.58'
            }
            default: {
              fail("boost supports Ubuntu 10.04 (lucid), 12.04 (precise), \
14.04 (trusty) and 16.04 (xenial). Detected operatingsystemrelease is \
<${::operatingsystemrelease}>.")
            }
          }
        }
        default: {
          fail("boost supports Debian and Ubuntu. Detected operatingsystem is \
<${::operatingsystem}>.")
        }
      }
    }
    'RedHat': {
      $prefix                 = 'boost'
      $suffix                 = ''
      $suffix_dev             = '-devel'
      $version                = ''
      $all_devel_package_name = "${prefix}${suffix_dev}"
    }
    default: {
      fail("boost supports osfamilies Debian and RedHat. Detected osfamily is \
<${::osfamily}>.")
    }
  }
  # </OS family handling>

  $doc_package_name = "${prefix}-doc"
}
