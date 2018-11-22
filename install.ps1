cd ${env:HOMEPATH}\Downloads

#Enable TLS12, TLS11 and TLS
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

Write-output "Prior to running this script, install visual studio build tools from https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=15#"
$answer = Read-Host -Prompt "Type 'yes' when installation is completed"

if ($answer -ne "yes")
{
    Exit
}

Write-output "Installing Python..."
invoke-webrequest https://www.python.org/ftp/python/3.7.1/python-3.7.1-amd64.exe -outfile python-3.7.1-amd64.exe
start-process python-3.7.1-amd64.exe -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1" -Wait

Write-output "Installing Firefox..."
invoke-webrequest "https://ftp.mozilla.org/pub/firefox/releases/59.0.3/win64/en-US/Firefox%20Setup%2059.0.3.exe" -outfile firefox-setup.exe
Start-Process ./firefox-setup.exe -ArgumentList "-ms" -wait

Write-output "Installing geckodriver..."
invoke-webrequest https://github.com/mozilla/geckodriver/releases/download/v0.23.0/geckodriver-v0.23.0-win64.zip -outfile  geckodriver-v0.23.0-win64.zip
Expand-Archive geckodriver-v0.23.0-win64.zip -DestinationPath "C:\Program Files\Python37"

Write-output "Installing POTM..."
$potsfolder="C:\Player of the match"

New-Item -ItemType directory -Path ${potsfolder}
New-Item -ItemType directory -Path ${potsfolder}\input
New-Item -ItemType directory -Path ${potsfolder}\output
invoke-webrequest https://raw.githubusercontent.com/jpammerlaan/playerofthematch/master/run.py -outfile ${potsfolder}\run.py

cd "C:\Program Files\Python37"

Write-output "Installing  python libraries..."
.\python.exe -m pip install webwhatsapi
.\python.exe -m pip install fuzzywuzzy

Write-Output "Patching webwhatsapi"
invoke-webrequest "https://raw.githubusercontent.com/mukulhase/WebWhatsapp-Wrapper/master/webwhatsapi/js/wapi.js" -OutFile "C:\Program Files\Python37\Lib\site-packages\webwhatsapi\js\wapi.js"

write-output "Finished"
write-output "Add folder ${potsfolder} to the path"