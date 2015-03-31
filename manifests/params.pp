class ldap::params {

  case $osfamily {
    'Debian': {
      $package       = 'ldap-utils'
      $prefix        = '/etc/ldap'
      $owner         = 'root'
      $group         = 'root'
      $config        = 'ldap.conf'
      $nslcd_package = ['nslcd', 'libnss-ldap']
      $cacert        = '/etc/ssl/certs/ldapcabundle.pem'

    }
    default:  {
      fail("Operating system ${::operatingsystem} not supported")
    }
  }
}

