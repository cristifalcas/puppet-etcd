# == Class: etcd::service
#
# Class to manage the etcd service daemon
#
class etcd::service {
  service { 'etcd':
    ensure => $etcd::service_ensure,
    enable => $etcd::service_enable,
  }
}
