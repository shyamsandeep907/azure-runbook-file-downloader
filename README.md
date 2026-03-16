# Azure Automation Runbook – File Downloader

## Overview

This repository demonstrates how to download files from external URLs using Azure Automation Runbooks and upload them to Azure Blob Storage.

## Architecture

External URL → Azure Automation Runbook → Temporary Sandbox → Azure Blob Storage

## Azure Services Used

* Azure Automation
* Azure Blob Storage
* Managed Identity
* PowerShell Runbooks

## Repository Contents

| Folder          | Description                      |
| --------------- | -------------------------------- |
| runbook         | PowerShell runbook script        |
| setup-guide     | Step-by-step Azure configuration |
| troubleshooting | Errors encountered and solutions |
| architecture    | Architecture explanation         |

## Key Features

* Managed Identity authentication
* Azure AD storage access
* Automated file downloads
* Error handling
* Logging

## Use Cases

* Automated data ingestion
* Downloading external reports
* Scheduled file collection

