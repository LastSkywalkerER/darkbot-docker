# Start VNC server
Start-Process -FilePath "C:\Program Files\TightVNC\tvnserver.exe" -ArgumentList "-service -controlapp -password darkbot"

# Wait for VNC server to start
Start-Sleep -Seconds 5

# Start darkbot
$javaPath = (Get-Command java).Source
Start-Process -FilePath $javaPath -ArgumentList "-jar C:\darkbot\darkbot.jar" -WorkingDirectory "C:\darkbot"

# Keep container running
while ($true) {
    Start-Sleep -Seconds 60
} 