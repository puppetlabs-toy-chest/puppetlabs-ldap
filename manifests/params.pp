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
      $cacert        = '/etc/ssl/certs/ldapcabundle.pem'
    }
    'FreeBSD': {
      $package       = 'openldap-client'
      $prefix        = '/usr/local/etc/openldap'
      $owner         = 'root'
      $group         = '0'
      $config        = 'ldap.conf'
      $nslcd_conf    = '/usr/local/etc/nslcd.conf'
      $nslcd_package = 'nss-pam-ldapd'
      $nslcd_service = 'nslcd'
      $sssd_conf     = '/usr/local/etc/sssd/sssd.conf'
      $sssd_package  = 'sssd'
      $sssd_service  = 'sssd'
      $cacert        = '/etc/ssl/certs/ldapcabundle.pem'
    }
    default:  {
      fail("Operating system ${::operatingsystem} not supported")
    }
  }
}
