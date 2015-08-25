require "rundock/plugin/hook/serverspec/version"
require 'rake'

module Rundock
  module Hook
    # You can use this sample as following yaml files for example.
    #
    # rundock do scenario.yml -k hook.yml
    #
    # [hook.yml]
    # check_os:
    #   hook_type: serverspec
    #   pattern: /path/to/check_os/*_spec.rb
    # check_nginx:
    #   hook_type: serverspec
    #   pattern: /path/to/nginx/*_spec.rb
    #   host_properties: /path/to/properties.yml
    #
    # [scenario.yml]
    # - node: anyhost-01
    # hook:
    #   - check_os
    # - node: anyhost-02
    # deploy:
    #   - src: /path/to/nginx.conf.local
    #     dst: /etc/nginx/nginx.conf
    # command:
    #   - 'sudo /etc/init.d/nginx reload'
    # hook:
    #   - check_os
    #   - check_nginx
    # ---
    # anyhost-01:
    #   host: 192.168.1.11
    # # inherit from ./defautl_ssh.yml
    # anyhost-02:
    #   host: 192.168.1.12
    #   ssh_opts:
    #     port: 22
    #     user: anyuser
    #     key:  ~/.ssh/id_rsa
    # ---
    #
    # [properties.yml]
    # anyhost-02:
    #   anykey1: value1
    #   anykey2: value2
     
    class Serverspec < Base
      def hook(log_buffer, node_info)
        setenv(node_info, @contents)
        load "#{::File.expand_path(::File.dirname(__FILE__))}/../../../../Rakefile"
        Logger.info("serverspec started: #{node_info[:nodename]}(#{node_info[:host]})")
        Rake.application[:serverspec].invoke
        Rake.application[:serverspec].reenable
      end

      private
  
      def setenv(nodeinfo, contents)
        ENV['PATTERN'] = Array(@contents[:pattern]).join(',')
        ENV['TARGET_HOST'] = nodeinfo[:nodename]
        ENV['TARGET_SSH_HOST'] = nodeinfo[:host]
        ENV['HOST_PROPERTIES'] = contents[:host_properties]
        ENV['SSH_CONFIG'] = nodeinfo[:ssh_config]
        ENV['KEYS'] = nodeinfo[:keys].join(',') if nodeinfo.key?(:keys)
        ENV['KEYS'] = nodeinfo[:key] if nodeinfo.key?(:key)
        ENV['PASSWORD'] = nodeinfo[:password] if nodeinfo.key?(:password)
        ENV['PROXY'] = nodeinfo[:proxy] if nodeinfo.key?(:proxy)
        ENV['USER'] = nodeinfo[:user] if nodeinfo.key?(:user)
        ENV['PORT'] = nodeinfo[:port].to_s if nodeinfo.key?(:port)
        ENV['USER_KNOWN_HOSTS_FILE'] = nodeinfo[:user_known_hosts_file] if nodeinfo.key?(:user_known_hosts_file)
        ENV['ENCRIPTION'] = nodeinfo[:encryption] if nodeinfo.key?(:encryption)
        ENV['COMPRESSION'] = nodeinfo[:compression] if nodeinfo.key?(:compression)
        ENV['COMPRESSION_LEVEL'] = nodeinfo[:compression_level] if nodeinfo.key?(:compression_level)
        ENV['TIMEOUT'] = nodeinfo[:timeout].to_s if nodeinfo.key?(:timeout)
        ENV['FORWARD_AGENT'] = nodeinfo[:forward_agent] if nodeinfo.key?(:forward_agent)
        ENV['GLOBAL_KNOWN_HOSTS_FILE'] = nodeinfo[:global_known_hosts_file] if nodeinfo.key?(:global_known_hosts_file)
        ENV['AUTH_METHODS'] = nodeinfo[:auth_methods].join(',') if nodeinfo.key?(:auth_methods)
        ENV['HMAC'] = nodeinfo[:hmac] if nodeinfo.key?(:hmac)
        ENV['REKEY_LIMIT'] = nodeinfo[:rekey_limit].to_s if nodeinfo.key?(:rekey_limit)
      end
    end
  end
end
