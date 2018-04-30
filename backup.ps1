function Backup-Files ($outputPath, $folders) {

    $f = $folders.split(' ')
    $f | ForEach-Object {
         write-host "Backing up folder [" $_ "]"
         
         $rootfolder = ""
         $rootfolderpath = $_.split('\')

         for ($i = 1; $i -ilt $rootfolderpath.length; $i++) 
         {
            $rootfolder = -join ($rootfolder, $rootfolderpath[$i], "/") 
         }

         $rootbackupfolder= $outputPath + "\" + $rootfolder
         if(!(Test-Path -Path $rootbackupfolder )){
            New-Item -ItemType directory -Path $rootbackupfolder
         }

         robocopy /E /MIR /ETA $_ $rootbackupfolder

         write-host "Folder [" $_ "] backup succesfull!"
    }
}


function Print-Information{
    write-host ""
    write-host "------------------//------------------"
    write-host ""

    write-host "########################################"
    write-host "########## Simple Backup Task ##########"
    write-host "########################################"

    write-host ""
    write-host "Created by: Henrique Dal Bello Batista"
    write-host "Version: 1.0.0"
    write-host "License: GPL 3.0"
    write-host ""
    write-host "Feel free to clone, fork and/or distribute/use"
    write-host "GitHub: https://github.com/Rickedb/SimpleBackupTask"

    write-host ""
    write-host "------------------//------------------"
    write-host ""
}