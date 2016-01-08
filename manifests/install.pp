# == Class: etcd
#
class etcd::install {
  if $::etcd::mange_package {
    package { 'etcd': ensure => $etcd::ensure, }
  } else {
    # make sure /etc/etcd is present
	file {'/etc/etcd/':
	  ensure => directory,
	}
  }
}
