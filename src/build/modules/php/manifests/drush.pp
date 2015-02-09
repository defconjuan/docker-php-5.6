class php::drush {
  require php
  require php::extensions
  require php::composer
  require php::drush::packages

  exec { 'mkdir /root/.drush':
    path => ['/bin']
  }

  file { '/tmp/drush-6.5.0.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/drush-6.5.0.tar.gz'
  }

  exec { 'tar xzf drush-6.5.0.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/drush-6.5.0.tar.gz']
  }

  exec { 'mv drush-6.5.0 /opt/drush6':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['tar xzf drush-6.5.0.tar.gz']
  }

  exec { '/bin/su - root -c "cd /opt/drush6 && composer install"':
    timeout => 0,
    require => Exec['mv drush-6.5.0 /opt/drush6']
  }

  file { '/tmp/drush-7.0.0-alpha8.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/drush-7.0.0-alpha8.tar.gz'
  }

  exec { 'tar xzf drush-7.0.0-alpha8.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/drush-7.0.0-alpha8.tar.gz']
  }

  exec { 'mv drush-7.0.0-alpha8 /opt/drush7':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['tar xzf drush-7.0.0-alpha8.tar.gz']
  }

  exec { '/bin/su - root -c "cd /opt/drush7 && composer install"':
    timeout => 0,
    require => Exec['mv drush-7.0.0-alpha8 /opt/drush7']
  }
}
