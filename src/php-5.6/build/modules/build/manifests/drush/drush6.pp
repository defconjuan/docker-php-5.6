class build::drush::drush6 {
  require build::user
  require build::php56
  require build::php56::extensions
  require build::composer
  require build::drush::packages

  file { '/tmp/drush-6.6.0.tar.gz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/drush-6.6.0.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf drush-6.6.0.tar.gz':
    require => File['/tmp/drush-6.6.0.tar.gz']
  }

  bash_exec { 'mv /tmp/drush-6.6.0 /usr/local/src/drush6':
    require => Bash_exec['cd /tmp && tar xzf drush-6.6.0.tar.gz']
  }

  bash_exec { 'cd /usr/local/src/drush6 && composer install':
    timeout => 0,
    require => Bash_exec['mv /tmp/drush-6.6.0 /usr/local/src/drush6']
  }
}
