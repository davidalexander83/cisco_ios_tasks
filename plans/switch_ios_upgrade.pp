plan cisco_ios_tasks::switch_ios_upgrade(
  TargetSpec $ciscotarget,
  TargetSpec $arubatarget,
  String $tftpserver,
  String $backup_name,
  String $image_file,
){
  run_task('cisco_ios::cli_command', $ciscotarget, command => "copy startup-config tftp://${tftpserver}/${backup_name}", raw => true)
  notice('Startup-config copied to TFTP')
  run_task('cisco_ios::cli_command', $ciscotarget, command => "delete bootflash:${image_file}\r", raw => true)
  notice('Removed current bootflash')
  run_task('cisco_ios::cli_command', $ciscotarget, command => "copy tftp://${tftpserver}/${image_file} bootflash:", raw => true)
  notice('Retrieved new IOS image successfully')
  run_task('cisco_ios::cli_command', $ciscotarget, command => 'copy running-config startup-config\r', raw => true)
  notice('Saved current running-config to startup-config')
  run_task('cisco_ios::cli_command', $ciscotarget, command => 'reload\r', raw => true)
  notice('Reloaded switch')
  run_task('aruba::get_access_points', $arubatarget)
}
