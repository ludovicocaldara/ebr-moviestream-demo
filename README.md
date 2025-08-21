# EBR MovieStream Demo
This repository contains a demo for the **Oracle Edition-Based Redefinition (EBR)** using the **moviestream** schema. It demonstrates how to deploy a new version of the schema while the application using the old schema is still running, and shows the two versions running simultaneously (blue-green deployment).

The demo is based on an **Always Free Autonomous Database Serverless** (available for free on Oracle Cloud Infrastructure).
It is executed from the Cloud Shell. The steps are executed one by one using tmux-vim-mappings available here: https://github.com/ludovicocaldara/misc-labs/tree/main/tmux-vim-mappings.

The `tmux` commands set up the console environment and go through some steps that include:

* The instantiation of the initial schema
* Some queries to show the current schema
* Starting the application (a very basic python script)
* Deploying the new schema version
* Restarting one of the two application instances

## Contents

* `terraform/`: Terraform scripts to provision the required Oracle Autonomous Database Serverless.
* `terraform/post-terraform.sh`: Script to execute after the stack is created. It downloads Oracle wallets and install the Oracle Instant Client.
* `initial_setup/`: The scripts that create the initial schema. It uses Oracle LiveLabs common data sets originally created by Marty Gubar.
* `insert_app/`: Two versions of the application using two schema versions.
* `changes/`: Directory containing Liquibase change sets for EBR, executed via SQLcl.
* `tmux-demo.txt`: Step-by-step demo instructions for use within a `tmux` session.

## Prerequisites

If you run the demo from Oracle Cloud Infrastructure Cloud Shell (RECOMMENDED):

* [tmux-vim-mappings](https://github.com/ludovicocaldara/misc-labs/tree/main/tmux-vim-mappings) (for tmux/vi integration)

If you run the demo from your laptop:

* [Terraform](https://www.terraform.io/downloads.html)
* [tmux](https://github.com/tmux/tmux)
* [vi/vim](https://www.vim.org/)
* [SQLcl](https://www.oracle.com/database/sqldeveloper/technologies/sqlcl/)
* [Python](https://www.python.org/downloads/)
* [tmux-vim-mappings](https://github.com/ludovicocaldara/misc-labs/tree/main/tmux-vim-mappings) (for tmux/vi integration)

## Setup Instructions

### 1. Provision the Always Free Terraform Stack

```sh
cd terraform
terraform init
terraform apply
```

Follow the prompts to deploy the stack in your Oracle Cloud account.

### 2. Run the Post-Terraform Script

After the infrastructure is provisioned, run:

export COMPARTMENT_OCID=<your_compartment_ocid>
```sh
./post-terraform.sh
```

This script will:

* Download the Oracle for the newly provisioned ADB.
* Download and install the Oracle Instant Client.
* Configure the network/admin directory to correctly resolve the TNS connect identifiers.
* Add the environment variables with the ADB password and LD_LIBRARY_PATH for the InstantClient.

### 3. Prepare the tmux Environment

Clone and configure the [tmux-vim-mappings](https://github.com/ludovicocaldara/misc-labs/tree/main/tmux-vim-mappings) repository as described in its documentation to enable tmux/vi integration.

## Demo Overview and Execution (`tmux-demo.txt`)

Open a `tmux` session in a Cloud Shell tab.

Open a `vi tmux-demo.txt` in another Cloud Shell tab.

The `tmux-demo.txt` file contains a sequence of commands and instructions designed to be executed interactively. When pressing `PgDown`, the command is sent automatically to the `tmux` session. That makes going through the demo very easy.