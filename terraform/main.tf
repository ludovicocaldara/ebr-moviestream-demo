# Copyright (c) 2021, Oracle and/or its affiliates. All rights reserved
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# -------------------------
# Setup the OCI provider...
# -------------------------
provider "oci" {
}

# -------------------------
# Random Passwords
# -------------------------
variable "compartment_ocid" {
  description = "The OCID of the compartment you want to work with." 
}
resource "random_password" "adb_wallet_password" {
  length           = 10
  special          = false
  numeric           = true
  upper            = true
  lower            = true
  override_special = "_%@+!"
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
}

resource "random_password" "adb_password" {
  length           = 20
  special          = true
  numeric           = true
  upper            = true
  lower            = true
  override_special = "_%@+!"
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
  min_upper        = 2
}

# -------------------------
# Autonomous Database
# -------------------------
resource "oci_database_autonomous_database" "demo_adb" {
    compartment_id           = var.compartment_ocid
    db_name                  = "demoadb"
    is_free_tier             = true
    cpu_core_count           = 1
    data_storage_size_in_tbs = 1
    admin_password           = random_password.adb_password.result
}

output "adb" {
  value = format("Your Autonomous Database is ready with sql_web address: %s", oci_database_autonomous_database.demo_adb.connection_urls[0].sql_dev_web_url)
}

output "adb_password" {
  value = format("Get the Autonomous Database password with: echo 'nonsensitive(random_password.adb_password.result)' | terraform console")
}

output "adb_wallet_password" {
  value = format("Get the Autonomous Database wallet password with: echo 'nonsensitive(random_password.adb_wallet_password.result)' | terraform console")
}


