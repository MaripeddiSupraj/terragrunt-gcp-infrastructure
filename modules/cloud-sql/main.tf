resource "google_sql_database_instance" "main" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region
  project          = var.project_id

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_type         = var.disk_type

    backup_configuration {
      enabled    = var.backup_enabled
      start_time = var.backup_start_time
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_network
    }
  }

  deletion_protection = var.deletion_protection

  depends_on = [var.private_network]
}

resource "google_sql_database" "databases" {
  for_each = { for db in var.databases : db.name => db }
  name     = each.value.name
  instance = google_sql_database_instance.main.name
  charset  = each.value.charset
  collation = each.value.collation
  project  = var.project_id
}

resource "google_sql_user" "users" {
  for_each = { for user in var.users : user.name => user }
  name     = each.value.name
  instance = google_sql_database_instance.main.name
  password = each.value.password
  project  = var.project_id
}