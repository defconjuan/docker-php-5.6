class run::sshd {
  file { '/etc/supervisor/conf.d/sshd.conf':
    ensure => present,
    content => template('run/sshd.conf.erb'),
    mode => 644
  }
}
