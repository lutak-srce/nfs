#
# = Class: nfs::client::redhat
#
class nfs::client::redhat (
  $nfs_v4 = false,
  $nfs_v4_idmap_domain = undef
) inherits nfs::client::redhat::params {

  include nfs::client::redhat::install,
    nfs::client::redhat::configure,
    nfs::client::redhat::service
}
