class php::extension::xdebug {
  require php

  file { '/tmp/xdebug-2.2.6.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/xdebug-2.2.6.tgz'
  }

  exec { 'tar xzf xdebug-2.2.6.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/xdebug-2.2.6.tgz']
  }

  exec { 'phpize-5.6.1 xdebug':
    command => '/phpfarm/inst/bin/phpize-5.6.1',
    cwd => '/tmp/xdebug-2.2.6',
    require => Exec['tar xzf xdebug-2.2.6.tgz']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug-2.2.6 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1"':
    timeout => 0,
    require => Exec['phpize-5.6.1 xdebug']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug-2.2.6 && make"':
    timeout => 0,
    require => Exec['/bin/bash -l -c "cd /tmp/xdebug-2.2.6 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1"']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug-2.2.6 && make install"':
    timeout => 0,
    require => Exec['/bin/bash -l -c "cd /tmp/xdebug-2.2.6 && make"']
  }
}
