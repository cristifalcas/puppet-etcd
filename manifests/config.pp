# == Class: etcd::config
#
class etcd::config {
  file { '/etc/etcd/etcd.conf':
    ensure  => present,
    content => template("${module_name}/etc/etcd/etcd.conf.erb"),
  }
}
