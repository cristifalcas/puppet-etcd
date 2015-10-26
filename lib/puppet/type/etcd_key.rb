Puppet::Type.newtype(:etcd_key) do
  @doc = <<-EOT
    doc 
  EOT

  autorequire(:service) do
    ['etcd']
  end

  ensurable do
    desc <<-EOS
      Create/Remove etcd keys or dirs.
    EOS

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc "path of the key"
  end

  newproperty(:value) do
    desc "set a specific value for this key"
    munge do |value|
      value.chomp
    end
  end

  newparam(:peers) do
    desc "a comma-delimited list of machine addresses in the cluster"
    defaultto '127.0.0.1:4001,127.0.0.1:2379'
  end

  newparam(:cert_file) do
    desc "identify HTTPS client using this SSL certificate file"
    defaultto false
  end

  newparam(:key_file) do
    desc "identify HTTPS client using this SSL key file"
    defaultto false
  end

  newparam(:ca_file) do
    desc "verify certificates of HTTPS-enabled servers using this CA bundle"
    defaultto false
  end

  newparam(:username) do
    desc "provide username"
    defaultto false
  end

  newparam(:password) do
    desc "provide password"
    defaultto false
  end
end
