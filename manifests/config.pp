# == Class: etcd::config
#
class etcd::config {
  case $::osfamily {
    'RedHat' : {
      case $::operatingsystemmajrelease {
        6       : {
          file { '/etc/sysconfig/etcd.conf':
            ensure  => 'file',
            content => template("${module_name}/etc/etcd/etcd.conf.erb"),
          }
        }
        7       : {
          file { '/etc/etcd/': ensure => 'directory', } ->
          file { '/etc/etcd/etcd.conf':
            ensure  => 'file',
            content => template("${module_name}/etc/etcd/etcd.conf.erb"),
          }
        }
        default : {
          fail('Unsupported OS.')
        }
      }
    }
    'Debian' : {
      file { '/etc/default/etcd.conf':
        ensure  => 'file',
        content => template("${module_name}/etc/etcd/etcd.conf.erb"),
      }
    }
    default : {
      fail('Unsupported OS.')
    }
  }
}
