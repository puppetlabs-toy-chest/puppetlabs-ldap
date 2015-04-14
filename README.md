# puppetlabs-ldap

### System Security Services Daemon (sssd)

The [sssd][sssd] daemon provides NSS and PAM modules for retrieving and
authenticating identities.  It is a more modern approach for the historcal
`nscd`/`nslcd` daemons.

Using `sssd` with this module is easy.

```Puppet
class { 'ldap':
  sssd => true,
}
```


[sssd]: https://fedorahosted.org/sssd/
