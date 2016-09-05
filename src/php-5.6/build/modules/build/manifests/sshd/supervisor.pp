class build::sshd::supervisor {
  file { '/etc/supervisor/conf.d/sshd.conf':
    ensure => present,
    source => 'puppet:///modules/build/etc/supervisor/conf.d/sshd.conf',
    mode => 644
  }
}
