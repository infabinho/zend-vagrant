class app::database {

    mysql::db { $vhost:
      user     => $vhost,
      password => $vhost,
      grant    => ['all'],
    }

}
