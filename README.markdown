# etcd #

This module installs and configures etcd.

Usage:

    include etcd

    class { 'etcd':
      ensure                     => 'latest',
      etcd_listen_client_urls    => 'http://0.0.0.0:2379',
      etcd_listen_peer_urls      => 'http://localhost:2380',
      etcd_advertise_client_urls => 'http://0.0.0.0:2379',
    }
