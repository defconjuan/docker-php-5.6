class php::extension::blackfire {
  require php

  exec { 'mkdir -p /var/run/blackfire':
    path => ['/bin']
  }

  exec { 'mkdir -p /phpfarm/inst/php-5.6.1/lib/php/extensions/no-debug-non-zts-20131226':
    path => ['/bin']
  }

  file { '/phpfarm/inst/php-5.6.1/lib/php/extensions/no-debug-non-zts-20131226/blackfire-php-linux_amd64-php-56.so':
    ensure => present,
    source => 'puppet:///modules/php/tmp/blackfire-php-linux_amd64-php-56.so',
    require => Exec['mkdir -p /phpfarm/inst/php-5.6.1/lib/php/extensions/no-debug-non-zts-20131226']
  }

  exec { '/bin/su - root -c "curl -s https://packagecloud.io/gpg.key | apt-key add -"': }

  file { '/etc/apt/sources.list.d/blackfire.list':
    ensure => present,
    source => 'puppet:///modules/php/etc/apt/sources.list.d/blackfire.list',
    mode => 644,
    require => Exec['/bin/su - root -c "curl -s https://packagecloud.io/gpg.key | apt-key add -"']
  }

  exec { 'apt-get update':
    path => ['/usr/bin'],
    require => File['/etc/apt/sources.list.d/blackfire.list']
  }

  package {[
      'blackfire-agent'
    ]:
    ensure => present,
    require => Exec['apt-get update']
  }
}
