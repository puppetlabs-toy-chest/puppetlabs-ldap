class ldap::params {

  case $osfamily {
    'Debian': {
      $package       = 'ldap-utils'
      $prefix        = '/etc/ldap'
      $owner         = 'root'
      $group         = 'root'
      $config        = 'ldap.conf'
      $nslcd_package = ['nslcd', 'libnss-ldap']
      $cacertdir     = '/etc/ssl/certs'

    }
    default:  {
      fail("Operating system ${::operatingsystem} not supported")
    }
  }
}

