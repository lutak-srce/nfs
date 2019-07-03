#
# = Class: nfs::client::redhat::configure
#
class nfs::client::redhat::configure {

  if $nfs::client::redhat::nfs_v4 {
    augeas {
      '/etc/idmapd.conf':
        context => '/files/etc/idmapd.conf/General',
        lens    => 'Puppet.lns',
        incl    => '/etc/idmapd.conf',
        changes => ["set Domain ${nfs::client::redhat::nfs_v4_idmap_domain}"],
    }
  }

}
