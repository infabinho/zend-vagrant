class app::tools {
    package {['build-essential',
              'git',
              'mlocate',
              'patch',
              'strace',
              'unzip',
              'vim',
              'zip']:
        ensure => present,
    }

    exec {'find-utils-updatedb':
        command => '/usr/bin/updatedb &',
        require => Package['mlocate'],
    }
}