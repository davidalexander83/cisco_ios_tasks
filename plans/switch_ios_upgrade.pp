plan cisco_ios_tasks::switch_ios_upgrade(
  String $tftpserver,
  String $backup_name,
  String $image_file,
){
  run_task('cisco_ios::cli_command', command => "copy startup-config tftp://${tftpserver}/${backup_name}")
  run_task('cisco_ios::cli_command', command => "delete bootflash:${image_file}\r")
  run_task('cisco_ios::cli_command', command => "copy tftp://${tftpserver}/${image_file} bootflash:")
  run_task('cisco_ios::config_save')
  run_task('cisco_ios::cli_command', command => 'reload\r')
}
