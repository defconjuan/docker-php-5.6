class php::extension::memcached {
  require php
  require php::extension::igbinary

  file { '/tmp/libmemcached-1.0.18.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/libmemcached-1.0.18.tar.gz'
  }

  exec { 'tar xzf libmemcached-1.0.18.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/libmemcached-1.0.18.tar.gz']
  }

  exec { '/bin/su - root -c "cd /tmp/libmemcached-1.0.18 && ./configure"':
    timeout => 0,
    require => Exec['tar xzf libmemcached-1.0.18.tar.gz']
  }

  exec { '/bin/su - root -c "cd /tmp/libmemcached-1.0.18 && make"':
    timeout => 0,
    require => Exec['/bin/su - root -c "cd /tmp/libmemcached-1.0.18 && ./configure"']
  }

  exec { '/bin/su - root -c "cd /tmp/libmemcached-1.0.18 && make install"':
    timeout => 0,
    require => Exec['/bin/su - root -c "cd /tmp/libmemcached-1.0.18 && make"']
  }

  file { '/tmp/memcached-2.2.0.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/memcached-2.2.0.tgz',
    require => Exec['/bin/su - root -c "cd /tmp/libmemcached-1.0.18 && make install"']
  }

  exec { 'tar xzf memcached-2.2.0.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/memcached-2.2.0.tgz']
  }

  exec { 'phpize-5.6.1 memcached':
    command => '/phpfarm/inst/bin/phpize-5.6.1',
    cwd => '/tmp/memcached-2.2.0',
    require => Exec['tar xzf memcached-2.2.0.tgz']
  }

  exec { '/bin/su - root -c "cd /tmp/memcached-2.2.0 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1 --enable-memcached-igbinary"':
    timeout => 0,
    require => Exec['phpize-5.6.1 memcached']
  }

  exec { '/bin/su - root -c "cd /tmp/memcached-2.2.0 && make"':
    timeout => 0,
    require => Exec['/bin/su - root -c "cd /tmp/memcached-2.2.0 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1 --enable-memcached-igbinary"']
  }

  exec { '/bin/su - root -c "cd /tmp/memcached-2.2.0 && make install"':
    timeout => 0,
    require => Exec['/bin/su - root -c "cd /tmp/memcached-2.2.0 && make"']
  }
}
