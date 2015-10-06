class awscli_bundled (
  $awscli_install_dir    = $awscli_bundled::params::awscli_install_dir,
  $awscli_source_url     = $awscli_bundled::params::awscli_source_url,
  $awscli_binary_symlink = $awscli_bundled::params::awscli_binary_symlink,
  $wget_temp_dir         = $awscli_bundled::params::wget_temp_dir
) inherits awscli_bundled::params {

  $awscli_archive = inline_template('<%= File.basename @awscli_source_url %>')

  $binary_symlink = $awscli_binary_symlink ? {
    undef   => '',
    default => "-b ${awscli_binary_symlink}"
  }

  Exec {
    path => '/bin:/usr/bin'
  }

  if ! defined(Package['unzip']) {
    package { 'unzip':
      ensure => present
    }
  }

  if ! defined(File[$wget_temp_dir]) {
    file { $wget_temp_dir:
      ensure => directory
    }
  }

  file { $awscli_install_dir:
    ensure  => directory
  } ->

  wget::fetch { 'download awscli bundle':
    source      => $awscli_source_url,
    destination => "${wget_temp_dir}/${awscli_archive}",
    require     => File[$wget_temp_dir]
  } ->

  exec { 'unzip awscli bundle':
    cwd     => $wget_temp_dir,
    command => "unzip ${wget_temp_dir}/${awscli_archive}",
    creates => "${wget_temp_dir}/awscli-bundle/install",
    require => Package['unzip']
  } ->

  exec { 'install awscli':
    cwd     => "${wget_temp_dir}/awscli-bundle",
    command => "./install -i ${awscli_install_dir} ${binary_symlink}",
    creates => "${awscli_install_dir}/bin/aws"
  }

}
