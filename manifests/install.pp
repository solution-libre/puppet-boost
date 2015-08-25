# Private class
class boost::install inherits boost {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $boost::all_devel {
    package { $boost::all_devel_package_name:
      ensure => $boost::package_ensure,
    }
  }

  if $boost::doc {
    package { $boost::doc_package_name:
      ensure => $boost::package_ensure,
    }
  }
}
