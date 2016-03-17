# == Class: etcd::config
#
class etcd::config {
  file { $::etcd::config_file_path:
    ensure  => 'file',
    content => template("${module_name}/etc/etcd/etcd.conf.erb"),
  }
}
