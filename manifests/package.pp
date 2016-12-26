# == Define: boost::package
#
define boost::package (
  $devel      = false,
  $ensure     = 'present',
  $prefix     = undef,
  $suffix     = undef,
  $suffix_dev = undef,
  $version    = undef,
) {
  validate_bool($devel)
  validate_string($ensure)
  validate_string($prefix)
  validate_string($suffix)
  validate_string($suffix_dev)
  validate_string($version)

  package { $title:
    ensure => $ensure,
    name   => "${prefix}-${title}${version}${suffix}",
  }

  if $devel {
    package { "${title}-devel":
      ensure => $ensure,
      name   => "${prefix}-${title}${version}${suffix_dev}",
    }
  }
}
