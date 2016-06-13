# etcd #
[![Build Status](https://travis-ci.org/cristifalcas/puppet-etcd.png?branch=master)](https://travis-ci.org/cristifalcas/puppet-etcd)

This module installs and configures etcd.

A basic provider is also implemented that can add/update/delete node keys

Because of the way etcd is working, you can't change any of the initial cluster variables after first run:

    initial_advertise_peer_urls
    initial_cluster
    initial_cluster_state
    initial_cluster_token

This is annoying if you first bootstraped the cluster in http mode and you want to add ssl after that to initial_cluster parameter.

Solution:
* Don't care. Even if the protocol is http, the communication will be over ssl
* redeploy the cluster (rm -rf /var/lib/etcd/$data_dir)

##Usage:

### Basic usage:

    include etcd

or

    class { 'etcd':
      ensure                     => 'latest',
      etcd_listen_client_urls    => 'http://0.0.0.0:2379',
    }

Add a key/value pair to etcd:

	etcd_key { '/coreos.com/network/config': value => '{ "Network": "10.1.0.0/16" }' }

Remove a key:

    etcd_key { '/coreos.com/network1/config': ensure => absent }

### Deploy a cluster:

    class { 'etcd':
	    listen_client_urls          => 'http://0.0.0.0:2379',
	    advertise_client_urls       => "http://${::fqdn}:2379,http://127.0.0.1:2379",
	    listen_peer_urls            => 'http://0.0.0.0:2380',
	    initial_advertise_peer_urls => "http://${::fqdn}:2380,http://127.0.0.1:2379",
	    initial_cluster             => [
	      "${::hostname}=http://${::fqdn}:2380",
	      'infra1=http://infra1.domain.net:2380',
	      'infra2=http://infra2.domain.net:2380'],
    }

### Enable ssl for client communication:

    class { 'etcd':
      ensure                      => 'latest',
      etcd_name                   => $::hostname,
      listen_client_urls          => 'https://0.0.0.0:2379',
      advertise_client_urls       => "https://${::fqdn}:2379",
      # clients should speak over ssl
      cert_file                   => "${::settings::ssldir}/certs/${::clientcert}.pem",
      key_file                    => "${::settings::ssldir}/private_keys/${::clientcert}.pem",
      # authorize clients
      client_cert_auth            => true,
      # and verify clients certificates
      trusted_ca_file             => "${::settings::ssldir}/certs/ca.pem",
      initial_cluster             => [
	      "${::hostname}=http://${::fqdn}:2380",
	      'infra1=http://infra1.domain.net:2380',
	      'infra2=http://infra2.domain.net:2380'],
    }

Use the etcd provider with ssl certificates:

    etcd_key { '/coreos.com/network/config':
      value     => '{ "Network": "10.1.0.0/18" }',
      peers     => "https://${::fqdn}:2379",
      cert_file => "${::settings::ssldir}/certs/${::clientcert}.pem",
      key_file  => "${::settings::ssldir}/private_keys/${::clientcert}.pem",
      # verify server ceretificate
      ca_file   => "${::settings::ssldir}/certs/ca.pem",
    }

### Deploy a cluster with full ssl for both clients and peers

    class { 'etcd':
      ensure                      => 'latest',
      etcd_name                   => $::hostname,
      # clients
      listen_client_urls          => 'https://0.0.0.0:2379',
      advertise_client_urls       => "https://${::fqdn}:2379",
      # clients ssl
      cert_file => '/etc/pki/puppet_certs/etcd/public_cert.pem',
      key_file  => '/etc/pki/puppet_certs/etcd/private_cert.pem',
      # authorize clients
      client_cert_auth            => true,
      # verify clients certificates
      trusted_ca_file             => '/etc/pki/puppet_certs/etcd/ca_cert.pem',
      # cluster
      listen_peer_urls            => 'https://0.0.0.0:2380',
      initial_advertise_peer_urls => "https://${::fqdn}:2380",
      initial_cluster             => [
	      "${::hostname}=http://${::fqdn}:2380",
	      'infra1=http://infra1.domain.net:2380',
	      'infra2=http://infra2.domain.net:2380'],
      # peers ssl
      peer_cert_file              => '/etc/pki/puppet_certs/etcd/public_cert.pem',
      peer_key_file               => '/etc/pki/puppet_certs/etcd/private_cert.pem',
      # authorize peers
      peer_client_cert_auth       => true,
      # verify peers certificates
      peer_trusted_ca_file        => '/etc/pki/puppet_certs/etcd/ca_cert.pem',
      debug     => true,
    }

### Deploy a proxy

If the $proxy parameter is undef, we will try to guess if the node should be a proxy by
checking if $::fqdn or $::ipaddress appears in initial_cluster parameter.

    class { 'etcd':
      ensure                      => 'latest',
      etcd_name                   => $::hostname,
      proxy                       => 'on',
      # clients
      listen_client_urls          => 'https://0.0.0.0:2379',
      advertise_client_urls       => "https://${::fqdn}:2379",
      # clients ssl
      cert_file => '/etc/pki/puppet_certs/etcd/public_cert.pem',
      key_file  => '/etc/pki/puppet_certs/etcd/private_cert.pem',
      # authorize clients
      client_cert_auth            => true,
      # verify clients certificates
      trusted_ca_file             => '/etc/pki/puppet_certs/etcd/ca_cert.pem',
      # cluster
      listen_peer_urls            => 'https://0.0.0.0:2380',
      initial_cluster             => [
	      'infra0=http://infra0.domain.net:2380',
	      'infra1=http://infra1.domain.net:2380',
	      'infra2=http://infra2.domain.net:2380'],
      # peers ssl
      peer_cert_file              => '/etc/pki/puppet_certs/etcd/public_cert.pem',
      peer_key_file               => '/etc/pki/puppet_certs/etcd/private_cert.pem',
      # authorize peers
      peer_client_cert_auth       => true,
      # verify peers certificates
      peer_trusted_ca_file        => '/etc/pki/puppet_certs/etcd/ca_cert.pem',
      debug     => true,
    }

## Journald forward:

The class support a parameter called journald_forward_enable.

This was added because of the PIPE signal that is sent to go programs when systemd-journald dies.

For more information read here: https://github.com/projectatomic/forward-journald

### Usage:

	  include ::forward_journald
	  Class['forward_journald'] -> Class['etcd']
