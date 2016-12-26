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
              fail("boost supports Debian 6 (squeeze), 7 (wheezy) and 8 \
(jessie). Detected lsbdistcodename is <${::lsbdistcodename}>.")
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
            'xenial': {
              $version = '1.58'
            }
            default: {
              fail("boost supports Ubuntu 10.04 (lucid), 12.04 (precise), \
14.04 (trusty) and 16.04 (xenial). Detected lsbdistcodename is \
<${::lsbdistcodename}>.")
            }
          }
        }
        default: {
          fail("boost supports Debian and Ubuntu. Detected lsbdistcodename is \
<${::lsbdistid}>.")
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
