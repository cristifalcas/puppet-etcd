# == Class: etcd::params
#
# Default parameter values for the etcd module
#
class etcd::params {
  $ensure = 'present'
  $service_state = running
  $service_enable = true
  # member options
  $etcd_name = 'default'
  $etcd_data_dir = '/var/lib/etcd/default.etcd'
  $etcd_snapshot_counter = 10000
  $etcd_heartbeat_interval = 100
  $etcd_election_timeout = 1000
  $etcd_listen_peer_urls = 'http://localhost:2380'
  $etcd_listen_client_urls = 'http://localhost:2379'
  $etcd_max_snapshots = 5
  $etcd_max_wals = 5
  $etcd_cors = ''

  # cluster options
  $enable_cluster = false
  $etcd_initial_advertise_peer_urls = 'http://localhost:2380'
  $etcd_initial_cluster = 'http://localhost:2380'
  $etcd_initial_cluster_state = 'new'
  $etcd_initial_cluster_token = 'etcd-cluster'
  $etcd_advertise_client_urls = 'http://localhost:2379'
  $etcd_discovery = ''
  $etcd_discovery_srv = ''
  $etcd_discovery_fallback = 'proxy'
  $etcd_discovery_proxy = ''

  # proxy
  $etcd_proxy = 'off'

  # security
  $etcd_cert_file = ''
  $etcd_key_file = ''
  $etcd_client_cert_auth = false
  $etcd_trusted_ca_file = ''
  $etcd_peer_cert_file = ''
  $etcd_peer_key_file = ''
  $etcd_peer_client_cert_auth = false
  $etcd_peer_trusted_ca_file = ''

  # logging
  $etcd_debug = false
  $etcd_log_package_levels = ''
}
