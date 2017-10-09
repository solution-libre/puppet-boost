# == Define: boost::package
#
define boost::package (
  $devel      = $boost::params::devel,
  $ensure     = $boost::params::package_ensure,
  $prefix     = $boost::params::prefix,
  $suffix     = $boost::params::suffix,
  $suffix_dev = $boost::params::suffix_dev,
  $version    = $boost::params::version,
) {
  # The base class must be included first because it is used by parameter defaults
  if ! defined(Class['boost']) {
    fail('You must include the boost base class before using any boost defined resources')
  }

  # <stringified variable handling>
  if is_string($devel) == true {
    $devel_bool = str2bool($devel)
  } else {
    $devel_bool = $devel
  }
  # </stringified variable handling>

  # <variable validations>
  validate_bool($devel_bool)
  validate_string($ensure)
  validate_string($prefix)
  validate_string($suffix)
  validate_string($suffix_dev)
  validate_string($version)
  # </variable validations>

  package { $title:
    ensure => $ensure,
    name   => "${prefix}-${title}${version}${suffix}",
  }

  if $devel_bool {
    package { "${title}-devel":
      ensure => $ensure,
      name   => "${prefix}-${title}${version}${suffix_dev}",
    }
  }
}
