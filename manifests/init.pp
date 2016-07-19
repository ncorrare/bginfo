class bginfo (
  String $conffile = $bginfo::params::conffile,
  String $confpath = $bginfo::params::confpath,
  Boolean $setonstart = true,
) inherits bginfo::params {
  validate_re($confpath, '^[a-zA-Z]:\\(((?![<>:"\/\\|?*]).)+((?<![ .])\\)?)*.bgi$', 'Confpath should be an absolute Windows Path to a bgi file')

  require chocolatey
  
  package { 'bginfo':
    ensure   => installed,
    provider => 'chocolatey',
  }
  
  file { $confpath:
    ensure  => file,
    source  => $conffile,
    require => Package['bginfo'], 
  }
  if $setonstart {
    file { 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp':
      ensure  => file,
      content => template('bginfo/bginfo.bat', { 'confpath' => $confpath }),
    }
  }
}
