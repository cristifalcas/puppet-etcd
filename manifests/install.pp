# == Class: etcd
#
class etcd::install {
  if $::etcd::mange_package {
    package { 'etcd': ensure => $etcd::ensure, }
  }
}
