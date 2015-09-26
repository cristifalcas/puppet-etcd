# Class: etcd
#
# This module manages etcd
#
# Parameters:
#
# [*ensure*]
#   Passed to the docker package.
#   Defaults to present
#
# [*service_state*]
#   Whether you want to kube daemons to start up
#   Defaults to running
#
# [*service_enable*]
#   Whether you want to kube daemons to start up at boot
#   Defaults to true
#
#  member
# [*etcd_name*]
#
# [*etcd_data_dir*]
#
# [*etcd_snapshot_counter*]
#
# [*etcd_heartbeat_interval*]
#
# [*etcd_election_timeout*]
#
# [*etcd_listen_peer_urls*]
#
# [*etcd_listen_client_urls*]
#
# [*etcd_max_snapshots*]
#
# [*etcd_max_wals*]
#
# [*etcd_cors*]
#
# cluster
# [*enable_cluster*]
#
# [*etcd_initial_advertise_peer_urls*]
#
# [*etcd_initial_cluster*]
#
# [*etcd_initial_cluster_state*]
#
# [*etcd_initial_cluster_token*]
#
# [*etcd_advertise_client_urls*]
#
# [*etcd_discovery*]
#
# [*etcd_discovery_srv*]
#
# [*etcd_discovery_fallback*]
#
# [*etcd_discovery_proxy*]
#
# proxy
# [*etcd_cert_file*]
#
# [*etcd_key_file*]
#
# [*etcd_client_cert_auth*]
#
# [*etcd_trusted_ca_file*]
#
# [*etcd_peer_cert_file*]
#
# [*etcd_peer_key_file*]
#
# [*etcd_peer_client_cert_auth*]
#
# [*etcd_peer_trusted_ca_file*]
#
# logging
# [*etcd_debug*]
#
# [*etcd_log_package_levels*]
#
class etcd (
  $ensure                           = $etcd::params::ensure,
  $service_state                    = $etcd::params::service_state,
  $service_enable                   = $etcd::params::service_enable,
  # member
  $etcd_name                        = $etcd::params::etcd_name,
  $etcd_data_dir                    = $etcd::params::etcd_data_dir,
  $etcd_snapshot_counter            = $etcd::params::etcd_snapshot_counter,
  $etcd_heartbeat_interval          = $etcd::params::etcd_heartbeat_interval,
  $etcd_election_timeout            = $etcd::params::etcd_election_timeout,
  $etcd_listen_peer_urls            = $etcd::params::etcd_listen_peer_urls,
  $etcd_listen_client_urls          = $etcd::params::etcd_listen_client_urls,
  $etcd_max_snapshots               = $etcd::params::etcd_max_snapshots,
  $etcd_max_wals                    = $etcd::params::etcd_max_wals,
  $etcd_cors                        = $etcd::params::etcd_cors,
  # cluster
  $enable_cluster                   = $etcd::params::enable_cluster,
  $etcd_initial_advertise_peer_urls = $etcd::params::etcd_initial_advertise_peer_urls,
  $etcd_initial_cluster             = $etcd::params::etcd_initial_cluster,
  $etcd_initial_cluster_state       = $etcd::params::etcd_initial_cluster_state,
  $etcd_initial_cluster_token       = $etcd::params::etcd_initial_cluster_token,
  $etcd_advertise_client_urls       = $etcd::params::etcd_advertise_client_urls,
  $etcd_discovery                   = $etcd::params::etcd_discovery,
  $etcd_discovery_srv               = $etcd::params::etcd_discovery_srv,
  $etcd_discovery_fallback          = $etcd::params::etcd_discovery_fallback,
  $etcd_discovery_proxy             = $etcd::params::etcd_discovery_proxy,
  # proxy
  $etcd_proxy                       = $etcd::params::etcd_proxy,
  # security
  $etcd_cert_file                   = $etcd::params::etcd_cert_file,
  $etcd_key_file                    = $etcd::params::etcd_key_file,
  $etcd_client_cert_auth            = $etcd::params::etcd_client_cert_auth,
  $etcd_trusted_ca_file             = $etcd::params::etcd_trusted_ca_file,
  $etcd_peer_cert_file              = $etcd::params::etcd_peer_cert_file,
  $etcd_peer_key_file               = $etcd::params::etcd_peer_key_file,
  $etcd_peer_client_cert_auth       = $etcd::params::etcd_peer_client_cert_auth,
  $etcd_peer_trusted_ca_file        = $etcd::params::etcd_peer_trusted_ca_file,
  # logging
  $etcd_debug                       = $etcd::params::etcd_debug,
  $etcd_log_package_levels          = $etcd::params::etcd_log_package_levels,
) inherits etcd::params {
  class { 'etcd::install': } ->
  class { 'etcd::config': } ~>
  class { 'etcd::service': }

  contain 'etcd::install'
  contain 'etcd::config'
  contain 'etcd::service'
}
