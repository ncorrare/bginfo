class bginfo (
  String $bgifile = $bginfo::params::bgifile,
  String $bgipath = $bginfo::params::bgipath,
  Boolean $setonstart = true,
) inherits bginfo::params {
  #validate_re($bgipath, '^[a-zA-Z]:\\(((?![<>:"\/\\|?*]).)+((?<![ .])\\)?)*.bgi$', 'Confpath should be an absolute Windows Path to a bgi file')

  require chocolatey
  
  package { 'bginfo':
    ensure   => installed,
    provider => 'chocolatey',
  }
  
  file { $bgipath:
    ensure  => file,
    source  => $bgifile,
    require => Package['bginfo'], 
  }
  if $setonstart {
    file { 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp':
      ensure  => file,
      content => template('bginfo/bginfo.bat.erb'),
    }
  }
}
