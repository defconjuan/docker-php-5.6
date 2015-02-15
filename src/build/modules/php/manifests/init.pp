define bash_exec (
  $command = $name,
  $user = 'root',
  $creates = undef,
  $cwd = undef,
  $environment = undef,
  $group = undef,
  $logoutput = undef,
  $onlyif = undef,
  $path = undef,
  $provider = "posix",
  $refresh = undef,
  $refreshonly = undef,
  $returns = undef,
  $timeout = undef,
  $tries = undef,
  $try_sleep = undef,
  $umask = undef,
  $unless = undef
) {
  $escaped_command = regsubst($command, "\"", "\\\"", 'G')

  if $unless == undef {
    $escaped_unless = undef
  } else {
    $unless_with_escaped_quotes = regsubst($unless, "\"", "\\\"", 'G')
    $escaped_unless = "/bin/su -l ${user} -c \"/bin/bash --login -c \\\"${unless_with_escaped_quotes}\\\"\""
  }

  if $onlyif == undef {
    $escaped_onlyif = undef
  } else {
    $onlyif_with_escaped_quotes = regsubst($onlyif, "\"", "\\\"", 'G')
    $escaped_onlyif = "/bin/su -l ${user} -c \"/bin/bash --login -c \\\"${onlyif_with_escaped_quotes}\\\"\""
  }

  exec { $name:
    command => "/bin/su -l ${user} -c \"/bin/bash --login -c \\\"${escaped_command}\\\"\"",
    creates => $creates,
    cwd => $cwd,
    environment => $environment,
    group => $group,
    logoutput => $logoutput,
    onlyif => $escaped_onlyif,
    path => $path,
    provider => $provider,
    refresh => $refresh,
    refreshonly => $refreshonly,
    returns => $returns,
    timeout => $timeout,
    tries => $tries,
    try_sleep => $try_sleep,
    umask => $umask,
    unless => $escaped_unless
  }
}

class php {
  require php::packages
  require php::phpfarm
  require php::supervisor

  bash_exec { 'mkdir -p /phpfarm/inst/php-5.6.1/etc/conf.d': }

  bash_exec { 'mkdir -p /phpfarm/inst/php-5.6.1/lib/php/extensions/no-debug-non-zts-20131226': }

  file { '/tmp/php-5.6.1.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/php-5.6.1.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf php-5.6.1.tar.gz':
    require => File['/tmp/php-5.6.1.tar.gz']
  }

  bash_exec { 'mv /tmp/php-5.6.1 /phpfarm/src/php-5.6.1':
    require => Bash_exec['cd /tmp && tar xzf php-5.6.1.tar.gz']
  }

  file { '/phpfarm/src/custom/options-5.6.1.sh':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/custom/options-5.6.1.sh',
    mode => 755,
    require => Bash_exec['mv /tmp/php-5.6.1 /phpfarm/src/php-5.6.1']
  }

  bash_exec { '/phpfarm/src/main.sh 5.6.1':
    timeout => 0,
    require => File['/phpfarm/src/custom/options-5.6.1.sh']
  }

  bash_exec { 'rm -rf /phpfarm/src/php-5.6.1':
    require => Bash_exec['/phpfarm/src/main.sh 5.6.1']
  }

  file { '/phpfarm/inst/php-5.6.1/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.6.1/etc/php-fpm.conf',
    mode => 644,
    require => Bash_exec['/phpfarm/src/main.sh 5.6.1']
  }

  bash_exec { 'switch-phpfarm 5.6.1':
    require => Bash_exec['/phpfarm/src/main.sh 5.6.1']
  }
}
