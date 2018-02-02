cd ${env:HOMEPATH}\Downloads

Write-output "Installing Python..."
invoke-webrequest https://www.python.org/ftp/python/2.7.14/python-2.7.14.amd64.msi -outfile python-2.7.14.amd64.msi
start-process msiexec -ArgumentList "/i", "python-2.7.14.amd64.msi", "/quiet" -Wait

Write-output "Installing Firefox..."
invoke-webrequest "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US" -outfile firefox-setup.exe
Start-Process ./firefox-setup.exe -ArgumentList "-ms" -wait

Write-output "Installing geckodriver..."
invoke-webrequest https://github.com/mozilla/geckodriver/releases/download/v0.19.1/geckodriver-v0.19.1-win64.zip -outfile  geckodriver-v0.19.1-win64.zip
Expand-Archive geckodriver-v0.19.1-win64.zip -DestinationPath C:\python27

Write-output "Installing POTM..."
$potsfolder="C:\Player of the match"

New-Item -ItemType directory -Path ${potsfolder}
New-Item -ItemType directory -Path ${potsfolder}\input
New-Item -ItemType directory -Path ${potsfolder}\output
invoke-webrequest https://raw.githubusercontent.com/jpammerlaan/playerofthematch/master/run.py -outfile ${potsfolder}\run.py

cd C:\Python27

Write-output "Installing Installing python libraries..."
.\python.exe -m pip install webwhatsapi==1.0.3
.\python.exe -m pip install fuzzywuzzy

write-output "Finished"
write-output "Add folder ${potsfolder} to the path"