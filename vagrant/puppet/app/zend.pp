class app::zend {

    exec {"create-project":
        require => Package["php5-cli"],
        command => "/bin/bash -c 'cd /srv/www/vhosts && ./$vhost.dev/vendor/zendframework/zendframework1/bin/zf.sh create project $vhost.dev'",
    }

    exec {"enable-form":
        require => Exec["create-project"],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost.dev && ./vendor/zendframework/zendframework1/bin/zf.sh enable form'",
    }

    exec {"enable-layout":
        require => Exec["create-project"],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost.dev && ./vendor/zendframework/zendframework1/bin/zf.sh enable layout'",
    }

}
