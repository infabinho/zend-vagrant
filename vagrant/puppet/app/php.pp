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

  php::conf { [ 'pdo', 'pdo_mysql', 'mysqli']:
    source => "/vagrant/files/etc/php5/fpm/conf.d/",
    notify  => [Service[$webserverService], Class['php::fpm::service']],
  }

   exec { 'install_composer':
       command => 'curl -s https://getcomposer.org/installer | php -- --install-dir="/bin"',
       require => [ Package['curl'], Class["php::install", "php::config"] ],
       unless  => 'which composer.phar',
   }

#
#    class { 'pear': require => Class['php::install'] }
#    class { 'phpqatools': require => Class['pear'] }
#
#    pear::package { "PHPUnit_MockObject":
#        repository => "pear.phpunit.de",
#        require    => Pear::Package["PEAR"],
#    }
#
#    pear::package { "PHP_CodeCoverage":
#        repository => "pear.phpunit.de",
#        require    => Pear::Package["PEAR"],
#    }
#
#    pear::package { "PHPUnit_Selenium":
#        repository => "pear.phpunit.de",
#        require    => Pear::Package["PEAR"],
#    }
#
#    pear::package { "DocBlox":
#        version    => 'latest',
#        repository => "pear.docblox-project.org"
#    }

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
