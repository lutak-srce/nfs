#
# = Class: nfs::server::redhat::service 
#
class nfs::server::redhat::service {

  if $nfs::server::redhat::nfs_v4 == true {
    case $facts['os']['release']['major'] {
      '7' : {
        service {'nfs-server':
          ensure     => running,
          enable     => true,
          hasrestart => true,
          hasstatus  => true,
          require    => Package['nfs-utils'],
          subscribe  => [ Concat['/etc/exports'], Augeas['/etc/idmapd.conf'] ],
        }
      }
      default : {
        service {'nfs':
          ensure     => running,
          enable     => true,
          hasrestart => true,
          hasstatus  => true,
          require    => Package['nfs-utils'],
          subscribe  => [ Concat['/etc/exports'], Augeas['/etc/idmapd.conf'] ],
        }
      }
    }
  }
  else {
    case $facts['os']['release']['major'] {
      '7': {
        service {'nfs-server':
          ensure     => running,
          enable     => true,
          hasrestart => true,
          hasstatus  => true,
          require    => Package['nfs-utils'],
          subscribe  => Concat['/etc/exports'],
        }
      }
      default : {
        service {'nfs':
          ensure     => running,
          enable     => true,
          hasrestart => true,
          hasstatus  => true,
          require    => Package['nfs-utils'],
          subscribe  => Concat['/etc/exports'],
        }
      }
    }
  }

}
