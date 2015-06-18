class php::extension::xdebug {
  require php

  file { '/tmp/xdebug-2.2.6.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/xdebug-2.2.6.tgz'
  }

  bash_exec { 'cd /tmp && tar xzf xdebug-2.2.6.tgz':
    require => File['/tmp/xdebug-2.2.6.tgz']
  }

  bash_exec { 'cd /tmp/xdebug-2.2.6 && phpize-5.6.10':
    require => Bash_exec['cd /tmp && tar xzf xdebug-2.2.6.tgz']
  }

  bash_exec { 'cd /tmp/xdebug-2.2.6 && ./configure --with-php-config=/usr/local/src/phpfarm/inst/bin/php-config-5.6.10':
    timeout => 0,
    require => Bash_exec['cd /tmp/xdebug-2.2.6 && phpize-5.6.10']
  }

  bash_exec { 'cd /tmp/xdebug-2.2.6 && make':
    timeout => 0,
    require => Bash_exec['cd /tmp/xdebug-2.2.6 && ./configure --with-php-config=/usr/local/src/phpfarm/inst/bin/php-config-5.6.10']
  }

  bash_exec { 'cd /tmp/xdebug-2.2.6 && make install':
    timeout => 0,
    require => Bash_exec['cd /tmp/xdebug-2.2.6 && make']
  }
}
