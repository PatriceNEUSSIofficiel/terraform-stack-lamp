provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "kubernetes_deployment" "mysql_deployment" {
  metadata {
    name = "mysql"
    namespace = "patrice"
  }
  spec {
    selector {
      match_labels = {
        app = "mysql"
      }
    }
    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }
      spec {
        container {
          name  = "mysql"
          image = "mysql:latest"

          env {
            name = "PMA_USER"
            value = "root"
          }

          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = "redhat"
          }

          port {
            container_port = 3306
            name           = "mysql"
          }
        }
        node_name = "master"
      }
    }
  }
}


resource "kubernetes_service" "mysql_service" {

  depends_on = [ kubernetes_deployment.mysql_deployment ]
  metadata {
    name      = "mysql-service"
    namespace = "patrice"
  }
  spec {

    selector = {
      app = "mysql-service"
    }
    port {
      port        = 3306
      target_port = 3306
    }
  }
}

# Création du déploiement phpMyAdmin

resource "kubernetes_deployment" "phpmyadmin_deployment" {
  metadata {
    name      = "phpmyadmin"
    namespace = "patrice"
  }

  spec {
    selector {
      match_labels = {
        app = "phpmyadmin"
      }
    }

    template {
      metadata {
        labels = {
          app = "phpmyadmin"
        }
      }

      spec {
        container {
          name = "phpmyadmin"
          image = "phpmyadmin:latest"


          env {
            name  = "PMA_HOST"
            value = "mysql-service"
          }
        }
         node_name = "master"
      }
    }
  }
}

# Création du service phpMyAdmin

resource "kubernetes_service" "phpmyadmin_service" {
  depends_on = [ kubernetes_deployment.phpmyadmin_deployment ]
  metadata {
    name      = "phpmyadmin-service"
    namespace ="patrice"
  }

  spec {
    selector = {
      app = "phpmyadmin"
    }
    type     = "NodePort"
    port {
      port        = 80
      target_port = 80
      node_port = 30500
    }
    
  }
  
}


