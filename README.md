# awscli_bundled

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This module installs a bundled version of [awscli](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
Bundled version means it depends on your local system python only during installation
which is much safer in the long run.

## Usage

Just add `require awscli_bundled` to a manifest where you need to use awscli.
Or, if we need more customization, declare a class with parameters as shown:

```puppet
class { 'awscli_bundled':
  awscli_install_dir    = '/usr/local/aws',
  awscli_source_dir     = 'http://your.company.com/custom-awscli-bundle.zip',
  awscli_binary_symlink = undef,
  wget_temp_dir         = '/var/tmp/puppet_wget'
}
```

If you set `awscli_binary_symlink` to `undef` that will skip creating a symlink in /usr/local/bin.
Do it if you would like to manage your PATH variable independently.

## Limitations

This module was tested on CentOS 6.x so far.
