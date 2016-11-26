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
# [*package_name*]
#   Set the etcd package name.
#   Defaults to etcd
#
# [*manage_package*]
#   If the module should manage the package
#   Defaults to running
#
# [*manage_service*]
#   If the module should manage the service
#   Defaults to running
#
# [*config_file_path*]
#   Where the config file should be put
#   Defaults to running
#
# [*service_ensure*]
#   Whether you want to etcd daemons to start up
#   Defaults to running
#
# [*service_enable*]
#   Whether you want to etcd daemons to start up at boot
#   Defaults to true
#
#  member
# [*etcd_name*]
#   Human-readable name for this member.
#   Default: "default"
#
# [*data_dir*]
#   Path to the data directory.
#   default: "${name}.etcd"
#
# [*wal_dir*]
#   Path to the dedicated wal directory. If this flag is set, etcd will write the WAL
#   files to the walDir rather than the dataDir. This allows a dedicated disk to be used,
#   and helps avoid io competition between logging and other IO operations.
#   default: ""
#
# [*snapshot_count*]
#   Number of committed transactions to trigger a snapshot to disk.
#   default: "10000"
#
# [*heartbeat_interval*]
#   Time (in milliseconds) of a heartbeat interval.
#   default: "100"
#
# [*election_timeout*]
#   Time (in milliseconds) for an election to timeout. See Documentation/tuning.md for details.
#   default: "1000"
#
# [*listen_peer_urls*]
#   List of URLs to listen on for peer traffic. This flag tells the etcd to accept incoming
#   requests from its peers on the specified scheme://IP:port combinations. Scheme can be either
#   http or https.If 0.0.0.0 is specified as the IP, etcd listens to the given port on all interfaces.
#   If an IP address is given as well as a port, etcd will listen on the given port and interface.
#   Multiple URLs may be used to specify a number of addresses and ports to listen on. The etcd will
#   respond to requests from any of the listed addresses and ports.
#   default: "http://localhost:2380,http://localhost:7001"
#
# [*listen_client_urls*]
#   List of URLs to listen on for client traffic. This flag tells the etcd to accept incoming requests
#   from the clients on the specified scheme://IP:port combinations. Scheme can be either http or https.
#   If 0.0.0.0 is specified as the IP, etcd listens to the given port on all interfaces. If an IP address
#   is given as well as a port, etcd will listen on the given port and interface. Multiple URLs may be used
#   to specify a number of addresses and ports to listen on. The etcd will respond to requests from any of
#   the listed addresses and ports.
#   default: "http://localhost:2379,http://localhost:4001"
#
# [*max_snapshots*]
#   Maximum number of snapshot files to retain (0 is unlimited)
#   default: 5
#
# [*max_wals*]
#   Maximum number of wal files to retain (0 is unlimited)
#   default: 5
#
# [*cors*]
#   Comma-separated white list of origins for CORS (cross-origin resource sharing).
#   default: none
#
# cluster
#
# [*cluster_enabled*]
#   If set to false, all clustering options will be omitted from the final config file. Fixes some problems
#   with older etcd versions.
#   default: true
#
# [*initial_advertise_peer_urls*]
#   List of this member's peer URLs to advertise to the rest of the cluster. These addresses
#   are used for communicating etcd data around the cluster. At least one must be routable to
#   all cluster members. These URLs can contain domain names.
#   default: "http://localhost:2380,http://localhost:7001"
#
# [*initial_cluster*]
#   Initial cluster configuration for bootstrapping.
#   default: "default=http://localhost:2380,default=http://localhost:7001"
#
# [*initial_cluster_state*]
#   Initial cluster state ("new" or "existing"). Set to new for all members present during initial
#   static or DNS bootstrapping. If this option is set to existing, etcd will attempt to join the
#   existing cluster. If the wrong value is set, etcd will attempt to start but fail safely.
#   default: "new"
#
# [*initial_cluster_token*]
#   Initial cluster token for the etcd cluster during bootstrap.
#   default: "etcd-cluster"
#
# [*advertise_client_urls*]
#   List of this member's client URLs to advertise to the rest of the cluster. These URLs can contain domain names.
#   default: "http://localhost:2379,http://localhost:4001"
#
# [*discovery*]
#   Discovery URL used to bootstrap the cluster.
#   default: none
#
# [*discovery_srv*]
#   DNS srv domain used to bootstrap the cluster.
#   default: none
#
# [*discovery_fallback*]
#   Expected behavior ("exit" or "proxy") when discovery services fails.
#   default: "proxy"
#
# [*discovery_proxy*]
#   HTTP proxy to use for traffic to discovery service.
#   default: none
#
# [*strict_reconfig_check*]
#   Reject reconfiguration requests that would cause quorum loss.
#   default: false
#
# [*auto_compaction_retention*]
#   Auto compaction retention for mvcc key value store in hour. 0 means disable auto compaction. Defaults to 0
#   default: undef
#
# proxy
# [*proxy*]
#   Proxy mode setting ("off", "readonly" or "on").
#   default: "off"
#
# [*proxy_failure_wait*]
#   Time (in milliseconds) an endpoint will be held in a failed state before being reconsidered for proxied requests.
#   default: 5000
#
# [*proxy_refresh_interval*]
#   Time (in milliseconds) of the endpoints refresh interval.
#   default: 30000
#
# [*proxy_dial_timeout*]
#   Time (in milliseconds) for a dial to timeout or 0 to disable the timeout
#   default: 1000
#
# [*proxy_write_timeout*]
#   Time (in milliseconds) for a write to timeout or 0 to disable the timeout.
#   default: 5000
#
# [*proxy_read_timeout*]
#   Time (in milliseconds) for a read to timeout or 0 to disable the timeout.
#   Don't change this value if you use watches because they are using long polling requests.
#   default: 0
#
# security
# [*cert_file*]
#   Path to the client server TLS cert file.
#   default: none
#
# [*key_file*]
#   Path to the client server TLS key file.
#   default: none
#
# [*client_cert_auth*]
#   Enable client cert authentication.
#   default: false
#
# [*trusted_ca_file*]
#   Path to the client server TLS trusted CA key file.
#   default: none
#
# [*auto_tls*]
#   Client TLS using generated certificates. Defaults to false
#   default: none
#
# [*peer_cert_file*]
#   Path to the peer server TLS cert file.
#   default: none
#
# [*peer_key_file*]
#   Path to the peer server TLS key file.
#   default: none
#
# [*peer_client_cert_auth*]
#   Enable peer client cert authentication.
#   default: false
#
# [*peer_trusted_ca_file*]
#   Path to the peer server TLS trusted CA file.
#   default: none
#
# [*peer_auto_tls*]
#   Peer TLS using generated certificates. Defaults to false
#   default: none
#
# logging
# [*debug*]
#   Drop the default log level to DEBUG for all subpackages.
#   default: false (INFO for all packages)
#
# [*log_package_levels*]
#   Set individual etcd subpackages to specific log levels. An example being etcdserver=WARNING,security=DEBUG
#   default: none (INFO for all packages)
#
# [*journald_forward_enable*]
#   Enable log forwarding via journald_forward_enable
#
class etcd (
  $ensure                      = $etcd::params::ensure,
  $package_name                = $etcd::params::package_name,
  $manage_package              = $etcd::params::manage_package,
  $manage_service              = $etcd::params::manage_service,
  $config_file_path            = $etcd::params::config_file_path,
  $service_ensure              = $etcd::params::service_ensure,
  $service_enable              = $etcd::params::service_enable,
  # member
  $etcd_name                   = 'default',
  $data_dir                    = "/var/lib/etcd/${etcd_name}.etcd",
  $wal_dir                     = $etcd::params::wal_dir,
  $snapshot_count              = $etcd::params::snapshot_count,
  $heartbeat_interval          = $etcd::params::heartbeat_interval,
  $election_timeout            = $etcd::params::election_timeout,
  $listen_client_urls          = $etcd::params::listen_client_urls,
  $advertise_client_urls       = $etcd::params::advertise_client_urls,
  $max_snapshots               = $etcd::params::max_snapshots,
  $max_wals                    = $etcd::params::max_wals,
  $cors                        = $etcd::params::cors,
  # cluster
  $cluster_enabled             = $etcd::params::cluster_enabled,
  $listen_peer_urls            = $etcd::params::listen_peer_urls,
  $initial_advertise_peer_urls = $etcd::params::initial_advertise_peer_urls,
  $initial_cluster             = ["${etcd_name}=http://localhost:2380", "${etcd_name}=http://localhost:7001"],
  $initial_cluster_state       = $etcd::params::initial_cluster_state,
  $initial_cluster_token       = $etcd::params::initial_cluster_token,
  $discovery                   = $etcd::params::discovery,
  $discovery_srv               = $etcd::params::discovery_srv,
  $discovery_fallback          = $etcd::params::discovery_fallback,
  $discovery_proxy             = $etcd::params::discovery_proxy,
  $strict_reconfig_check       = $etcd::params::strict_reconfig_check,
  $auto_compaction_retention   = $etcd::params::auto_compaction_retention,
  # proxy
  $proxy                       = $etcd::params::proxy,
  $proxy_failure_wait          = $etcd::params::proxy_failure_wait,
  $proxy_refresh_interval      = $etcd::params::proxy_refresh_interval,
  $proxy_dial_timeout          = $etcd::params::proxy_dial_timeout,
  $proxy_write_timeout         = $etcd::params::proxy_write_timeout,
  $proxy_read_timeout          = $etcd::params::proxy_read_timeout,
  # security
  $cert_file                   = $etcd::params::cert_file,
  $key_file                    = $etcd::params::key_file,
  $client_cert_auth            = $etcd::params::client_cert_auth,
  $trusted_ca_file             = $etcd::params::trusted_ca_file,
  $auto_tls                    = $etcd::params::auto_tls,
  $peer_cert_file              = $etcd::params::peer_cert_file,
  $peer_key_file               = $etcd::params::peer_key_file,
  $peer_client_cert_auth       = $etcd::params::peer_client_cert_auth,
  $peer_trusted_ca_file        = $etcd::params::peer_trusted_ca_file,
  $peer_auto_tls               = $etcd::params::peer_auto_tls,
  # logging
  $debug                       = $etcd::params::debug,
  $log_package_levels          = $etcd::params::log_package_levels,
  $journald_forward_enable     = $etcd::params::journald_forward_enable
) inherits etcd::params {
  validate_integer([
      $snapshot_count,
      $heartbeat_interval,
      $election_timeout,
      $max_snapshots,
      $max_wals,
      $proxy_failure_wait,
      $proxy_refresh_interval,
      $proxy_dial_timeout,
      $proxy_write_timeout,
      $proxy_read_timeout,
  ])
  validate_bool($strict_reconfig_check, $client_cert_auth, $peer_client_cert_auth, $debug, $journald_forward_enable)
  validate_re($initial_cluster_state, '^(new|existing)$')
  validate_re($discovery_fallback, '^(proxy|exit)$')
  validate_absolute_path($data_dir)
  if $cert_file { validate_absolute_path($cert_file) }
  if $key_file { validate_absolute_path($key_file) }
  if $trusted_ca_file { validate_absolute_path($trusted_ca_file) }
  if $peer_cert_file { validate_absolute_path($peer_cert_file) }
  if $peer_key_file { validate_absolute_path($peer_key_file) }
  if $peer_trusted_ca_file { validate_absolute_path($peer_trusted_ca_file) }

  if $proxy {
    validate_re($proxy, '^(on|off|readonly)$')
    $real_proxy = $proxy
  } else {
    $str = join(any2array($initial_cluster), '|')
    if $::fqdn in $str or $::ipaddress in $str {
      $real_proxy = 'off'
    } else {
      $real_proxy = 'on'
    }
  }

  contain '::etcd::install'
  contain '::etcd::config'
  contain '::etcd::service'

  Class['etcd::install'] ->
  Class['etcd::config'] ~>
  Class['etcd::service']
}
