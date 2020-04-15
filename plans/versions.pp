plan cisco_ios_tasks::versions(
  TargetSpec $ciscodevice,
  TargetSpec $server
){
  $cisco = run_task('cisco_ios::cli_command', $ciscodevice, command => 'sh ver', raw => false)
  $server = run_task('service', $server, action => 'status', name => 'firewalld')
  return $cisco + $server
}
