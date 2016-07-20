class bginfo (
  String $bgifile         = $bginfo::params::bgifile,
  String $bgipath         = $bginfo::params::bgipath,
  Boolean $setonstart     = true,
  Boolean $addtrustedsite = true,
) inherits bginfo::params {
  #validate_re($bgipath, '^[a-zA-Z]:\\(((?![<>:"\/\\|?*]).)+((?<![ .])\\)?)*.bgi$', 'Confpath should be an absolute Windows Path to a bgi file')

  #Chocolatey will use the underlying libraries of the OS to download packages. So if ESC is enabled, download.sysinternals.com needs to be in that list.
  if $addtrustedsite {
    registry_key { 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\ESCDomains\sysinternals.com':
      ensure => present,
    }
    registry_key { 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\ESCDomains\sysinternals.com\download':
      ensure => present,
    }
    registry_value { 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\ESCDomains\sysinternals.com\download\https':
      ensure => present,
      type   => dword,
      data   => '0x00000002',
      before => Package['bginfo'],
    }
  }
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
    file { 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\bginfo.bat':
      ensure  => file,
      content => template('bginfo/bginfo.bat.erb'),
    }
  }
}
