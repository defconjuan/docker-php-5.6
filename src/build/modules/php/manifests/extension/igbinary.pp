class php::extension::igbinary {
  require php

  file { '/tmp/igbinary-1.2.1.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/igbinary-1.2.1.tgz'
  }

  bash_exec { 'cd /tmp && tar xzf igbinary-1.2.1.tgz':
    require => File['/tmp/igbinary-1.2.1.tgz']
  }

  bash_exec { 'cd /tmp/igbinary-1.2.1 && phpize-5.6.1':
    require => Bash_exec['cd /tmp && tar xzf igbinary-1.2.1.tgz']
  }

  bash_exec { 'cd /tmp/igbinary-1.2.1 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1 --enable-igbinary':
    timeout => 0,
    require => Bash_exec['cd /tmp/igbinary-1.2.1 && phpize-5.6.1']
  }

  bash_exec { 'cd /tmp/igbinary-1.2.1 && make':
    timeout => 0,
    require => Bash_exec['cd /tmp/igbinary-1.2.1 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1 --enable-igbinary']
  }

  bash_exec { 'cd /tmp/igbinary-1.2.1 && make install':
    timeout => 0,
    require => Bash_exec['cd /tmp/igbinary-1.2.1 && make']
  }
}
