puppet-memcached
================

A puppet module to install and configure memcached on a node.

It defaults to the usual memcached configuration settings but they can all be changed
by passing the parameters to the class:

class { 'memcached':
    $memcached_port = '11211'
    $maxconn = '1024',
    $cachesize = '64',
    $user = 'nobody',
    $listen_address = '127.0.0.1',
    $logfile = '/var/log/memcached.log',
    $extra = '',
}
