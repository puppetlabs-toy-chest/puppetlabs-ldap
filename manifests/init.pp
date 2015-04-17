# == Class: ldap
#
# Puppet module to manage client for LDAP
#
#
# === Parameters
#
#  [uri]
#    Ldap URI as a string. Multiple values can be set
#    separated by spaces ('ldap://ldapmaster ldap://ldapslave')
#    **Required**
#
#  [base]
#    Ldap base dn.
#    **Required**
#
#  [version]
#    Ldap version for the connecting client
#    *Optional* (defaults to 3)
#
#  [timelimit]
#    Time limit in seconds to use when performing searches
#    *Optional* (defaults to 30)
#
#  [bind_timelimit]
#    *Optional* (defaults to 30)
#
#  [idle_timelimit]
#    *Optional* (defaults to 30)
#
#  [binddn]
#    Default bind dn to use when performing ldap operations
#    *Optional* (defaults to false)
#
#  [bindpw]
#    Password for default bind dn
#    *Optional* (defaults to false)
#
#  [ssl]
#    Enable TLS/SSL negotiation with the server
#    *Requires*: ssl_cert parameter
#    *Optional* (defaults to false)
#
#  [nsswitch]
#    If enabled (nsswitch => true) enables nsswitch to use
#    ldap as a backend for password, group and shadow databases.
#    *Requires*: https://github.com/torian/puppet-nsswitch.git (in alpha)
#    *Optional* (defaults to false)
#
#  [nss_passwd]
#    Search base for the passwd database. *base* will be appended.
#    *Optional* (defaults to false)
#
#  [nss_group]
#    Search base for the group database. *base* will be appended.
#    *Optional* (defaults to false)
#
#  [nss_shadow]
#    Search base for the shadow database. *base* will be appended.
#    *Optional* (defaults to false)
#
#  [ensure]
#    *Optional* (defaults to 'present')
#
#  [nslcd]
#    If you are going to use nslcd. (defaults to false)

#  [sssd]
#    If you are going to use sssd. (defaults to false)
#
# === Examples
#
# class { 'ldap':
#	uri  => 'ldap://ldapserver00 ldap://ldapserver01',
#	base => 'dc=suffix',
# }
#
# class { 'ldap':
#	uri  => 'ldap://ldapserver00',
#	base => 'dc=suffix',
#	ssl  => true,
#	ssl_cert => 'ldapserver00.pem'
# }
#
class ldap(
  $uri,
  $base,
  $version        = '3',
  $timelimit      = 30,
  $bind_timelimit = 30,
  $idle_timelimit = 60,
  $binddn         = false,
  $bindpw         = false,
  $ssl            = false,
  $ssl_reqcert    = 'never',
  $nsswitch       = false,
  $nss_passwd     = false,
  $nss_group      = false,
  $nss_shadow     = false,
  $pam_filter     = false,
) {

  include ldap::params

  package { $ldap::params::package: ensure => $ensure, }

  File {
    ensure  => $ensure,
    mode    => '0644',
    owner   => $ldap::params::owner,
    group   => $ldap::params::group,
  }

  file { $ldap::params::prefix:
    ensure  => directory,
    require => Package[$ldap::params::package],
  }

  file { "${ldap::params::prefix}/${ldap::params::config}": content => template('ldap/ldap.conf.erb'), }
}
