#
# = Class: nfs::client::redhat::params
#
class nfs::client::redhat::params {

  if versioncmp($::operatingsystemrelease, '6.0') > 0 {
    $osmajor = 6
  }
  elsif versioncmp($::operatingsystemrelease, '5.0') > 0 {
    $osmajor = 5
  }

}
