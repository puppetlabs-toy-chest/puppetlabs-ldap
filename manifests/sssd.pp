class ldap::sssd (
  $uri,
  $base,
  $ensure      = 'present',
  $schema      = 'rfc2307bis', # Use 'member' attribute on group
  $binddn      = undef,
  $bindpw      = undef,
  $filter      = undef,
  $tls_cacert  = undef,
  $tls_reqcert = undef,
) {

  validate_re($ensure, ['present', 'absent'])
  validate_re($schema, ['rfc2307', 'rfc2307bis'])

  include ldap::params

  $package = $ldap::params::sssd_package
  $service = $ldap::params::sssd_service
  $conf    = $ldap::params::sssd_conf #sssd.conf

  if $ensure == 'present' {
    if $package {
      package { $package:
        ensure => present,
        before => File[$conf],
        notify => Service[$service]
      }
    }

    file { $conf:
      content => template('ldap/sssd.conf.erb'),
      mode    => '0600',
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
