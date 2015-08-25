require 'serverspec'
require 'net/ssh'
require 'yaml'

def ssh_opts
  if ENV['SSH_CONFIG'] && FileTest.exists?(ENV['SSH_CONFIG'])
    opts = Net::SSH::Config.for(ENV['TARGET_HOST'] , [ENV['SSH_CONFIG']])
  else
    opts = Net::SSH::Config.for(ENV['TARGET_HOST'])
  end

  opts[:host_name] = ENV['TARGET_SSH_HOST']
  opts[:user] = ENV['USER'] || Etc.getlogin
  opts[:keys] = ENV['KEYS'].split(',') if ENV['KEYS']
  opts[:password] = ENV['PASSWORD'] if ENV['PASSWORD']
  opts[:proxy] = Kernel.eval(ENV['PROXY']) if ENV['PROXY']
  opts[:port] = ENV['PORT'] if ENV['PORT']
  opts[:user_known_hosts_file] = ENV['USER_KNOWN_HOSTS_FILE'] if ENV['USER_KNOWN_HOSTS_FILE']
  opts[:encryption] = ENV['ENCRIPTION'] if ENV['ENCRIPTION']
  opts[:compression] = ENV['COMPRESSION'] if ENV['COMPRESSION']
  opts[:compression_level] = ENV['COMPRESSION_LEVEL'] if ENV['COMPRESSION_LEVEL']
  opts[:timeout] = ENV['TIMEOUT'] if ENV['TIMEOUT']
  opts[:forward_agent] = ENV['FORWARD_AGENT'] if ENV['FORWARD_AGENT']
  opts[:global_known_hosts_file] = ENV['GLOBAL_KNOWN_HOSTS_FILE'] if ENV['GLOBAL_KNOWN_HOSTS_FILE']
  opts[:auth_methods] = ENV['AUTH_METHODS'].split(',') if ENV['AUTH_METHODS']
  opts[:hmac] = ENV['HMAC'] if ENV['HMAC']
  opts[:rekey_limit] = ENV['REKEY_LIMIT'] if ENV['REKEY_LIMIT']

  opts
end

set_property(YAML.load_file(ENV['HOST_PROPERTIES'])[ENV['TARGET_HOST']]) if ENV['HOST_PROPERTIES']

if ENV['TARGET_SSH_HOST'] != 'localhost'&&
   ENV['TARGET_SSH_HOST'] != '127.0.0.1'

  set :ssh_options, ssh_opts
  set :backend, :ssh
else
  set :backend, :exec
end
