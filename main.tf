provider "kubernetes" {
  config_path    = "~/.kube/config"
}


module "apache_deployment" {
  source = "./modules/apache"
}


module "mysql_deployment" {
source = "./modules/mysql"
}
