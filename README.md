# puppetlabs-ldap

### System Security Services Daemon (sssd)

The [sssd][sssd] daemon provides NSS and PAM modules for retrieving and
authenticating identities.  It is a more modern approach for the historical
`nscd`/`nslcd` daemons.

Using `sssd` with this module is pretty simple.

```Puppet

$uri  = 'ldaps://myldap.example.com'
$base = 'dc=example,dc=com'

class { 'ldap':
  uri  => $uri,
  base => $base,
}

class { 'ldap::sssd':
  uri  => $uri,
  base => $base,
}
```


[sssd]: https://fedorahosted.org/sssd/
