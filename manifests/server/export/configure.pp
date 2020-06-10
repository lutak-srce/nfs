define nfs::server::export::configure (
  $ensure = 'present',
  $clients
) {

  if $ensure != 'absent' {
    $share = $name
    # $line = "${name} ${clients}\n"

    concat::fragment { $name:
      target  => '/etc/exports',
      content => template('nfs/exports_line.erb'),
      # content => "${line}"
    }
  }
}
