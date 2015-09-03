class run::drush {
  require run::user

  if $drupal_version == '7' {
    file { '/usr/local/bin/drush':
      ensure => link,
      target => '/usr/local/src/drush7/drush'
    }

    file { '/etc/bash_completion.d/drush.complete.sh':
      ensure => link,
      target => '/usr/local/src/drush7/drush.complete.sh'
    }

    bash_exec { "chown -R -h $user_id /usr/local/src/drush7": }
    bash_exec { "chgrp -R -h $group_id /usr/local/src/drush7": }
  }
  elsif $drupal_version == '8' {
    file { '/usr/local/bin/drush':
      ensure => link,
      target => '/usr/local/src/drush8/drush'
    }

    file { '/etc/bash_completion.d/drush.complete.sh':
      ensure => link,
      target => '/usr/local/src/drush7/drush.complete.sh'
    }

    bash_exec { "chown -R -h $user_id /usr/local/src/drush8": }
    bash_exec { "chgrp -R -h $group_id /usr/local/src/drush8": }
  }
}
