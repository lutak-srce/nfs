#
# = Class: nfs::client::redhat::install
#
class nfs::client::redhat::install {

  Package {
    before => Class['nfs::client::redhat::configure']
  }
  package { 'nfs-utils':
    ensure => present,
  }

  if $nfs::client::redhat::osmajor == 6 {
    package {'rpcbind':
      ensure => present,
    }
  }
  elsif $nfs::client::redhat::osmajor == 5 {
    package { 'portmap':
      ensure => present,
    }
  }

}
