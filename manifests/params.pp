class ldap::params {

  case $osfamily {
    'Debian': {
      $package       = 'ldap-utils'
      $prefix        = '/etc/ldap'
      $owner         = 'root'
      $group         = 'root'
      $config        = 'ldap.conf'
      $nslcd_conf    = '/etc/nslcd.conf'
      $nslcd_package = ['nslcd', 'libnss-ldapd']
      $nslcd_service = 'nslcd'
      $sssd_conf     = '/etc/sssd/sssd.conf'
      $sssd_package  = ['sssd', 'libnss-sss']
      $sssd_service  = 'sssd'
    }
    default:  {
      fail("Operating system ${::operatingsystem} not supported")
    }
  }
}
