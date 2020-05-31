class ntp (
  # temporarilyprovide default values for optional parameter types too
  # to get a clean rspec results ASAP
  # NOTE : type definition is binding to dependencies
  Optional[Stdlib::Absolutepath] $keys_file = undef,
  # NOTE : custom resource type definition is binding to module file structure
  Optional[Ntp::Key_id] $keys_controlkey = undef,
  String $package_name  = undef,
  Optional[String] $user = undef,
  # common parameters accessed from refactored subclasses
  Variant[Boolean, Integer[0,1]] $package_manage = false,
  Variant[Boolean, Integer[0,1]] $service_manage = false,
  Stdlib::Absolutepath $config,
  Optional[Stdlib::Absolutepath] $config_dir,
  String $config_file_mode,
) {
  if $facts['is_virtual'] {
    $test = true
  } else {
    $test = true
  }

  contain ntp::install
  contain ntp::config
  contain ntp::service

  Class['::ntp::install'] -> Class['::ntp::config']
  Class['::ntp::install'] ~> Class['::ntp::service']
}
