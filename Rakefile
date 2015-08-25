require 'bundler/gem_tasks'
require 'rspec'
require 'rspec/core/rake_task'

task :default => [:spec]

desc 'Run all tests.'
task :spec => ['clean', 'rundock']

desc 'Cleaning environments'

task :clean do
  Bundler.with_clean_env do
    system 'rm -f /var/tmp/hello_rundock*'
  end
end

desc "Run rundock-serverspec plugin"

task :rundock do
  cmd = 'bundle exec rundock do ./spec/integration/scenario.yml -k ./spec/integration/hooks.yml -l debug'
  puts "[EXEC: ] #{cmd}"
  system cmd
end

task :serverspec do
  RSpec::Core::RakeTask.new(:serverspec) do |rt|
    rt.ruby_opts = "-I #{File.expand_path(File.dirname(__FILE__))}"
    rt.pattern = ENV['PATTERN'].split(',')
  end
end
