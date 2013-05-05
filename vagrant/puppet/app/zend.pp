class app::zend {

    exec {"create-project":
        require => Class["php::install", "php::config"],
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

    file {["/srv/www/vhosts/$vhost.dev/data/cache",
            "/srv/www/vhosts/$vhost.dev/data/cache/db",
            "/srv/www/vhosts/$vhost.dev/data/cache/acl",
            "/srv/www/vhosts/$vhost.dev/data/cache/default"]:
        ensure  => directory,
        recurse => true,
        require => Package["nginx"],
    }

}
