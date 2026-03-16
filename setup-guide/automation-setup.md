# Azure Automation Runbook Setup Guide

## Overview

This guide explains how to configure Azure resources required to download files from external URLs using an Azure Automation Runbook and upload them to Azure Blob Storage.

Services used:

* Azure Automation
* Azure Blob Storage
* Managed Identity
* PowerShell Runbooks

---

# Step 1 – Create Storage Account

1. Open Azure Portal.
2. Search for **Storage Accounts**.
3. Click **Create**.
4. Provide the following details:

Example configuration:

Resource Group: Automationtesting
Storage Account Name: adls2foradf
Region: Choose your region
Performance: Standard
Replication: LRS

5. Click **Review + Create**.

---

# Step 2 – Create Blob Container

1. Open the Storage Account.
2. Navigate to:

Data Storage → Containers

3. Click **+ Container**.

Example:

Container Name: downloads
Public Access Level: Private

4. Click **Create**.

---

# Step 3 – Create Azure Automation Account

1. In Azure Portal search for **Automation Accounts**.
2. Click **Create**.
3. Provide configuration:

Example:

Automation Account Name: automation-runbook-demo
Resource Group: Automationtesting
Region: Same region as storage account

4. Click **Review + Create**.

---

# Step 4 – Enable System Assigned Managed Identity

Managed Identity allows the runbook to authenticate securely without storing credentials.

Steps:

1. Open the Automation Account.
2. Navigate to:

Account Settings → Identity

3. Under **System Assigned**:

Status: ON

4. Click **Save**.

Azure will create an identity in Azure Active Directory.

---

# Step 5 – Assign Storage Permissions

The Automation Account identity must have permission to upload files to Blob Storage.

Steps:

1. Open the Storage Account.
2. Go to:

Access Control (IAM)

3. Click:

Add → Add Role Assignment

Assign the following roles.

Role 1:
Storage Blob Data Contributor

Role 2:
Reader

Assign access to:

Managed Identity → Automation Account

Select your Automation Account and click **Review + Assign**.

Wait a few minutes for role assignment to propagate.

---

# Step 6 – Install Required PowerShell Modules

Automation runbooks require Azure PowerShell modules.

Steps:

1. Open the Automation Account.
2. Navigate to:

Shared Resources → Modules

3. Click:

Browse Gallery

Install the following modules.

Required modules:

Az.Accounts
Az.Storage

These modules enable authentication and storage operations.

---

# Step 7 – Create Runbook

Steps:

1. Open Automation Account.
2. Navigate to:

Process Automation → Runbooks

3. Click:

Create Runbook

Provide configuration:

Runbook Name: download-files-runbook
Runbook Type: PowerShell
Runtime Version: PowerShell 7

Click **Create**.

---

# Step 8 – Add Runbook Script

Paste the PowerShell script that downloads files from URLs and uploads them to Blob Storage.

After pasting the script:

1. Click **Save**.
2. Use **Test Pane** to validate execution.

---

# Step 9 – Publish Runbook

Once testing is successful:

1. Click **Publish**.
2. The runbook is now available for production execution.

---

# Step 10 – Optional: Create Schedule

Runbooks can be executed automatically.

Steps:

Runbook → Link to Schedule → Create Schedule

Example:

Daily file download job.

---

# Validation

After running the runbook, verify the files in Blob Storage.

Storage Account → Containers → downloads

Downloaded files should appear in the container.

---

# Notes

Azure Automation runbooks execute inside a sandbox environment.

Temporary files are stored in:

$env:TEMP

Example runtime path:

C:\Users\ContainerUser\AppData\Local\Temp

These files exist only during runbook execution and are automatically cleaned up afterwards.

---

# Summary

This setup enables automated file downloads from external URLs using Azure Automation Runbooks and uploads them to Azure Blob Storage securely using Managed Identity authentication.
