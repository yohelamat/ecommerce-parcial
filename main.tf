provider "google" {
  project = "parcial-ecommerce-26"
  region  = "us-central1"
}

# 1. Configuración de Red Virtual (VPC)
resource "google_compute_network" "red_ecommerce" {
  name                    = "vpc-ecommerce"
  auto_create_subnetworks = true
}

# 2. Base de datos gestionada Cloud SQL (MySQL)
resource "google_sql_database_instance" "bd_tienda" {
  name             = "mysql-ecommerce-db"
  database_version = "MYSQL_8_0"
  region           = "us-central1"
  root_password    = "AdminStartup2026!"
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = true
      private_network = google_compute_network.red_ecommerce.id
    }
  }
}

# 3. Servicio Serverless (Cloud Run)
resource "google_cloud_run_service" "app_ecommerce" {
  name     = "api-ecommerce"
  location = "us-central1"
  template {
    spec {
      containers {
        image = "gcr.io/parcial-ecommerce-26/api-ecommerce"
        env {
          name  = "DB_HOST"
          value = google_sql_database_instance.bd_tienda.private_ip_address
        }
      }
    }
  }
}