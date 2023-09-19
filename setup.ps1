#Run this command if no execution policy error : Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
#Util function 
function Write-Start {
	param ($msg)
	Write-Host (">> "+$msg) -ForegroundColor Green
}

function Write-Done {Write-Host "DONE" -ForegroundColor Blue; Write-Host}

Write-Start -msg "Installing Scoop..."
If (Get-Command scoop -errorAction SilentlyContinue)
{
	Write-Warning "Scoop already installed"
} 
else {
	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser 
	irm get.scoop.sh | iex
}
Write-Done

Write-Start -msg "Installing Scoop..."
	scoop install git
	#scoop bucket add extras
	#scoop bucket add nerd-fonts
	#scoop bucket add java
	scoop bucket add main
	#scoop bucket add versions
Write-Done

Write-Start -msg "Installing Scoop's packages"
	scoop install <# Coding #> vscode gcc python
Write-Done

Write-Start -msg "Configuring VSCode"
	code --install-extension ms-python.python --force
	code --install-extension ms-vscode.cpptools --force
	code --install-extension ritwickdey.LiveServer --force
	code --install-extension shalldie.background --force
	code --install-extension ms-dotnettools.csharp	--force
Write-Done

Write-Start -msg "Enable Virtualization"
Start-Process -Wait powershell -verb runas -ArgumentList@"
	echo y | Enalbe-WindowsOptionalFeature -Online -FeatureName -Microsoft-Hyper-V -All -Norestart
	echo y | Enalbe-WindowsOptionalFeature -Online -FeatureName -Microsoft-Windows-Sybsystem-Linex -All -Norestart
	echo y | Enalbe-WindowsOptionalFeature -Online -FeatureName -VirtualMachinePlatform -All
	echo y | Enalbe-WindowsOptionalFeature -Online -FeatureName Containers -All"@
Write-Done

Write-Start -msg "Installing WSL..."
If(!(wsl -l -v)){
	wsl --install 
	wsl --update
	wsl --install --no-launch --wed-download -d Ubuntu
}
Else {
	Write-Warning "WSL installed"
}
Write-Done
	