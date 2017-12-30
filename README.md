# boost

[![Puppet Forge Version](http://img.shields.io/puppetforge/v/solution-libre/boost.svg)](https://forge.puppetlabs.com/soli/boost)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/solution-libre/boost.svg)](https://forge.puppetlabs.com/soli/boost)
[![Puppet Forge Score](http://img.shields.io/puppetforge/f/solution-libre/boost.svg)](https://forge.puppetlabs.com/soli/boost)
[![Build Status](https://travis-ci.org/solution-libre/puppet-boost.svg?branch=master)](https://travis-ci.org/solution-libre/puppet-boost)


#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [Beginning with boost](#beginning-with-boost)
4. [Usage](#usage)
    * [Install header packages](#install-header-packages)
    * [Install all headers packages and the documentation](#install-all-headers-packages-and-the-documentation)
    * [Uninstall a Boost library](#uninstall-a-boost-library)
5. [Reference](#reference)
6. [Limitations](#limitations)
7. [Development](#development)
8. [Contributors](#contributors)

## Overview

Puppet module to manage Boost installation.

## Module Description

This module installs [Boost](http://www.boost.org/) libraries.

## Setup

### Beginning with boost

```puppet
class { 'boost':
  packages => {
    'signals' => {},
    'system' => {},
  }
}
```

## Usage

### Install header packages

```puppet
class { 'boost':
  devel    => true,
  packages => {
    'signals' => {},
    'system' => {},
  }
}
```

### Install all headers packages and the documentation

```puppet
class { 'boost':
  all_devel => true,
  doc       => true,
}
```

### Uninstall a Boost library

```puppet
class { 'boost':
  packages => {
    'signals' => {
      ensure => 'absent',
    },
  }
}
```

## Reference

### Classes

#### Public Classes

* boost: Main class, includes all other classes.

#### Private Classes

* boost::install: Handles the packages.

#### Parameters

The following parameters are available in the `::boost` class:

##### `package_ensure`

Tells Puppet whether the Boost packages should be installed, and what version. Valid options: 'present', 'latest', or a specific version number. Default value: 'present'

##### `packages`

Tells Puppet which Boost libraries to install. Valid options: hash. Default value: {}

##### `prefix`

Tells Puppet what is the first part of Boost packages name. Valid options: string. Default value: varies by operating system

##### `suffix`

Tells Puppet what is the last part of Boost packages name. Valid options: string. Default value: varies by operating system

##### `suffix_dev`

Tells Puppet what is the last part of Boost header packages name. Valid options: string. Default value: varies by operating system

##### `version`

Tells Puppet what is the version part of the Boost packages name. Only needed for Debian family OSes. Valid options: string. Default value: varies by operating system

### Defines

#### Public defines

* boost::package: Adds a Boost librarie.

#### Parameters

The following parameters are available in the `::boost::package` define:

##### `devel`

Tells Puppet whether the Boost header package should be installed. Valid options: boolean. Default value: false

##### `ensure`

Tells Puppet whether the Boost package should be installed, and what version. Valid options: 'present', 'latest', or a specific version number. Default value: 'present'

##### `prefix`

Tells Puppet what is the first part of the Boost package name. Valid options: string. Default value: varies by operating system

##### `suffix`

Tells Puppet what is the last part of the Boost package name. Valid options: string. Default value: varies by operating system

##### `suffix_dev`

Tells Puppet what is the last part of the Boost header package name. Valid options: string. Default value: varies by operating system

##### `version`

Tells Puppet what is the version part of the Boost package name. Only needed for Debian family OSes. Valid options: string. Default value: varies by operating system

## Limitations

RedHat and Debian family OSes are officially supported. Tested and built on Debian and CentOS.

## Development

[Solution Libre](https://www.solution-libre.fr) modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great.

[Fork this module on GitHub](https://github.com/solution-libre/puppet-boost/fork)

## Contributors

The list of contributors can be found at: https://github.com/solution-libre/puppet-boost/graphs/contributors
