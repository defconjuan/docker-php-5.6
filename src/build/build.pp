node default {
  include php
  include php::extension::xdebug
  include php::extension::memcached
  include php::extension::redis
  include php::extension::apcu
  include php::drush
  include php::extension::blackfire
}
