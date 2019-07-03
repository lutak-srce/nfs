#
# = Class: nfs::client::mount::nfs_v4::bindmount
#

define nfs::client::mount::nfs_v4::bindmount (
  $ensure = 'present',
  $mount_name = undef,
  ) {

  nfs::mkdir{$mount_name: }

  mount {
    $mount_name:
      ensure  => $ensure,
      device  => $name,
      atboot  => true,
      fstype  => 'none',
      options => 'bind',
      require => Nfs::Mkdir[$mount_name],
  }

}
