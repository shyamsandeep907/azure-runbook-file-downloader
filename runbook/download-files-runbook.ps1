# Azure Automation Runbook
# Download files from URLs and upload to Azure Blob Storage

Write-Output "Runbook started"

# Authenticate using Managed Identity
Connect-AzAccount -Identity

# -----------------------------
# Configuration
# -----------------------------
$storageAccountName = "Storageaccname"
$containerName      = "container"

# URLs to download
$urls = @(
"https://go.microsoft.com/fwlink/?LinkID=121721&arch=x64",
"https://go.microsoft.com/fwlink/?linkid=870379&arch=x64"
)

# -----------------------------
# Create Storage Context using Azure AD authentication
# -----------------------------
$ctx = New-AzStorageContext `
    -StorageAccountName $storageAccountName `
    -UseConnectedAccount

Write-Output "Connected to storage account: $storageAccountName"

# Counter for naming files
$i = 1

foreach ($url in $urls) {

    Write-Output "-----------------------------------"
    Write-Output "Processing URL: $url"

    # Generate safe filename
    $fileName = "download_$i.exe"

    # Temporary path in Automation sandbox
    $localPath = "$env:TEMP\$fileName"

    Write-Output "Downloading file to: $localPath"

    try {

        Invoke-WebRequest `
            -Uri $url `
            -OutFile $localPath `
            -UseBasicParsing

        if (Test-Path $localPath) {

            $fileSize = (Get-Item $localPath).Length

            Write-Output "Download successful"
            Write-Output "File size: $fileSize bytes"

        }
        else {

            Write-Output "Download failed. File not found."
            continue

        }

    }
    catch {

        Write-Output "Download failed for $url"
        Write-Output $_
        continue

    }

    # -----------------------------
    # Upload to Azure Blob Storage
    # -----------------------------

    try {

        Write-Output "Uploading $fileName to container $containerName"

        Set-AzStorageBlobContent `
            -File $localPath `
            -Container $containerName `
            -Blob $fileName `
            -Context $ctx `
            -Force

        Write-Output "Upload successful"

    }
    catch {

        Write-Output "Upload failed for $fileName"
        Write-Output $_

    }

    $i++

}

Write-Output "-----------------------------------"
Write-Output "Runbook completed successfully"
