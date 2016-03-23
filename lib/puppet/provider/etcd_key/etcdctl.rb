Puppet::Type.type(:etcd_key).provide(:etcdctl) do
  commands :etcdctl => '/usr/bin/etcdctl'

  def arguments
    args = ['--peers', @resource[:peers]]
    if @resource[:cert_file] && @resource[:key_file]
      args << '--cert-file' << @resource[:cert_file] << '--key-file' << @resource[:key_file]
    end

    if @resource[:ca_file]
      args << '--ca-file' << @resource[:ca_file]
    end

    if @resource[:username] and @resource[:password]
      args << '--username' << @resource[:username]+":"+@resource[:password]
    end
    args
  end

  def exists?
    begin
      value
    rescue Puppet::ExecutionFailure => e
      return false
    end
    return true
  end

  def create
    args = arguments
    args << 'set'  << @resource[:name] << @resource[:value]
    debug "[etcd create]: etcdctl #{args}\n"
    etcdctl(args)
  end

  def destroy
    args = arguments
    args << 'rm'  << @resource[:name]
    debug "[etcd rm]: etcdctl #{args}\n"
    etcdctl(args)
  end

  def value
    args = arguments
    args << 'get'  << @resource[:name]
    debug "[etcd get]: etcdctl #{args}\n"
    etcdctl(args).chomp
  end

  def value=(val)
    args = arguments
    debug "[etcd set]: etcdctl #{args}\n"
    args << 'set'  << @resource[:name] << val
    etcdctl(args)
  end
end
