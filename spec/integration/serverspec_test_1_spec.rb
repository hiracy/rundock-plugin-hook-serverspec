require 'spec_helper'

describe file('/var/tmp/hello_rundock_plugin_hook_serverspec_1_from_scenario') do
  it { should be_file }
  its(:content) { should match(/Hello Rundock plugin hook serverspec from Scenario./) }
end
