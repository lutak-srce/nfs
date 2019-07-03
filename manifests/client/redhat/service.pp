#
# = Class: nfs::client::redhat::service
#
class nfs::client::redhat::service {

  Service {
    require => Class['nfs::client::redhat::configure']
  }

  if $facts['os']['release']['major'] == '7' {
    $requires = $nfs::client::redhat::osmajor ? {
      6 => Service['rpcbind'],
      5 => [Package['portmap'], Package['nfs-utils']]
    }
    service {'nfslock':
      ensure    => running,
      enable    => true,
      provider  => redhat,
      hasstatus => true,
      require   => $requires
    }
  }
  else {
    $requires = $nfs::client::redhat::osmajor ? {
      6 => Service['rpcbind'],
      5 => [Package['portmap'], Package['nfs-utils']]
    }
    service {'nfslock':
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => $requires,
    }
  }

  if $facts['os']['release']['major'] != '7' {
    $requires = $nfs::client::redhat::osmajor ? {
      6 => Service['nfslock'],
      5 => [Service['portmap'], Service['nfslock']],
    }
    service { 'netfs':
      enable  => true,
      require => $requires,
    }
  }

  if $facts['os']['release']['major'] == '7' {
      service {'rpcbind':
        ensure    => running,
        provider  => redhat,
        enable    => true,
        hasstatus => true,
        require   => [Package['rpcbind'], Package['nfs-utils']],
      }
  }
  else {
    if $nfs::client::redhat::osmajor == 6 {
      service {'rpcbind':
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => [Package['rpcbind'], Package['nfs-utils']],
      }
    }
    elsif $nfs::client::redhat::osmajor == 5 {
      service { 'portmap':
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => [Package['portmap'], Package['nfs-utils']],
      }
    }
  }

}
