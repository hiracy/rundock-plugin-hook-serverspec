# Rundock::Plugin::Hook::Serverspec
[![Gem Version](https://badge.fury.io/rb/rundock-plugin-hook-serverspec.svg)](http://badge.fury.io/rb/rundock-plugin-hook-serverspec) [![Circle CI](https://circleci.com/gh/hiracy/rundock-plugin-hook-serverspec/tree/master.png?style=shield)](https://circleci.com/gh/hiracy/rundock-plugin-hook-serverspec/tree/master)

[Rundock](https://github.com/hiracy/rundock) plugin for [serverspec](http://serverspec.org) hook.

## Installation

```
$ gem install rundock
```

```
$ gem install rundock-plugin-hook-serverspec
```

## Usage

Edit your operation scenario to hooks.yml like this sample.

```
serverspec_test_1:                              # hook name
  hook_type: serverspec                         # hook_type(always specify 'serverspec')
  pattern: /path/to/serverspec_test_1_spec.rb   # serverspec codes file pattern
  host_properties: /path/to/properties.yml      # host specific properties(http://serverspec.org/advanced_tips.html
serverspec_test_2:
  hook_type: serverspec
  pattern: /path/to/serverspec_test_2_spec.rb
```

And edit your operation scenario to "[scenario.yml](https://github.com/hiracy/rundock/blob/master/scenario_sample.yml)" like this sample.

```
- node: anyhost-01
  deploy:
    - src: /path/to/great/middleware/conf_src.rb             # deploy source file from localhost
      dst: /path/to/great/middleware/conf_dst.rb             # deploy destination file to remotehost
  command:
    - /etc/init.d/great_middleware start
  hook:
    - serverspec_test-1                                      # enable hook(hooks.yml/serverspec_test_1)
    - serverspec_test-2
---
anyhost-01:                               # see rundock options(https://github.com/hiracy/rundock/blob/master/README.md)
  host: 192.168.10.11
  ssh_opts:
    port: 22
    user: anyuser
    key:  ~/.ssh/id_rsa
```

and execute rundock.

    $ rundock do /path/to/your-dir/scenario.yml -k /path/to/your-dir/hooks.yml

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rundock-plugin-operation-itamae/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

