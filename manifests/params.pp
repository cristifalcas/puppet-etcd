# == Class: etcd::params
#
# Default parameter values for the etcd module
#
class etcd::params {
  $ensure = 'present'
  $package_name = 'etcd'
  $manage_package = true
  $manage_service = true

  case $::osfamily {
    'RedHat' : {
      case $::operatingsystemmajrelease {
        '6'     : { $config_file_path = '/etc/sysconfig/etcd' }
        '7'     : { $config_file_path = '/etc/etcd/etcd.conf' }
        default : { fail('Unsupported RedHat release.') }
      }
    }
    'Debian' : {
      $config_file_path = '/etc/default/etcd.conf'
    }
    default  : {
      fail('Unsupported OS.')
    }
  }

  $service_ensure = 'running'
  $service_enable = true
  # member options
  $wal_dir = ''
  $snapshot_count = 10000
  $heartbeat_interval = 100
  $election_timeout = 1000
  $listen_client_urls = ['http://localhost:2379', 'http://localhost:4001']
  $advertise_client_urls = ['http://localhost:2379', 'http://localhost:4001']
  $max_snapshots = 5
  $max_wals = 5
  $cors = undef

  # cluster options
  $cluster_enabled = true
  $listen_peer_urls = ['http://localhost:2380', 'http://localhost:7001']
  $initial_advertise_peer_urls = ['http://localhost:2380']
  $initial_cluster_state = 'new'
  $initial_cluster_token = 'etcd-cluster'
  $discovery = undef
  $discovery_srv = undef
  $discovery_fallback = 'proxy'
  $discovery_proxy = undef
  $strict_reconfig_check = false
  $auto_compaction_retention = undef

  # proxy
  $proxy = undef
  $proxy_failure_wait = 5000
  $proxy_refresh_interval = 30000
  $proxy_dial_timeout = 1000
  $proxy_write_timeout = 5000
  $proxy_read_timeout = 0

  # security
  $cert_file = undef
  $key_file = undef
  $client_cert_auth = false
  $trusted_ca_file = undef
  $auto_tls = undef
  $peer_cert_file = undef
  $peer_key_file = undef
  $peer_client_cert_auth = false
  $peer_trusted_ca_file = undef
  $peer_auto_tls = undef

  # logging
  $debug = false
  $log_package_levels = undef

  $journald_forward_enable = false
}
