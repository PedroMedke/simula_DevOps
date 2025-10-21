variable "postgres_user" { default = "devops" }
variable "postgres_password" { default = "devops_pass" }
variable "postgres_db" { default = "devops_db" }
variable "api_image_name" { default = "devops-api:latest" }
variable "api_host_port" { default = 3000 }