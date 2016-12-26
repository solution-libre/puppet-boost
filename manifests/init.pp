# == Class: boost
#
class boost (
  $all_devel      = $boost::params::all_devel,
  $devel          = $boost::params::devel,
  $doc            = $boost::params::doc,
  $package_ensure = $boost::params::package_ensure,
  $packages       = $boost::params::packages,
  $prefix         = $boost::params::prefix,
  $suffix         = $boost::params::suffix,
  $suffix_dev     = $boost::params::suffix_dev,
  $version        = $boost::params::version,
) inherits boost::params {
  # <stringified variable handling>
  if is_string($all_devel) == true {
    $all_devel_bool = str2bool($all_devel)
  } else {
    $all_devel_bool = $all_devel
  }

  if is_string($devel) == true {
    $devel_bool = str2bool($devel)
  } else {
    $devel_bool = $devel
  }

  if is_string($doc) == true {
    $doc_bool = str2bool($doc)
  } else {
    $doc_bool = $doc
  }
  # </stringified variable handling>

  # <variable validations>
  validate_bool($all_devel_bool)
  validate_bool($devel_bool)
  validate_bool($doc_bool)
  validate_string($package_ensure)
  validate_hash($packages)
  validate_string($prefix)
  validate_string($suffix)
  validate_string($suffix_dev)
  validate_string($version)
  # </variable validations>

  anchor { "${module_name}::begin": } ->
  class { "${module_name}::install": } ->
  anchor { "${module_name}::end": }
}
