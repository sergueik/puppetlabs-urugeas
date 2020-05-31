class ntp::config {

  case $ntp::config_dir {
    '/', '/etc', undef: {}
    default: {
      file { $ntp::config_dir:
        ensure  => directory,
        owner   => 0,
        group   => 0,
        mode    => '0775',
        recurse => false,
      }
    }
  }
  $config_content = 'xx'
  file { $ntp::config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => $::ntp::config_file_mode,
    content => $config_content,
  }
}
