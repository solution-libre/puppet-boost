# Private class
class boost::install inherits boost {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $boost::all_devel_bool {
    package { 'boost-devel':
      ensure => $boost::package_ensure,
      name   => $boost::all_devel_package_name,
    }
  }

  if $boost::doc_bool {
    package { 'boost-doc':
      ensure => $boost::package_ensure,
      name   => $boost::doc_package_name,
    }
  }

  $defaults = {
    'devel'      => $boost::devel_bool,
    'ensure'     => $boost::package_ensure,
    'prefix'     => $boost::prefix,
    'suffix'     => $boost::suffix,
    'suffix_dev' => $boost::suffix_dev,
    'version'    => $boost::version,
  }

  create_resources(boost::package, $boost::packages, $defaults)
}
