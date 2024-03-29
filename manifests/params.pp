class nfs::params (
  $nfs_v4 = false,
  $nfs_v4_export_root = '/export',
  $nfs_v4_export_root_clients  = "*.${::domain}(ro,fsid=root,insecure,no_subtree_check,async,root_squash)",
  $nfs_v4_mount_root  = '/srv',
  $nfs_v4_idmap_domain = $::domain
) {

  # Somehow the ::osfamily fact doesnt exist on some oled systems

  case $::operatingsystem {
    'centos', 'redhat', 'scientific', 'fedora', 'rocky': {
      $osfamily = 'redhat'
    } 'debian', 'Ubuntu': {
      $osfamily = 'debian'
    } 'windows': {
      fail('fail!11')
    } default: {
      fail("OS: ${::operatingsystem} not supported")
    }
  }
}
