
Write-Host
Write-Host Checking that the SDK archive is available in the current directory...
$sdkArchivePath = "Photon-OnPremise-Server-SDK_v*.exe"
if (-not (Test-Path $sdkArchivePath))
{
	# TODO display something to the user to explain how to download the SDK.
	#https://www.photonengine.com/Download/Photon-OnPremise-Server-Plugin-SDK_v4-0-29-11263.exe
	
	Write-Host
	Write-Host Please download the Photon Server SDK from https://www.photonengine.com
	exit;
}

Write-Host
Write-Host Checking that SDK has been decompressed...
$sdkDecompPath = Resolve-Path "Photon-OnPremise-Server-SDK_v*\deploy\"
if (-not (Test-Path $sdkDecompPath -PathType Container))
{
	Write-Host
	Write-Host Decompressing SDK...
	Start-Process -FilePath (resolve-path $sdkArchivePath) -ArgumentList @('-y') -Wait
}

Write-Host
Write-Host Building Docker Image...
docker build -t photonserver .

Write-Host
Write-Host Running Docker Container...
docker run -p 5055:5055/udp -p 5056:5056/udp -p 4530:4530 -p 4531:4531 -p 4520:4520 -p 843:843 -p 943:943 -p 9090:9090 -p 9091:9091 -i -t photonserver

# TODO run the star dust client to test the docker image.
# .\Photon-OnPremise-Server-SDK_v4-0-29-11263\deploy\bin_tools\stardust.client\Photon.StarDust.Client.exe
