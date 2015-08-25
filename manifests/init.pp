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

  $defaults = {
    'devel'      => $devel,
    'ensure'     => $package_ensure,
    'prefix'     => $prefix,
    'suffix'     => $suffix,
    'suffix_dev' => $suffix_dev,
    'version'    => $version,
  }

  create_resources(boost::package, $packages, $defaults)
}
