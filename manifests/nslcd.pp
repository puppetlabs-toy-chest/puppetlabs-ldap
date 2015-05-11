class ldap::nslcd (
  $uri,
  $base,
  $ensure         = 'present',
  $binddn         = undef,
  $bindpw         = undef,
  $version        = '3',
  $timelimit      = 30,
  $bind_timelimit = 30,
  $idle_timelimit = 60,
  $ssl            = false,
  $tls_cacert     = undef,
  $tls_reqcert    = 'never',
) {

  validate_re($ensure, ['present', 'absent'])

  include ldap::params

  $package = $ldap::params::nslcd_package
  $service = $ldap::params::nslcd_service
  $conf    = $ldap::params::nslcd_conf #nslcd.conf

  if $ensure == 'present' {
    if $package {
      package { $package:
        ensure => present,
        before => File[$conf],
        notify => Service[$service]
      }
    }

    file { $conf:
      content => template('ldap/nslcd.conf.erb'),
      mode    => '0640',
    }

    service { $service:
      ensure  => running,
      require => File[$conf],
    }
  } elsif $ensure == 'absent' {
    if $package {
      package { $package:
        ensure => absent, }
    }

    file { $conf:
      ensure => absent,
    }
  }
}
