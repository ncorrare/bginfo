class bginfo::params {
  $bgifile = hiera('bgifile','puppet:///modules/bginfo/default.bgi')
  $bgipath = hiera('bgipath','c:/default.bgi')
}
  
