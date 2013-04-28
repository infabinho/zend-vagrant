class app::zend {

    exec {"create-project":
        require => Package["php5-cli"],
        command => "/bin/bash -c 'cd /srv/www/vhosts && ./$vhost.dev/vendor/zendframework/zendframework1/bin/zf.sh create project $vhost.dev'",
    }

}
