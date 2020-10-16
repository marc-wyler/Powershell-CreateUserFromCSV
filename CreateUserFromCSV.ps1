#####
# Create User from CSV
# Files required:
# User.csv / ExampleGroup.csv / Maschinist.csv / Laborant.csv / Hilfspersonal.csv
# Create the Csv file in the notepad 
# First row: Username 
# Afterwards one username per row!
#####

#Paths
$ScriptDir = Split-Path $Script:MyInvocation.MyCommand.Path
$User = "\User.csv"
$ExampleGroup = "\ExampleGroup.csv"
$Password = "XXX" | ConvertTo-SecureString -AsPlainText -Force

# Add Users
$Path = $ScriptDir + $User 
Import-Csv $Path | Foreach-Object {
    $CheckNewUser = Get-LocalUser -Name $_.username -ErrorAction SilentlyContinue
    If (!$CheckNewUser){
        New-localuser -name $_.username -password $Password | Out-Null
        Write-Host "User" $_.username "created!"
    }
}

# Group XXX
$Path = $ScriptDir + $ExampleGroup
Import-Csv $Path | Foreach-Object {
    $CheckExampleGroup = Get-LocalGroupMember -Group "ExampleGroup" -Member $_.username -ErrorAction SilentlyContinue
    If (!$CheckExampleGroup){
        Add-LocalGroupMember -Group "ExampleGroup" -Member $_.username 
        Write-Host "Added User" $_.username "to Group ExampleGroup!"
    }
}



