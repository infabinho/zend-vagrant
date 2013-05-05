class app::php {

  include php

  package { ['libgv-php5', 'graphviz']:
    ensure  => present,
    require => Exec['apt_update'],
  }

  php::module { [
    'curl', 'gd', 'mcrypt', 'memcached', 'mysql',
    'intl', 'imap', 'imagick', 'xdebug', 'xsl', 'geoip'
    ]:
    require => Class["php::install", "php::config"],
    notify  => Service[$webserverService]
  }

  php::conf { [ 'pdo', 'pdo_mysql', 'mysqli', 'pcntl']:
    source => "/vagrant/files/etc/php5/fpm/conf.d/",
    notify  => [Service[$webserverService], Class['php::fpm::service']],
    require => [File["/usr/lib/php5/20090626/pcntl.so"],]
  }

  exec { 'install_composer':
    command => 'curl -s https://getcomposer.org/installer | php -- --install-dir="/bin"',
    require => [ Package['curl'], Class["php::install", "php::config"] ],
    unless  => 'which composer.phar',
  }

  file {"/usr/lib/php5/20090626/pcntl.so":
    owner   => root,
    group   => root,
    source  => "/vagrant/files/usr/lib/php5/ext/pcntl.so",
    require => [Package['php5-cli'], Class["php::install", "php::config"]],
    notify  => [Service[$webserverService], Class['php::fpm::service']],
  }

  include app::zend

  if 'nginx' == $webserver {
    php::fpm::pool { $vhost :
      listen       => "/run/shm/${vhost}.phpfpm.socket",
      pm           => 'static',
      php_settings => [
        'php_value[memory_limit] = 600M',
        'php_value[post_max_size] = 600M',
        'php_value[upload_max_filesize] = 600M',
        'php_value[max_file_uploads] = 300',
        'php_flag[magic_quotes_gpc] = off',
      ]
    }
  }
}