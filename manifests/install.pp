# == Class: etcd
#
class etcd::install {
  package { 'etcd': ensure => $etcd::ensure, }
}
