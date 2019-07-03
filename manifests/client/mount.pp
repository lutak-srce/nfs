#
# = Class: nfs::client::mount
#

define nfs::client::mount (
  $ensure = 'mounted',
  $server = undef,
  $share = undef,
  $mount = undef,
  $remounts = false,
  $atboot = false,
  $options = '_netdev',
  $bindmount = undef,
  $tag = undef
) {

  include nfs::client


  if $nfs::client::nfs_v4 == true {

    if $mount == undef {
      $_nfs4_mount = "${nfs::client::nfs_v4_mount_root}/${share}"
    } else {
      $_nfs4_mount = $mount
    }

    nfs::mkdir{$_nfs4_mount: }

    mount {"shared ${share} by ${::clientcert} on ${_nfs4_mount}":
      ensure   => $ensure,
      device   => "${server}:/${share}",
      fstype   => 'nfs4',
      name     => $_nfs4_mount,
      options  => $options,
      remounts => $remounts,
      atboot   => $atboot,
      require  => Nfs::Mkdir[$_nfs4_mount],
    }

    if $bindmount != undef {
      nfs::client::mount::nfs_v4::bindmount { $_nfs4_mount:
        ensure     => $ensure,
        mount_name => $bindmount,
      }

    }

  } else {

    if $mount == undef {
      $_mount = $share
    } else {
      $_mount = $mount
    }

    nfs::mkdir{$_mount: }

    mount {"shared ${share} by ${::clientcert}":
      ensure   => $ensure,
      device   => "${server}:${share}",
      fstype   => 'nfs',
      name     => $_mount,
      options  => $options,
      remounts => $remounts,
      atboot   => $atboot,
      require  => Nfs::Mkdir[$_mount],
    }


  }

}
