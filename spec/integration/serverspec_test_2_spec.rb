require 'spec_helper'

describe file('/var/tmp/hello_rundock_plugin_hook_serverspec_2_from_scenario') do
  it { should be_file }
  its(:content) { should match(/Hello Rundock plugin hook serverspec from Scenario./) }
end

describe property['host_depend_string'] do
  it { should == 'anyhost-01_depend_string' }
end
