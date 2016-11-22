# == Class: etcd
#
class etcd::install {
  if $::etcd::manage_package {
    package { $::etcd::package_name: ensure => $::etcd::ensure, }
  }
}
