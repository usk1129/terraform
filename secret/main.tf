provider "aws" {
  region = "us-east-1"
}

provider "vault" {
    auth_login {
      path = auth /userpass / login/ varusername
      parameters = {
          password = var.password
      }
    }
}


# stored in aws cli or env variable
data "vault_generic_secret" "dbuser" {
    path = "secret/dbuser"
}

data "vault_generic_secret" "dbpassword" {
    path = "secret/dbpassword"
}

resource "aws_db_instance" "myRDS" {
    name = "mydb"
    identifier = "my-first-rds"
    instance_class = "db.t2.micro"
    engine = "mariadb"
    engine_version = "10.2.21"
    username = data.dbuser.data["value"]
    password = data.dbpassword.data["value"]
    port = 3306
    allocated_storage = 20
    skip_final_snapshot = true
  
}