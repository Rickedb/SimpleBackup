$config = Get-Content  $PSScriptRoot\config.json | ConvertFrom-Json 
if($config.AskBeforeBackup){
  $ans = Read-Host "Its time to make a backup, may I[Y/N]"
  
  if ($ans -eq "N") 
  {
      exit
  }
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
write-host "Checking for updates..."

$updatedFile = $PSScriptRoot+"\updatedbackup.ps1";
$currentFile = $PSScriptRoot+"\backup.ps1"

$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile("https://raw.githubusercontent.com/Rickedb/SimpleBackupTask/master/backup.ps1", $updatedFile)

if(Compare-Object -ReferenceObject $(Get-Content $currentFile) -DifferenceObject $(Get-Content $updatedFile))
{
    write-host "Updating files..."
    Remove-Item $currentFile
    Rename-Item $updatedFile $currentFile
}
else{
    Write-Host "No updates available!"
}

.$currentFile
Print-Information
write-host "Output path: " $config.OutputPath
Write-Host "Folders to backup:" 
$f = $config.Folders.split(' ')
$f | ForEach-Object {
     write-host "-"$_
}

Backup-Files $config.OutputPath $config.Folders

write-host "Backup done!"

Print-Information