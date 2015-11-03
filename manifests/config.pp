# == Class: etcd::config
#
class etcd::config {
  file { '/etc/etcd/etcd.conf':
    ensure  => 'file',
    content => template("${module_name}/etc/etcd/etcd.conf.erb"),
  }
}
